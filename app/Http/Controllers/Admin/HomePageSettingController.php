<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Repositories\SettingsRepository;
use App\Settings\CategorySettings;
use App\Settings\CtaSettings;
use App\Settings\FeatureSettings;
use App\Settings\FooterSettings;
use App\Settings\HeroSettings;
use App\Settings\HomePageSettings;
use App\Settings\StatSettings;
use App\Settings\TestimonialSettings;
use App\Settings\TopBarSettings;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use Inertia\Inertia;

class HomePageSettingController extends Controller
{
    /**
     * Get Home Page Settings Page
     *
     * @param HomePageSettings $homePageSettings
     * @return \Inertia\Response
     */
    public function home(HomePageSettings $homePageSettings)
    {
        return Inertia::render('Admin/Settings/HomePageSettings', [
            'homePageSettings' => $homePageSettings->toArray(),
            'heroSettings' => app(HeroSettings::class)->toArray(),
            'topBarSettings' => app(TopBarSettings::class)->toArray(),
            'featureSettings' => app(FeatureSettings::class)->toArray(),
            'ctaSettings' => app(CtaSettings::class)->toArray(),
            'testimonialSettings' => app(TestimonialSettings::class)->toArray(),
            'statSettings' => app(StatSettings::class)->toArray(),
            'categorySettings' => app(CategorySettings::class)->toArray(),
            'footerSettings' => app(FooterSettings::class)->toArray()
        ]);
    }

