<?php

use Spatie\LaravelSettings\Migrations\SettingsMigration;

class CreateTopBarSettings extends SettingsMigration
{
    public function up(): void
    {
        $this->migrator->add('top_bar.message', 'Top bar message here');
        $this->migrator->add('top_bar.button_text', 'Details');
        $this->migrator->add('top_bar.button_link', '#');
    }
}
