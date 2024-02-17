<?php

use Spatie\LaravelSettings\Migrations\SettingsMigration;

class CreateTestimonialSettings extends SettingsMigration
{
    public function up(): void
    {
        $this->migrator->add('testimonials.title', 'Our students and parents love us');
        $this->migrator->add('testimonials.subtitle', 'Hear it directly from our students');
        $this->migrator->add('testimonials.testimonial1', ['Sarah Meyer', 'GMAT Aspirant', 'Mock tests on QwikTest helped me develop my exam strategy. I was able to focus on my shortcomings and improve them!', 'https://ui-avatars.com/api/?name=Sarah+Meyer']);
        $this->migrator->add('testimonials.testimonial2',  ['Vijay Shah', 'Class 12 Student', 'QwikTest helped me get AIR 1 in KCET and AIR 105 in NEET. Thank you QwikTest!', 'https://ui-avatars.com/api/?name=Vijay+Shah']);
    }
}
