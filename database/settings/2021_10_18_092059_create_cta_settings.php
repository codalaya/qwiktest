<?php

use Spatie\LaravelSettings\Migrations\SettingsMigration;

class CreateCtaSettings extends SettingsMigration
{
    public function up(): void
    {
        $this->migrator->add('cta.title', 'Unlock all Online Test Series');
        $this->migrator->add('cta.subtitle', 'Starts $49/Month');
        $this->migrator->add('cta.button_text', 'Buy Now');
        $this->migrator->add('cta.button_link', '#');
    }
}
