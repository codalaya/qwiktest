<?php

use Spatie\LaravelSettings\Migrations\SettingsMigration;

class CreateThemeSettings extends SettingsMigration
{
    public function up(): void
    {
        $this->migrator->add('theme.primary_color', '32064a');
        $this->migrator->add('theme.secondary_color', 'e56b1f');
        $this->migrator->add('theme.default_font', 'Inter');
        $this->migrator->add('theme.default_font_url', 'https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap');
    }
}
