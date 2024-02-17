<?php


namespace App\Settings;

use Spatie\LaravelSettings\Settings;

class ThemeSettings extends Settings
{
    public string $primary_color;
    public string $secondary_color;
    public string $default_font;
    public string $default_font_url;

    public static function group(): string
    {
        return 'theme';
    }
}
