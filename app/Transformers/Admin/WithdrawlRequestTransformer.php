<?php

namespace App\Transformers\Admin;

use App\Models\WithdrawlRequest;
use League\Fractal\TransformerAbstract;

class WithdrawlRequestTransformer extends TransformerAbstract
{
    /**
     * List of resources to automatically include
     *
     * @var array
     */
    protected $defaultIncludes = [
        //
    ];

    /**
     * List of resources possible to include
     *
     * @var array
     */
    protected $availableIncludes = [
        //
    ];

    /**
     * A Fractal transformer.
     *
     * @return array
     */
    public function transform(WithdrawlRequest $withdrawlRequest)
    {
        return [
            'id' => $withdrawlRequest->id,
            'user_name' => $withdrawlRequest->user->account_owner_name,
            'amount' => $withdrawlRequest->amount,
            'status' => $withdrawlRequest->status,
            'bank_account_no' => $withdrawlRequest->user->bank_account_no,
            'bank_ifsc_code' => $withdrawlRequest->user->bank_ifsc_code,
            'upi_id' => $withdrawlRequest->user->upi_id,
            'preferred' => $withdrawlRequest->user->preferred_payment_method
        ];
    }
}
