<?php


namespace App\Settings;

use Spatie\LaravelSettings\Settings;

class TaxSettings extends Settings
{
    public bool $enable_tax;
    public string $tax_name;
    public string $tax_type;
    public string $tax_amount_type;
    public float $tax_amount;
    public bool $enable_additional_tax;
    public string $additional_tax_name;
    public string $additional_tax_type;
    public string $additional_tax_amount_type;
    public float $additional_tax_amount;

    public static function group(): string
    {
        return 'tax';
    }
}
