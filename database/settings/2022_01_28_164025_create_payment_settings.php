<?php

use Spatie\LaravelSettings\Migrations\SettingsMigration;

class CreatePaymentSettings extends SettingsMigration
{
    public function up(): void
    {
        $this->migrator->add('payments.default_payment_processor', 'bank');
        $this->migrator->add('payments.default_currency', 'USD');
        $this->migrator->add('payments.currency_symbol', '$');
        $this->migrator->add('payments.currency_symbol_position', 'left');
    }
}