    /**
     * Update Home Page Settings
     *
     * @param Request $request
     * @param HomePageSettings $settings
     * @return \Illuminate\Http\RedirectResponse
     * @throws \Illuminate\Validation\ValidationException
     */
    public function updateHomePageSettings(Request $request, HomePageSettings $settings)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! These settings can\'t be changed.');
        }

        Validator::make($request->all(), [
            'enable_top_bar' => ['required'],
            'enable_search' => ['required'],
            'enable_hero' => ['required'],
            'enable_features' => ['required'],
            'enable_categories' => ['required'],
            'enable_stats' => ['required'],
            'enable_testimonials' => ['required'],
            'enable_cta' => ['required'],
            'enable_footer' => ['required'],
        ])->validateWithBag('updateHomePageSettings');

        $settings->enable_top_bar = $request->get('enable_top_bar');
        $settings->enable_search = $request->get('enable_search');
        $settings->enable_hero = $request->get('enable_hero');
        $settings->enable_features = $request->get('enable_features');
        $settings->enable_categories = $request->get('enable_categories');
        $settings->enable_stats = $request->get('enable_stats');
        $settings->enable_testimonials = $request->get('enable_testimonials');
        $settings->enable_cta = $request->get('enable_cta');
        $settings->enable_footer = $request->get('enable_footer');
        $settings->save();

        return redirect()->back();
    }

    /**
     * Update Hero Settings
     *
     * @param Request $request
     * @param SettingsRepository $repository
     * @param HeroSettings $settings
     * @return \Illuminate\Http\RedirectResponse
     * @throws \Illuminate\Validation\ValidationException
     */
    public function updateHeroSettings(Request $request, SettingsRepository $repository, HeroSettings $settings)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! These settings can\'t be changed.');
        }

        Validator::make($request->all(), [
            'title' => ['required', 'string', 'max:160'],
            'subtitle' => ['required', 'string', 'max:160'],
            'cta_text' => ['required', 'string', 'max:160'],
            'cta_link' => ['required', 'string', 'max:1024'],
            'image_path' => ['nullable', 'image', 'mimes:jpg,png', 'max:1024'],
        ])->validateWithBag('updateHeroSettings');

        if (isset($request['image_path'])) {
            $repository->updateHeroImage($request['image_path']);
        }

        $settings->title = $request->get('title');
        $settings->subtitle = $request->get('subtitle');
        $settings->cta_text = $request->get('cta_text');
        $settings->cta_link = $request->get('cta_link');
        $settings->save();

        return redirect()->back();
    }

    /**
     * Update Top Bar Settings
     *
     * @param Request $request
     * @param TopBarSettings $settings
     * @return \Illuminate\Http\RedirectResponse
     * @throws \Illuminate\Validation\ValidationException
     */
    public function updateTopBarSettings(Request $request, TopBarSettings $settings)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! These settings can\'t be changed.');
        }

        Validator::make($request->all(), [
            'message' => ['required', 'string', 'max:255'],
            'button_text' => ['required', 'string', 'max:160'],
            'button_link' => ['required', 'string', 'max:255'],
        ])->validateWithBag('updateTopBarSettings');

        $settings->message = $request->get('message');
        $settings->button_text = $request->get('button_text');
        $settings->button_link = $request->get('button_link');
        $settings->save();

        return redirect()->back();
    }

    /**
     * Update Top Bar Settings
     *
     * @param Request $request
     * @param CtaSettings $settings
     * @return \Illuminate\Http\RedirectResponse
     * @throws \Illuminate\Validation\ValidationException
     */
    public function updateCtaSettings(Request $request, CtaSettings $settings)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! These settings can\'t be changed.');
        }

        Validator::make($request->all(), [
            'title' => ['required', 'string', 'max:160'],
            'subtitle' => ['required', 'string', 'max:160'],
            'button_text' => ['required', 'string', 'max:160'],
            'button_link' => ['required', 'string', 'max:255'],
        ])->validateWithBag('updateCtaSettings');

        $settings->title = $request->get('title');
        $settings->subtitle = $request->get('subtitle');
        $settings->button_text = $request->get('button_text');
        $settings->button_link = $request->get('button_link');
        $settings->save();

        return redirect()->back();
    }

    /**
     * Update Category Settings
     *
     * @param Request $request
     * @param CategorySettings $settings
     * @return \Illuminate\Http\RedirectResponse
     * @throws \Illuminate\Validation\ValidationException
     */
    public function updateCategorySettings(Request $request, CategorySettings $settings)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! These settings can\'t be changed.');
        }

        Validator::make($request->all(), [
            'title' => ['required', 'string', 'max:160'],
            'subtitle' => ['required', 'string', 'max:160'],
            'limit' => ['required'],
        ])->validateWithBag('updateCategorySettings');

        $settings->title = $request->get('title');
        $settings->subtitle = $request->get('subtitle');
        $settings->limit = $request->get('limit');
        $settings->save();

        return redirect()->back();
    }

    /**
     * Update Feature Settings
     *
     * @param Request $request
     * @param FeatureSettings $settings
     * @return \Illuminate\Http\RedirectResponse
     * @throws \Illuminate\Validation\ValidationException
     */
    public function updateFeatureSettings(Request $request, FeatureSettings $settings)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! These settings can\'t be changed.');
        }

        $validations = [
            'title' => ['required', 'string', 'max:160'],
            'subtitle' => ['required', 'string', 'max:160'],
        ];

        foreach ([1,2,3,4] as $i) {
            $validations['feature'.$i.'_caption'] = ['required', 'string', 'max:160'];
            $validations['feature'.$i.'_description'] = ['required', 'string', 'max:160'];
            $validations['feature'.$i.'_icon_url'] = ['required', 'string', 'max:250'];
        }

        Validator::make($request->all(), $validations)->validateWithBag('updateFeatureSettings');

        $settings->title = $request->get('title');
        $settings->subtitle = $request->get('subtitle');
        $settings->feature1 = [$request->feature1_caption, $request->feature1_description, $request->feature1_icon_url];
        $settings->feature2 = [$request->feature2_caption, $request->feature2_description, $request->feature2_icon_url];
        $settings->feature3 = [$request->feature3_caption, $request->feature3_description, $request->feature3_icon_url];
        $settings->feature4 = [$request->feature4_caption, $request->feature4_description, $request->feature4_icon_url];
        $settings->save();

        return redirect()->back();
    }

    /**
     * Update Stat Settings
     *
     * @param Request $request
     * @param StatSettings $settings
     * @return \Illuminate\Http\RedirectResponse
     * @throws \Illuminate\Validation\ValidationException
     */
    public function updateStatSettings(Request $request, StatSettings $settings)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! These settings can\'t be changed.');
        }

        $validations = [
            'title' => ['required', 'string', 'max:160'],
            'subtitle' => ['required', 'string', 'max:160'],
        ];

        foreach ([1,2,3] as $i) {
            $validations['stat'.$i.'_name'] = ['required', 'string', 'max:160'];
            $validations['stat'.$i.'_count'] = ['required', 'string', 'max:160'];
        }

        Validator::make($request->all(), $validations)->validateWithBag('updateStatSettings');

        $settings->title = $request->get('title');
        $settings->subtitle = $request->get('subtitle');
        $settings->stat1 = [$request->stat1_count, $request->stat1_name];
        $settings->stat2 = [$request->stat2_count, $request->stat2_name];
        $settings->stat3 = [$request->stat3_count, $request->stat3_name];
        $settings->save();

        return redirect()->back();
    }

    /**
     * Update Testimonial Settings
     *
     * @param Request $request
     * @param TestimonialSettings $settings
     * @return \Illuminate\Http\RedirectResponse
     * @throws \Illuminate\Validation\ValidationException
     */
    public function updateTestimonialSettings(Request $request, TestimonialSettings $settings)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! These settings can\'t be changed.');
        }

        $validations = [
            'title' => ['required', 'string', 'max:160'],
            'subtitle' => ['required', 'string', 'max:160'],
        ];

        foreach ([1,2] as $i) {
            $validations['testimonial'.$i.'_name'] = ['required', 'string', 'max:160'];
            $validations['testimonial'.$i.'_designation'] = ['required', 'string', 'max:160'];
            $validations['testimonial'.$i.'_message'] = ['required', 'string', 'max:250'];
            $validations['testimonial'.$i.'_image'] = ['required', 'string', 'max:250'];
        }

        Validator::make($request->all(), $validations)->validateWithBag('updateTestimonialSettings');

        $settings->title = $request->get('title');
        $settings->subtitle = $request->get('subtitle');
        $settings->testimonial1 = [$request->testimonial1_name, $request->testimonial1_designation, $request->testimonial1_message, $request->testimonial1_image];
        $settings->testimonial2 = [$request->testimonial2_name, $request->testimonial2_designation, $request->testimonial2_message, $request->testimonial2_image];
        $settings->save();

        return redirect()->back();
    }

    /**
     * Update Footer Settings
     *
     * @param Request $request
     * @param FooterSettings $settings
     * @return \Illuminate\Http\RedirectResponse
     * @throws \Illuminate\Validation\ValidationException
     */
    public function updateFooterSettings(Request $request, FooterSettings $settings)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! These settings can\'t be changed.');
        }

        $validations = [
            'copyright_text' => ['required', 'string', 'max:160'],
        ];

        Validator::make($request->all(), $validations)->validateWithBag('updateFooterSettings');

        $settings->copyright_text = $request->get('copyright_text');
        $settings->enable_links = $request->get('enable_links');
        $settings->footer_links = $request->get('footer_links');
        $settings->enable_social_links = $request->get('enable_social_links');
        $settings->social_links = [
            'facebook' => ['Facebook', $request->get('enable_facebook'), $request->get('facebook_link')],
            'twitter' => ['Twitter', $request->get('enable_twitter'), $request->get('twitter_link')],
            'youtube' => ['Youtube', $request->get('enable_youtube'), $request->get('youtube_link')],
            'instagram' => ['Instagram', $request->get('enable_instagram'), $request->get('instagram_link')],
            'linkedin' => ['LinkedIn', $request->get('enable_linkedin'), $request->get('linkedin_link')],
            'github' => ['GitHub', $request->get('enable_github'), $request->get('github_link')],
        ];
        $settings->save();

        return redirect()->back();
    }
}
