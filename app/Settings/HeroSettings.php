<?php


namespace App\Settings;

use Spatie\LaravelSettings\Settings;

class HeroSettings extends Settings
{
    public string $title;
    public string $subtitle;
    public string $cta_text;
    public string $cta_link;
    public string $image_path;

    public static function group(): string
    {
        return 'hero';
    }
}
