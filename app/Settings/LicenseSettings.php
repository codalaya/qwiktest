<?php


namespace App\Settings;

use Spatie\LaravelSettings\Settings;

class LicenseSettings extends Settings
{
    public string $purchase_code;
    public string $activation_key;

    public static function group(): string
    {
        return 'license';
    }
}
