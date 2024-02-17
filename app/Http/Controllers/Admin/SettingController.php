<?php


namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Repositories\SettingsRepository;
use App\Settings\BankSettings;
use App\Settings\BillingSettings;
use App\Settings\EmailSettings;
use App\Settings\LocalizationSettings;
use App\Settings\PaymentSettings;
use App\Settings\RazorpaySettings;
use App\Settings\SiteSettings;
use App\Settings\TaxSettings;
use App\Settings\ThemeSettings;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Inertia\Inertia;
use Jackiedo\DotenvEditor\Facades\DotenvEditor;

class SettingController extends Controller
{
    public function __construct()
    {
        $this->middleware(['role:admin']);
    }

    /**
     * Get General Site Settings Page
     *
     * @param SiteSettings $siteSettings
     * @return \Inertia\Response
     */
    public function general(SiteSettings $siteSettings)
    {
        return Inertia::render('Admin/Settings/GeneralSettings', [
            'siteSettings' => $siteSettings->toArray(),
        ]);
    }

    /**
     * Get Localization Settings Page
     *
     * @param LocalizationSettings $localizationSettings
     * @return \Inertia\Response
     */
    public function localization(LocalizationSettings $localizationSettings)
    {
        $timeZones = \DateTimeZone::listIdentifiers(\DateTimeZone::ALL);

        return Inertia::render('Admin/Settings/LocalizationSettings', [
            'localizationSettings' => $localizationSettings->toArray(),
            'timezones' => $timeZones,
            'languages' => isoLocaleIdentifiers()
        ]);
    }

    /**
     * Get Email Settings Page
     *
     * @param EmailSettings $emailSettings
     * @return \Inertia\Response
     */
    public function email(EmailSettings $emailSettings)
    {
        return Inertia::render('Admin/Settings/EmailSettings', [
            'emailSettings' => $emailSettings->toArray(),
        ]);
    }

    /**
     * Get Theme Settings Page
     *
     * @param ThemeSettings $themeSettings
     * @return \Inertia\Response
     */
    public function theme(ThemeSettings $themeSettings)
    {
        return Inertia::render('Admin/Settings/ThemeSettings', [
            'themeSettings' => $themeSettings->toArray(),
        ]);
    }

    /**
     * Get Payment Settings Page
     *
     * @param PaymentSettings $paymentSettings
     * @return \Inertia\Response
     */
    public function payment(PaymentSettings $paymentSettings)
    {
        $paymentProcessors = [];

        foreach (config('qwiktest.payment_processors') as $key => $value) {
            array_push($paymentProcessors, ['code' => $key, 'name' => $value['name']]);
        }

        return Inertia::render('Admin/Settings/PaymentSettings', [
            'paymentSettings' => $paymentSettings->toArray(),
            'bankSettings' => app(BankSettings::class)->toArray(),
            'razorpaySettings' => app(RazorpaySettings::class)->toArray(),
            'paymentProcessors' => $paymentProcessors,
            'currencies' => isoCurrencies()
        ]);
    }

    /**
     * Get Billing Settings Page
     *
     * @param BillingSettings $billingSettings
     * @param TaxSettings $taxSettings
     * @return \Inertia\Response
     * @throws \Exception
     */
    public function billing(BillingSettings $billingSettings, TaxSettings $taxSettings)
    {
        return Inertia::render('Admin/Settings/BillingSettings', [
            'billingSettings' => $billingSettings->toArray(),
            'taxSettings' => $taxSettings->toArray(),
            'countries' => isoCountries()
        ]);
    }

