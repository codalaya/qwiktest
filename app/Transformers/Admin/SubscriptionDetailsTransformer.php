<?php

namespace App\Transformers\Admin;

use App\Models\Subscription;
use League\Fractal\TransformerAbstract;

class SubscriptionDetailsTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param Subscription $subscription
     * @return array
     */
    public function transform(Subscription $subscription)
    {
        return [
            'id' => $subscription->id,
            'code' => $subscription->code,
            'plan' => $subscription->plan->full_name,
            'user' => $subscription->user->full_name,
            'starts' => $subscription->starts,
            'ends' => $subscription->ends,
            'payment' => $subscription->payment ? 'Online' : 'Offline',
            'payment_id' => $subscription->payment ? $subscription->payment->payment_id : null,
            'status' => $subscription->status,
        ];
    }
}
