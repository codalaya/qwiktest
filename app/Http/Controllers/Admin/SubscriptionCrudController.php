<?php

namespace App\Http\Controllers\Admin;

use App\Filters\SubscriptionFilters;
use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\StoreSubscriptionRequest;
use App\Http\Requests\Admin\UpdateSubscriptionRequest;
use App\Models\Plan;
use App\Models\Subscription;
use App\Models\User;
use App\Transformers\Admin\SubscriptionDetailsTransformer;
use App\Transformers\Admin\SubscriptionTransformer;
use Carbon\Carbon;
use Inertia\Inertia;

class SubscriptionCrudController extends Controller
{
    public function __construct()
    {
        $this->middleware(['role:admin']);
    }

    /**
     * List all subscriptions
     *
     * @param SubscriptionFilters $filters
     * @return \Inertia\Response
     */
    public function index(SubscriptionFilters $filters)
    {
        return Inertia::render('Admin/Subscriptions', [
            'subscriptions' => function () use($filters) {
                return fractal(Subscription::with(['plan', 'user', 'payment:id,payment_id'])->filter($filters)
                    ->paginate(request()->perPage != null ? request()->perPage : 10),
                    new SubscriptionTransformer())->toArray();
            },
            'plans' => Plan::select(['id as value', 'name as text'])->active()->get(),
            'subscriptionStatuses' => [
                ['value' => 'active', 'text' => 'Active'],
                ['value' => 'created', 'text' => 'Created'],
                ['value' => 'cancelled', 'text' => 'Cancelled'],
                ['value' => 'expired', 'text' => 'Expired'],
            ]
        ]);
    }

    /**
     * Store an subscription
     *
     * @param StoreSubscriptionRequest $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function store(StoreSubscriptionRequest $request)
    {
        $plan = Plan::findOrFail($request->plan_id);
        $user = User::findOrFail($request->user_id);

        // check the user has active subscription to the current plan
        $activeSubscriptions = $user->subscriptions()
            ->where('category_id', '=', $plan->category_id)
            ->where('ends_at', '>', now()->toDateTimeString())
            ->where('status', '=', 'active')
            ->count();

        if($activeSubscriptions > 0) {
            return redirect()->back()->with('errorMessage', 'User has active subscription to the current plan.');
        }

        try {
            $subscription = new Subscription();
            $subscription->plan_id = $plan->id;
            $subscription->user_id = $user->id;
            $subscription->category_type = $plan->category_type;
            $subscription->category_id = $plan->category_id;
            $subscription->starts_at = Carbon::now()->toDateTimeString();
            $subscription->ends_at = Carbon::now()->addMonths($plan->duration)->toDateTimeString();
            $subscription->status = $request->status;
            $subscription->save();
            return redirect()->back()->with('successMessage', 'Subscription was successfully added!');
        } catch (\Exception $e) {
            return redirect()->back()->with('errorMessage', 'Something went wrong. Please try again later.');
        }
    }

    /**
     * Show an subscription
     *
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function show($id)
    {
        $subscription = Subscription::find($id);
        return response()->json([
            'subscription' => fractal($subscription, new SubscriptionDetailsTransformer())->toArray()['data'],
        ]);
    }

    /**
     * Edit an subscription
     *
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function edit($id)
    {
        $subscription = Subscription::find($id);
        return response()->json([
            'subscription' => $subscription,
            'plans' => Plan::select(['id', 'name'])->active()->get(),
        ]);
    }

    /**
     * Update an subscription
     *
     * @param UpdateSubscriptionRequest $request
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function update(UpdateSubscriptionRequest $request, $id)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! Subscriptions can\'t be changed.');
        }

        $subscription = Subscription::find($id);
        $subscription->update($request->validated());

        return redirect()->back()->with('successMessage', 'Subscription was successfully updated!');
    }

    /**
     * Delete an subscription
     *
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroy($id)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! Subscriptions can\'t be deleted.');
        }

        try {
            $subscription = Subscription::find($id);

            if($subscription->isActive()) {
                return redirect()->back()->with('errorMessage', 'Unable to Delete Subscription! Subscription is active.');
            }

            $subscription->secureDelete();
        }
        catch (\Illuminate\Database\QueryException $e){
            return redirect()->back()->with('errorMessage', 'Unable to Delete Subscription . Remove all associations and Try again!');
        }
        return redirect()->back()->with('successMessage', 'Subscription was successfully deleted!');
    }
}
