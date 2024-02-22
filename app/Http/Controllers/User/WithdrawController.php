<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class WithdrawController extends Controller
{
    public function showBankDetailsPage()
    {
        $user = auth()->user();
        $fullName = $user->first_name . ' ' . $user->last_name;

        return inertia('User/BankDetails', [
            'account_no' => $user->bank_account_no,
            'ifsc_code' => $user->bank_account_ifsc,
            'owner_name' => $user->account_owner_name ?? $fullName,
            'preferred' => $user->preferred_payment_method,
            'upi_id' => $user->upi_id,
        ]);
    }

    public function updateDetails(Request $request)
    {
        $request->validate([
            'preferred' => ['required', 'string', Rule::in(['bank', 'upi'])],
            'bank_account_no' => ['required_if:preferred,bank', 'string'],
            'bank_account_ifsc' => ['required_if:preferred,bank', 'string'],
            'account_owner_name' => ['required_if:preferred,bank', 'string'],
            'upi_id' => ['required_if:preferred,upi', 'string'],
        ]);

        $user = auth()->user();

        $user->update([
            'preferred_payment_method' => $request->preferred,
            'bank_account_no' => $request->bank_account_no,
            'upi_id' => $request->upi_id,
            'bank_account_ifsc' => $request->bank_account_ifsc,
            'account_owner_name' => $request->account_owner_name,
        ]);

        return back()->with(['successMessage', 'Bank details updated!']);
    }

    public function showWithdrawlPage()
    {
        return inertia('User/Withdraw');
    }

    public function storeWithdraw(Request $request)
    {
        $balance = auth()->user()->balance;
        $user = auth()->user();

        $request->validate([
            'amount' => ['required', 'numeric', 'integer', 'min:10', "max:{$balance}"],
        ]);

        $transaction = $user->withdraw($request->amount);

        $user->withdrawlRequests()->create([
            'amount' => $request->amount,
            'status' => 'pending',
            'transaction_id' => $transaction->id,
        ]);


        return back()->withMessage(['successMessage', 'Withdrawl has been queued.']);
    }
}
