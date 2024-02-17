<?php


namespace App\Repositories;


use App\Settings\HeroSettings;
use App\Settings\HomePageSettings;
use App\Settings\SiteSettings;
use Illuminate\Http\UploadedFile;

class SettingsRepository
{
    /**
     * Upload Site Logo
     *
     * @param UploadedFile $logo
     */
    public function updateSiteLogo(UploadedFile $logo)
    {
        $settings = app(SiteSettings::class);
        tap($settings->logo_path, function ($previous) use ($logo, $settings) {
            $settings->logo_path = $logo->storePubliclyAs(
                'site', 'logo.'.$logo->clientExtension(), ['disk' => 'public']
            );
            $settings->save();
        });
    }

    /**
     * Upload White Logo
     *
     * @param UploadedFile $logo
     */
    public function updateWhiteLogo(UploadedFile $logo)
    {
        $settings = app(SiteSettings::class);
        tap($settings->white_logo_path, function ($previous) use ($logo, $settings) {
            $settings->white_logo_path = $logo->storePubliclyAs(
                'site', 'logo_white.'.$logo->clientExtension(), ['disk' => 'public']
            );
            $settings->save();
        });
    }

    /**
     * Upload Site Favicon
     *
     * @param UploadedFile $favicon
     */
    public function updateFavicon(UploadedFile $favicon)
    {
        $settings = app(SiteSettings::class);
        tap($settings->favicon_path, function ($previous) use ($favicon, $settings) {
            $settings->favicon_path = $favicon->storePubliclyAs(
                'site', 'favicon.'.$favicon->clientExtension(), ['disk' => 'public']
            );
            $settings->save();
        });
    }

    /**
     * Upload Site Hero Image
     *
     * @param UploadedFile $image
     */
    public function updateHeroImage(UploadedFile $image)
    {
        $settings = app(HeroSettings::class);
        tap($settings->image_path, function ($previous) use ($image, $settings) {
            $settings->image_path = $image->storePubliclyAs(
                'site', 'hero_image.'.$image->clientExtension(),  ['disk' => 'public']
            );
            $settings->save();
        });
    }

}
