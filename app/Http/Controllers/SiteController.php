<?php


namespace App\Http\Controllers;

use App\Models\Feature;
use App\Models\SubCategory;
use App\Settings\HomePageSettings;
use App\Settings\PaymentSettings;
use App\Settings\SiteSettings;
use App\Transformers\Platform\PlanTransformer;
use App\Transformers\Platform\PricingTransformer;

class SiteController extends Controller
{
    /**
     * Welcome page
     *
     * @param HomePageSettings $homePageSettings
     * @param SiteSettings $siteSettings
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Contracts\View\View
     */
    public function index(HomePageSettings $homePageSettings, SiteSettings $siteSettings)
    {
        return view('store.index', [
            'siteSettings' => $siteSettings,
            'homePageSettings' => $homePageSettings
        ]);
    }

    /**
     * Explore category page
     *
     * @param $slug
     * @param HomePageSettings $homePageSettings
     * @param SiteSettings $siteSettings
     * @param PaymentSettings $paymentSettings
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Contracts\View\View
     */
    public function explore($slug, HomePageSettings $homePageSettings, SiteSettings $siteSettings, PaymentSettings $paymentSettings)
    {
        $category = SubCategory::with(['plans' => function($query) {
            $query->where('is_active', '=', 1)->orderBy('sort_order')->with('features');
        }])->where('slug', $slug)->firstOrFail();

        $features = Feature::orderBy('sort_order')->get();

        return view('store.explore', [
            'category' => $category->only(['id', 'name', 'headline', 'short_description']),
            'least_price' => formatPrice($category->plans->min('price'), $paymentSettings->currency_symbol, $paymentSettings->currency_symbol_position),
            'plans' => fractal($category->plans, new PlanTransformer($features))->toArray()['data'],
            'siteSettings' => $siteSettings,
            'homePageSettings' => $homePageSettings
        ]);
    }

    public function pricing(HomePageSettings $homePageSettings, SiteSettings $siteSettings)
    {
        $features = Feature::orderBy('sort_order')->get();
        $categories = SubCategory::whereHas('plans')->with(['category:id,name', 'plans' => function($query) {
            $query->where('is_active', '=', 1)->orderBy('sort_order')->with('features');
        }])->orderBy('sub_categories.name')->get();
        return view('store.pricing', [
            'categories' => fractal($categories, new PricingTransformer($features))->toArray()['data'],
            'selectedCategory' => $categories->count() > 0 ? $categories->first()->code : '',
            'siteSettings' => $siteSettings,
            'homePageSettings' => $homePageSettings
        ]);
    }
}
