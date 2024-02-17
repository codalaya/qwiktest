<?php

use Spatie\LaravelSettings\Migrations\SettingsMigration;

class CreateTaxSettings extends SettingsMigration
{
    public function up(): void
    {
        $this->migrator->add('tax.enable_tax', false);
        $this->migrator->add('tax.tax_name', 'VAT');
        $this->migrator->add('tax.tax_type', 'exclusive');
        $this->migrator->add('tax.tax_amount_type', 'percentage');
        $this->migrator->add('tax.tax_amount', 5);
        $this->migrator->add('tax.enable_additional_tax', false);
        $this->migrator->add('tax.additional_tax_name', 'Platform Charges');
        $this->migrator->add('tax.additional_tax_type', 'exclusive');
        $this->migrator->add('tax.additional_tax_amount_type', 'fixed');
        $this->migrator->add('tax.additional_tax_amount', 2);
    }
}
