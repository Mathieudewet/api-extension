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

namespace ApiExtension\Populator\Guesser;

/**
 * @author Vincent Chalamon <vincentchalamon@gmail.com>
 */
class BooleanGuesser extends AbstractGuesser
{
    public function supports(array $mapping): bool
    {
        return 'boolean' === $mapping['type'];
    }

    public function getValue(array $mapping): bool
    {
        return true;
    }
}
