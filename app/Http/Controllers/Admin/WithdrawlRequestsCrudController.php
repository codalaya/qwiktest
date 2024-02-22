<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\WithdrawlRequest;
use App\Transformers\Admin\WithdrawlRequestTransformer;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class WithdrawlRequestsCrudController extends Controller
{
    public function index()
    {
        return inertia('Admin/WithdrawlRequests', [
            'requests' => function () {
                return fractal(
                    WithdrawlRequest::with(['user:id,preferred_payment_method,bank_account_no,bank_account_ifsc,account_owner_name,upi_id', 'transaction:id'])
                        ->paginate(request()->perPage != null ? request()->perPage : 10),
                    new WithdrawlRequestTransformer()
                )->toArray();
            },
        ]);
    }

    public function edit(WithdrawlRequest $withdrawlRequest)
    {
        $withdrawlRequest->load('user');
        $user = $withdrawlRequest->user;

        return response()->json([
            'account_owner_name'  => $withdrawlRequest->user->account_owner_name,
            'preferred_payment_method' => $user->preferred_payment_method,
            'bank_account_no' => $user->bank_account_no,
            'upi_id' => $user->upi_id,
            'bank_account_ifsc' => $user->bank_account_ifsc,
            'status' => $withdrawlRequest->status,
            'amount' => $withdrawlRequest->amount,
        ]);
    }

    public function update(Request $request, WithdrawlRequest $withdrawlRequest)
    {
        $request->validate([
            'status' => ['required', 'string', Rule::in(['completed', 'pending'])],
        ]);

        $withdrawlRequest->update(['status' => $request->status]);
        return back()->with(['successMessage', 'Request is updated.']);
    }
}
