<?php


namespace App\Settings;

use Spatie\LaravelSettings\Settings;

class CtaSettings extends Settings
{
    public string $title;
    public string $subtitle;
    public string $button_text;
    public string $button_link;

    public static function group(): string
    {
        return 'cta';
    }
}