    /**
     * Update Site Settings
     *
     * @param Request $request
     * @param SiteSettings $settings
     * @return \Illuminate\Http\RedirectResponse
     */
    public function updateSiteSettings(Request $request, SiteSettings $settings)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! These settings can\'t be changed.');
        }

        Validator::make($request->all(), [
            'app_name' => ['required', 'string', 'max:160'],
            'tag_line' => ['required', 'string', 'max:160'],
            'seo_description' => ['required', 'string', 'max:255'],
            'can_register' => ['required'],
            'logo_path' => ['nullable', 'image', 'mimes:jpg,png', 'max:512'],
            'favicon_path' => ['nullable', 'image', 'mimes:png', 'max:512']
        ])->validateWithBag('updateSiteSettings');

        $settings->app_name = $request->get('app_name');
        $settings->tag_line = $request->get('tag_line');
        $settings->seo_description = $request->get('seo_description');
        $settings->can_register = $request->get('can_register');
        $settings->save();

        $env = DotenvEditor::load();
        $env->setKey('APP_NAME', $request->get('app_name'));
        $env->save();

        return redirect()->back();
    }

    /**
     * Update Site Logo
     *
     * @param Request $request
     * @param SettingsRepository $repository
     * @return \Illuminate\Http\RedirectResponse
     */
    public function updateLogo(Request $request, SettingsRepository $repository)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! These settings can\'t be changed.');
        }

        Validator::make($request->all(), [
            'logo_path' => ['nullable', 'image', 'mimes:jpg,png', 'max:512'],
        ])->validateWithBag('updateLogo');

        if (isset($request['logo_path'])) {
            $repository->updateSiteLogo($request['logo_path']);
        }

        return redirect()->back();
    }

    /**
     * Update White Logo
     *
     * @param Request $request
     * @param SettingsRepository $repository
     * @return \Illuminate\Http\RedirectResponse
     */
    public function updateWhiteLogo(Request $request, SettingsRepository $repository)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! These settings can\'t be changed.');
        }

        Validator::make($request->all(), [
            'white_logo_path' => ['nullable', 'image', 'mimes:jpg,png', 'max:512'],
        ])->validateWithBag('updateWhiteLogo');

        if (isset($request['white_logo_path'])) {
            $repository->updateWhiteLogo($request['white_logo_path']);
        }

        return redirect()->back();
    }

    /**
     * Update Site Favicon
     *
     * @param Request $request
     * @param SettingsRepository $repository
     * @return \Illuminate\Http\RedirectResponse
     */
    public function updateFavicon(Request $request, SettingsRepository $repository)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! These settings can\'t be changed.');
        }

        Validator::make($request->all(), [
            'favicon_path' => ['nullable', 'image', 'mimes:jpg,png', 'max:512'],
        ])->validateWithBag('updateFavicon');

        if (isset($request['favicon_path'])) {
            $repository->updateFavicon($request['favicon_path']);
        }

        return redirect()->back();
    }

    /**
     * Update Localization Settings
     *
     * @param Request $request
     * @param LocalizationSettings $settings
     * @return \Illuminate\Http\RedirectResponse
     */
    public function updateLocalizationSettings(Request $request, LocalizationSettings $settings)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! These settings can\'t be changed.');
        }

        Validator::make($request->all(), [
            'default_locale' => ['required', 'max:255'],
            'default_direction' => ['required', 'max:255'],
            'default_timezone' => ['required', 'max:255'],
        ])->validateWithBag('updateLocalizationSettings');

        $settings->default_locale = $request->get('default_locale');
        $settings->default_direction = $request->get('default_direction');
        $settings->default_timezone = $request->get('default_timezone');
        $settings->save();

        $env = DotenvEditor::load();
        $env->setKey('APP_LOCALE', $request->get('default_locale'));
        $env->save();

        return redirect()->back();
    }

    /**
     * Update Email Settings
     *
     * @param Request $request
     * @param EmailSettings $settings
     * @return \Illuminate\Http\RedirectResponse
     */
    public function updateEmailSettings(Request $request, EmailSettings $settings)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! These settings can\'t be changed.');
        }

        Validator::make($request->all(), [
            'host' => ['required', 'string', 'max:250'],
            'port' => ['required', 'numeric'],
            'username' => ['required', 'string', 'max:1024'],
            'password' => ['required', 'string', 'max:1024'],
            'encryption' => ['required', 'string', 'max:250'],
            'from_address' => ['required', 'string', 'max:1024'],
            'from_name' => ['required', 'string', 'max:1024'],
        ])->validateWithBag('updateSiteSettings');

        $settings->host = $request->get('host');
        $settings->port = $request->get('port');
        $settings->username = $request->get('username');
        $settings->password = $request->get('password');
        $settings->encryption = $request->get('encryption');
        $settings->from_address = $request->get('from_address');
        $settings->from_name = $request->get('from_name');
        $settings->save();

        $env = DotenvEditor::load();
        $env->setKey('MAIL_HOST', $request->get('host'));
        $env->setKey('MAIL_PORT', $request->get('port'));
        $env->setKey('MAIL_USERNAME', $request->get('username'));
        $env->setKey('MAIL_PASSWORD', $request->get('password'));
        $env->setKey('MAIL_ENCRYPTION', $request->get('encryption'));
        $env->setKey('MAIL_FROM_ADDRESS', $request->get('from_address'));
        $env->setKey('MAIL_FROM_NAME', $request->get('from_name'));
        $env->save();

        return redirect()->back();
    }

    /**
     * Update Email Settings
     *
     * @param Request $request
     * @param ThemeSettings $settings
     * @return \Illuminate\Http\RedirectResponse
     */
    public function updateThemeSettings(Request $request, ThemeSettings $settings)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! These settings can\'t be changed.');
        }

        Validator::make($request->all(), [
            'primary_color' => ['required', 'string', 'max:60'],
            'secondary_color' => ['required', 'string', 'max:60'],
        ])->validateWithBag('updateThemeSettings');

        $settings->primary_color = $request->get('primary_color');
        $settings->secondary_color = $request->get('secondary_color');
        $settings->save();

        return redirect()->back();
    }

    /**
     * Update Email Settings
     *
     * @param Request $request
     * @param ThemeSettings $settings
     * @return \Illuminate\Http\RedirectResponse
     */
    public function updateFontSettings(Request $request, ThemeSettings $settings)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! These settings can\'t be changed.');
        }

        Validator::make($request->all(), [
            'default_font' => ['required', 'string', 'max:100'],
            'default_font_url' => ['required', 'string', 'max:1000'],
        ])->validateWithBag('updateFontSettings');

        $env = DotenvEditor::load();
        $env->setKey('DEFAULT_FONT', $request->get('default_font'));
        $env->setKey('DEFAULT_FONT_URL', $request->get('default_font_url'));
        $env->save();

        $settings->default_font = $request->get('default_font');
        $settings->default_font_url = $request->get('default_font_url');
        $settings->save();

        return redirect()->back();
    }

    /**
     * Update Billing Settings
     *
     * @param Request $request
     * @param BillingSettings $settings
     * @return \Illuminate\Http\RedirectResponse
     */
    public function updateBillingSettings(Request $request, BillingSettings $settings)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! These settings can\'t be changed.');
        }

        Validator::make($request->all(), [
            'vendor_name' => ['required', 'max:255'],
            'address' => ['required', 'max:1000'],
            'city' => ['required', 'max:100'],
            'state' => ['required', 'max:100'],
            'country' => ['required', 'max:100'],
            'zip' => ['required', 'max:100'],
            'phone_number' => ['required', 'max:100'],
            'vat_number' => ['required', 'max:100'],
            'enable_invoicing' => ['required'],
            'invoice_prefix' => ['required', 'max:60'],
        ])->validateWithBag('updateBillingSettings');

        $settings->vendor_name = $request->get('vendor_name');
        $settings->address = $request->get('address');
        $settings->city = $request->get('city');
        $settings->state = $request->get('state');
        $settings->country = $request->get('country');
        $settings->zip = $request->get('zip');
        $settings->phone_number = $request->get('phone_number');
        $settings->vat_number = $request->get('vat_number');
        $settings->enable_invoicing = $request->get('enable_invoicing');
        $settings->invoice_prefix = $request->get('invoice_prefix');
        $settings->save();

        return redirect()->back();
    }

    /**
     * Update Tax Settings
     *
     * @param Request $request
     * @param TaxSettings $settings
     * @return \Illuminate\Http\RedirectResponse
     */
    public function updateTaxSettings(Request $request, TaxSettings $settings)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! These settings can\'t be changed.');
        }

        Validator::make($request->all(), [
            'enable_tax' => ['required'],
            'tax_name' => ['required', 'max:100'],
            'tax_type' => ['required'],
            'tax_amount_type' => ['required'],
            'tax_amount' => ['required', 'max:100'],
            'enable_additional_tax' => ['required'],
            'additional_tax_name' => ['required', 'max:100'],
            'additional_tax_type' => ['required'],
            'additional_tax_amount_type' => ['required'],
            'additional_tax_amount' => ['required', 'max:100'],
        ])->validateWithBag('updateTaxSettings');

        $settings->enable_tax = $request->get('enable_tax');
        $settings->tax_name = $request->get('tax_name');
        $settings->tax_type = $request->get('tax_type');
        $settings->tax_amount_type = $request->get('tax_amount_type');
        $settings->tax_amount = $request->get('tax_amount');
        $settings->enable_additional_tax = $request->get('enable_additional_tax');
        $settings->additional_tax_name = $request->get('additional_tax_name');
        $settings->additional_tax_type = $request->get('additional_tax_type');
        $settings->additional_tax_amount_type = $request->get('additional_tax_amount_type');
        $settings->additional_tax_amount = $request->get('additional_tax_amount');
        $settings->save();

        return redirect()->back();
    }

    /**
     * Update Payment Settings
     *
     * @param Request $request
     * @param PaymentSettings $settings
     * @return \Illuminate\Http\RedirectResponse
     */
    public function updatePaymentSettings(Request $request, PaymentSettings $settings)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! These settings can\'t be changed.');
        }

        Validator::make($request->all(), [
            'default_payment_processor' => ['required', 'max:100'],
            'default_currency' => ['required', 'max:3'],
            'currency_symbol' => ['required', 'max:10'],
            'currency_symbol_position' => ['required', 'max:100'],
        ])->validateWithBag('updatePaymentSettings');

        $settings->default_payment_processor = $request->get('default_payment_processor');
        $settings->default_currency = $request->get('default_currency');
        $settings->currency_symbol = $request->get('currency_symbol');
        $settings->currency_symbol_position = $request->get('currency_symbol_position');
        $settings->save();

        return redirect()->back();
    }

    /**
     * Update Bank Settings
     *
     * @param Request $request
     * @param BankSettings $settings
     * @param PaymentSettings $paymentSettings
     * @return \Illuminate\Http\RedirectResponse
     */
    public function updateBankSettings(Request $request, BankSettings $settings, PaymentSettings $paymentSettings)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! These settings can\'t be changed.');
        }

        Validator::make($request->all(), [
            'enable_bank' => ['required'],
            'bank_name' => ['required', 'max:255'],
            'account_owner' => ['required', 'max:255'],
            'account_number' => ['required', 'max:255'],
            'iban' => ['required', 'max:255'],
            'routing_number' => ['required', 'max:255'],
            'bic_swift' => ['required', 'max:255'],
            'other_details' => ['required', 'max:1000'],
        ])->validateWithBag('updateBankSettings');

        $paymentSettings->enable_bank = $request->get('enable_bank');
        $paymentSettings->save();

        $settings->bank_name = $request->get('bank_name');
        $settings->account_owner = $request->get('account_owner');
        $settings->account_number = $request->get('account_number');
        $settings->iban = $request->get('iban');
        $settings->routing_number = $request->get('routing_number');
        $settings->bic_swift = $request->get('bic_swift');
        $settings->other_details = $request->get('other_details');
        $settings->save();

        return redirect()->back();
    }

    /**
     * Update Razorpay Settings
     *
     * @param Request $request
     * @param RazorpaySettings $settings
     * @param PaymentSettings $paymentSettings
     * @return \Illuminate\Http\RedirectResponse
     */
    public function updateRazorpaySettings(Request $request, RazorpaySettings $settings, PaymentSettings $paymentSettings)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! These settings can\'t be changed.');
        }

        Validator::make($request->all(), [
            'enable_razorpay' => ['required'],
            'key_id' => ['required', 'max:1000'],
            'key_secret' => ['required', 'max:1000'],
            'webhook_secret' => ['required', 'max:1000'],
        ])->validateWithBag('updateRazorpaySettings');

        $paymentSettings->enable_razorpay = $request->get('enable_razorpay');
        $paymentSettings->save();

        $settings->key_id = $request->get('key_id');
        $settings->key_secret = $request->get('key_secret');
        $settings->webhook_secret = $request->get('webhook_secret');
        $settings->save();

        return redirect()->back();
    }
}
