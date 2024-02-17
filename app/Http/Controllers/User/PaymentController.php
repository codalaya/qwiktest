<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use App\Models\Payment;
use App\Settings\BillingSettings;
use App\Settings\LocalizationSettings;
use App\Settings\SiteSettings;
use App\Transformers\User\UserPaymentTransformer;
use Carbon\Carbon;
use Inertia\Inertia;

class PaymentController extends Controller
{
    /**
     * PaymentController constructor.
     */
    public function __construct()
    {
        $this->middleware(['role:guest|student|employee'])->except('downloadInvoice');
    }

    /**
     * Get user payments
     *
     * @return \Inertia\Response
     */
    public function index()
    {
        $payments = Payment::with('plan')
            ->where('user_id', auth()->user()->id)
            ->paginate(request()->perPage != null ? request()->perPage : 10);

        return Inertia::render('User/MyPayments', [
            'payments' => fractal($payments, new UserPaymentTransformer())->toArray(),
            'enable_invoice' => app(BillingSettings::class)->enable_invoicing
        ]);
    }

    public function downloadInvoice($id, LocalizationSettings $localizationSettings, SiteSettings $settings)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'This operation is disabled in the demo mode.');
        }

        if(!app(BillingSettings::class)->enable_invoicing) {
            return __('Invoice not available for download.');
        }

        $payment = Payment::where('payment_id', '=', $id)->firstOrFail();
        $now = Carbon::now()->timezone($localizationSettings->default_timezone);
        $user = auth()->user()->first_name.' '.auth()->user()->last_name;

        return view('pdf.invoice', [
            'payment' => fractal($payment, new UserPaymentTransformer())->toArray()['data'],
            'data' => $payment->data,
            'logo' => url('storage/'.$settings->logo_path),
            'footer' => "* Invoice Generated from {$settings->app_name} by {$user} on {$now->toDayDateTimeString()}",
            'rtl' => $localizationSettings->default_direction == 'rtl'
        ]);
    }
}
