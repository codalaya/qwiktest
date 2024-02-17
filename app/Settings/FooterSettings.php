<?php


namespace App\Settings;

use Spatie\LaravelSettings\Settings;

class FooterSettings extends Settings
{
    public string $copyright_text;
    public bool $enable_links;
    public array $footer_links;
    public bool $enable_social_links;
    public array $social_links;

    public static function group(): string
    {
        return 'footer';
    }
}
