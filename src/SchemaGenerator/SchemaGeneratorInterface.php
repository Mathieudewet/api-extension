<?php

declare(strict_types=1);

/*
 * This file is part of the ApiExtension package.
 *
 * (c) Vincent Chalamon <vincentchalamon@gmail.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace ApiExtension\SchemaGenerator;

/**
 * @author Vincent Chalamon <vincentchalamon@gmail.com>
 */
interface SchemaGeneratorInterface
{
    public function supports(\ReflectionClass $reflectionClass, array $context = []): bool;

    public function generate(\ReflectionClass $reflectionClass, array $context = []): array;
}
