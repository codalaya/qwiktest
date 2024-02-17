<?php

use Spatie\LaravelSettings\Migrations\SettingsMigration;

class ModifyHomePageHeroSettings extends SettingsMigration
{
    public function up(): void
    {
        $this->migrator->rename('home_page.hero_title', 'hero.title');
        $this->migrator->rename('home_page.hero_subtitle', 'hero.subtitle');
        $this->migrator->rename('home_page.hero_cta_text', 'hero.cta_text');
        $this->migrator->rename('home_page.hero_image_path', 'hero.image_path');
        $this->migrator->add('hero.cta_link', '#');
        $this->migrator->add('home_page.enable_top_bar', true);
        $this->migrator->add('home_page.enable_hero', true);
        $this->migrator->add('home_page.enable_features', true);
        $this->migrator->add('home_page.enable_categories', true);
        $this->migrator->add('home_page.enable_stats', true);
        $this->migrator->add('home_page.enable_testimonials', true);
        $this->migrator->add('home_page.enable_cta', true);
        $this->migrator->add('home_page.enable_footer', true);
        $this->migrator->add('home_page.enable_search', true);
        $this->migrator->add('site.white_logo_path', 'site/logo_white.png');
        $this->migrator->add('localization.default_direction', 'ltr');
    }
}
