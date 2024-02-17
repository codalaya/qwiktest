<?php


namespace App\Settings;

use Spatie\LaravelSettings\Settings;

class TopBarSettings extends Settings
{
    public string $message;
    public string $button_text;
    public string $button_link;

    public static function group(): string
    {
        return 'top_bar';
    }
}
