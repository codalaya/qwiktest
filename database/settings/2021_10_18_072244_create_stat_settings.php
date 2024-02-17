<?php

use Spatie\LaravelSettings\Migrations\SettingsMigration;

class CreateStatSettings extends SettingsMigration
{
    public function up(): void
    {
        $this->migrator->add('stats.title', 'Students love using QwikTest');
        $this->migrator->add('stats.subtitle', '25,000+ Happy students');
        $this->migrator->add('stats.stat1', ['9,55,878+', 'Questions Practiced']);
        $this->migrator->add('stats.stat2',  ['1,13,540+', 'Tests Taken']);
        $this->migrator->add('stats.stat3',  ['1,78,658+', 'Videos Viewed']);
    }
}
