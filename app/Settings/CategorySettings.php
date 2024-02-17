<?php


namespace App\Settings;

use Spatie\LaravelSettings\Settings;

class CategorySettings extends Settings
{
    public string $title;
    public string $subtitle;
    public int $limit;

    public static function group(): string
    {
        return 'category';
    }
}
