<?php

use Spatie\LaravelSettings\Migrations\SettingsMigration;

class CreateLicenseSettings extends SettingsMigration
{
    public function up(): void
    {
        $this->migrator->add('license.purchase_code', 'NO_PURCHASE_CODE');
        $this->migrator->add('license.activation_key', 'NO_ACTIVATION_KEY');
    }
}
