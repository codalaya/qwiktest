<?php

namespace App\Http\Middleware;

use App\Settings\LocalizationSettings;
use App\Settings\SiteSettings;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cookie;
use Inertia\Middleware;
use Jenssegers\Agent\Agent;

class HandleInertiaRequests extends Middleware
{
    /**
     * The root template that's loaded on the first page visit.
     *
     * @see https://inertiajs.com/server-side-setup#root-template
     * @var string
     */
    protected $rootView = 'app';

    /**
     * Determines the current asset version.
     *
     * @see https://inertiajs.com/asset-versioning
     * @param  \Illuminate\Http\Request  $request
     * @return string|null
     */
    public function version(Request $request)
    {
        return parent::version($request);
    }

    /**
     * Defines the props that are shared by default.
     *
     * @see https://inertiajs.com/shared-data
     * @param \Illuminate\Http\Request $request
     * @return array
     * @throws \Exception
     */
    public function share(Request $request)
    {
        $agent = new Agent();
        $settings = app(SiteSettings::class);
        return array_merge(parent::share($request), [
            'general' => config('qwiktest.version') == "1.4.0" ? $settings->toArray() : [],
            'canLogin' => \Route::has('login'),
            'canResetPassword' => \Route::has('password.request'),
            'isDemo' => config('qwiktest.demo_mode'),
            "appUrl" => config("app.url").'/',
            "assetUrl" => config("app.url").'/storage/',
            'successMessage' => session()->get('successMessage') ? session()->get('successMessage') : null,
            'errorMessage' => session()->get('errorMessage') ? session()->get('errorMessage') : null,
            'csrf_token' => csrf_token(),
            'isMobile' => $agent->isMobile() || $agent->isTablet(),
            "currentCategory" => Cookie::has('category_id') ? ['id' => Cookie::get('category_id'), 'name' => Cookie::get('category_name')] : null,
            'rtl' => config('qwiktest.version') == "1.4.0" ? app(LocalizationSettings::class)->default_direction == 'rtl' : false,
            'locale' => function () {
                return app()->getLocale();
            },
            'translations' => translations(app()->getLocale()),
            'appVersion' => config('qwiktest.version'),
        ]);
    }
}
