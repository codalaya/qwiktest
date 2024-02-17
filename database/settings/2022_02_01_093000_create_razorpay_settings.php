<?php

use Spatie\LaravelSettings\Migrations\SettingsMigration;

class CreateRazorpaySettings extends SettingsMigration
{
    public function up(): void
    {
        $this->migrator->add('payments.enable_razorpay', false);
        $this->migrator->add('razorpay.key_id', 'RZP_KEY_ID_HERE');
        $this->migrator->add('razorpay.key_secret', 'RZP_KEY_SECRET_HERE');
        $this->migrator->add('razorpay.webhook_url', 'webhooks/razorpay');
        $this->migrator->add('razorpay.webhook_secret', 'RZP_WEBHOOK_SECRET_HERE');
    }
}
