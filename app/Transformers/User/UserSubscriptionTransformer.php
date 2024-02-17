<?php

namespace App\Transformers\User;

use App\Models\Subscription;
use League\Fractal\TransformerAbstract;

class UserSubscriptionTransformer extends TransformerAbstract
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
            'starts' => $subscription->starts,
            'ends' => $subscription->ends,
            'payment' => $subscription->payment ? $subscription->payment->payment_id : 'Offline',
            'status' => $subscription->status,
            'features' => $subscription->plan->features,
            'canCancel' => $subscription->status == 'active' && $subscription->isActive(),
        ];
    }
}
