<?php

use Spatie\LaravelSettings\Migrations\SettingsMigration;

class CreateCategorySettings extends SettingsMigration
{
    public function up(): void
    {
        $this->migrator->add('category.title', 'Comprehensive learning programs for all students');
        $this->migrator->add('category.subtitle', 'Become lifelong learners with the best teachers, engaging video lessons and personalised learning journeys');
        $this->migrator->add('category.limit', 8);
    }
}
