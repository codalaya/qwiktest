<?php


namespace App\Transformers\Admin;

use App\Models\Subscription;
use League\Fractal\TransformerAbstract;

class SubscriptionTransformer extends TransformerAbstract
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
            'payment' => $subscription->payment ? $subscription->payment->payment_id : 'Offline',
            'status' => $subscription->status,
        ];
    }
}
