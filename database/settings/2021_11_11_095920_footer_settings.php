<?php

use Spatie\LaravelSettings\Migrations\SettingsMigration;

class FooterSettings extends SettingsMigration
{
    public function up(): void
    {
        $this->migrator->add('footer.copyright_text', 'All rights reserved.');
        $this->migrator->add('footer.enable_links', true);
        $this->migrator->add('footer.footer_links', [
            ['About', '#', true],
            ['Features', '#', true],
            ['Pricing', '#', true],
            ['Help', '#', true],
            ['Disclaimer', '#', true],
            ['Privacy Policy', '#', true]
        ]);
        $this->migrator->add('footer.enable_social_links', true);
        $this->migrator->add('footer.social_links', [
            'facebook' => ['Facebook', true, '#'],
            'twitter' => ['Twitter', true, '#'],
            'youtube' => ['Youtube', true, '#'],
            'instagram' => ['Instagram', true, '#'],
            'linkedin' => ['LinkedIn', true, '#'],
            'github' => ['GitHub', true, '#'],
        ]);
    }
}
