<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use App\Models\Subscription;
use App\Transformers\User\UserSubscriptionTransformer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;

class SubscriptionController extends Controller
{
    /**
     * SubscriptionController constructor.
     */
    public function __construct()
    {
        $this->middleware(['role:guest|student|employee']);
    }

    /**
     * Get user subscriptions
     *
     * @return \Inertia\Response
     */
    public function index()
    {
        $subscriptions = Subscription::with(['plan' => function($query) {
            $query->with('features:id,code,name');
        }])->where('user_id', auth()->user()->id)
            ->paginate(request()->perPage != null ? request()->perPage : 10);

        return Inertia::render('User/MySubscriptions', [
            'subscriptions' => fractal($subscriptions, new UserSubscriptionTransformer())->toArray(),
        ]);
    }

    /**
     * Cancel user subscription
     *
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function cancelSubscription($id)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! These settings can\'t be changed.');
        }

        $subscription = Subscription::findOrFail($id);
        $subscription->status = 'cancelled';
        $subscription->update();
        return redirect()->back()->with('successMessage', 'Subscription successfully cancelled!');
    }
}
