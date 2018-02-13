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

namespace ApiExtension\Transformer;

/**
 * @author Vincent Chalamon <vincentchalamon@gmail.com>
 */
final class BooleanTransformer implements TransformerInterface
{
    public function supports(string $property, array $mapping, $value): bool
    {
        return 'boolean' === $mapping['type'];
    }

    public function transform(string $property, array $mapping, $value): bool
    {
        return 'true' === $value;
    }
}
