<?php


namespace App\Settings;

use Spatie\LaravelSettings\Settings;

class StatSettings extends Settings
{
    public string $title;
    public string $subtitle;
    public array $stat1;
    public array $stat2;
    public array $stat3;

    public static function group(): string
    {
        return 'stats';
    }
}
