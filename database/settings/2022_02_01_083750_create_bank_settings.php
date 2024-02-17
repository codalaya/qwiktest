<?php

use Spatie\LaravelSettings\Migrations\SettingsMigration;

class CreateBankSettings extends SettingsMigration
{
    public function up(): void
    {
        $this->migrator->add('payments.enable_bank', false);
        $this->migrator->add('bank.bank_name', '-');
        $this->migrator->add('bank.account_owner', '-');
        $this->migrator->add('bank.account_number', '-');
        $this->migrator->add('bank.iban', '-');
        $this->migrator->add('bank.routing_number', '-');
        $this->migrator->add('bank.bic_swift', '-');
        $this->migrator->add('bank.other_details', '-');
    }
}
