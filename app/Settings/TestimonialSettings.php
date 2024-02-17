<?php


namespace App\Settings;

use Spatie\LaravelSettings\Settings;

class TestimonialSettings extends Settings
{
    public string $title;
    public string $subtitle;
    public array $testimonial1;
    public array $testimonial2;

    public static function group(): string
    {
        return 'testimonials';
    }
}
