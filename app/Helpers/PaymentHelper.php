<?php


if (!function_exists('formatPrice')) {
    /**
     * Format the display price
     *
     * @param $price
     * @param $symbol
     * @param $position
     * @return string
     */
    function formatPrice($price, $symbol, $position)
    {
        return $position == 'right' ? "{$price}{$symbol}" : "{$symbol}{$price}";
    }
}
