<?php

/*
 * This file is part of the API Extension project.
 *
 * (c) Vincent Chalamon <vincentchalamon@gmail.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

declare(strict_types=1);

namespace ApiExtension\SchemaGenerator;

use ApiExtension\Helper\ApiHelper;
use ApiExtension\Populator\Populator;
use ApiExtension\SchemaGenerator\TypeGenerator\TypeGeneratorInterface;
use ApiPlatform\Core\Metadata\Resource\Factory\ResourceMetadataFactoryInterface;
use Doctrine\Common\Persistence\ManagerRegistry;
use Symfony\Component\PropertyInfo\PropertyInfoExtractorInterface;

/**
 * @author Vincent Chalamon <vincentchalamon@gmail.com>
 */
final class ObjectSchemaGenerator implements SchemaGeneratorInterface, SchemaGeneratorAwareInterface
{
    use SchemaGeneratorAwareTrait;

    /**
     * @var ResourceMetadataFactoryInterface
     */
    private $metadataFactory;

    /**
     * @var PropertyInfoExtractorInterface
     */
    private $propertyInfo;

    /**
     * @var ManagerRegistry
     */
    private $registry;
    private $helper;
    private $populator;
    private $typeGenerator;

    public function __construct(ApiHelper $helper, Populator $populator, TypeGeneratorInterface $typeGenerator)
    {
        $this->helper = $helper;
        $this->populator = $populator;
        $this->typeGenerator = $typeGenerator;
    }

    public function setMetadataFactory(ResourceMetadataFactoryInterface $metadataFactory): void
    {
        $this->metadataFactory = $metadataFactory;
    }

    public function setPropertyInfo(PropertyInfoExtractorInterface $propertyInfo): void
    {
        $this->propertyInfo = $propertyInfo;
    }

    public function setRegistry(ManagerRegistry $registry): void
    {
        $this->registry = $registry;
    }

    public function supports(\ReflectionClass $reflectionClass, array $context = []): bool
    {
        return false === ($context['collection'] ?? false) && false === ($context['root'] ?? false);
    }

    public function generate(\ReflectionClass $reflectionClass, array $context = []): array
    {
        $className = $reflectionClass->getName();
        $schema = [
            'type' => 'object',
            'properties' => [
                '@id' => [
                    'type' => 'string',
                    'pattern' => sprintf('^%s$', $this->helper->getItemUriPattern($reflectionClass)),
                ],
                '@type' => [
                    'type' => 'string',
                    'pattern' => sprintf('^%s$', $reflectionClass->getShortName()),
                ],
            ],
            'required' => ['@id', '@type'],
        ];

        $context = $context + [
            'serializer_groups' => $this->metadataFactory->create($className)->getItemOperationAttribute('get', 'normalization_context', [], true)['groups'] ?? [],
        ];
        foreach ($this->propertyInfo->getProperties($className, $context) as $property) {
            $mapping = $this->populator->getMapping($this->registry->getManagerForClass($className)->getClassMetadata($className), $property);
            $schema['properties'][$property] = $this->typeGenerator->generate($property, $mapping, $context);
            if (false === ($mapping['nullable'] ?? true)) {
                $schema['required'][] = $property;
            }
            if (null !== ($description = $this->propertyInfo->getShortDescription($className, $property))) {
                $schema['properties'][$property]['description'] = $description;
            }
        }

        return $schema;
    }
}
