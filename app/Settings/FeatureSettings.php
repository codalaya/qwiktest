<?php


namespace App\Settings;

use Spatie\LaravelSettings\Settings;

class FeatureSettings extends Settings
{
    public string $title;
    public string $subtitle;
    public array $feature1;
    public array $feature2;
    public array $feature3;
    public array $feature4;

    public static function group(): string
    {
        return 'features';
    }
}
