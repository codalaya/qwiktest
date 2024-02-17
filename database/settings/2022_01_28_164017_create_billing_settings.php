<?php

use Spatie\LaravelSettings\Migrations\SettingsMigration;

class CreateBillingSettings extends SettingsMigration
{
    public function up(): void
    {
        $this->migrator->add('billing.vendor_name', 'QwikTest');
        $this->migrator->add('billing.invoice_prefix', 'INVOICE');
        $this->migrator->add('billing.address', '-');
        $this->migrator->add('billing.city', '-');
        $this->migrator->add('billing.state', '-');
        $this->migrator->add('billing.zip', '-');
        $this->migrator->add('billing.country', '-');
        $this->migrator->add('billing.phone_number', '-');
        $this->migrator->add('billing.vat_number', '-');
        $this->migrator->add('billing.enable_invoicing', false);
    }
}
