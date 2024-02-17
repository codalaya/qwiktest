<?php

namespace App\Http\Controllers;

use App\Models\Payment;
use App\Repositories\RazorpayRepository;
use Illuminate\Http\Request;

class WebHookController extends Controller
{
    /**
     * Razorpay payments webhook
     *
     * @param Request $request
     * @param RazorpayRepository $repository
     * @return \Illuminate\Http\JsonResponse
     */
    public function razorpay(Request $request, RazorpayRepository $repository)
    {
        // Verify signature
        $verified = $repository->verifyWebhook($request->getContent(), $request->header('X-Razorpay-Signature'));

        if(!$verified) {
            return response()->json(['success' => false], 400);
        }

        $payload = $request->get('payload');

        // If payment captured payment status as success
        if($request->get('event') == 'payment.captured') {
            $payment = Payment::where('transaction_id', '=', $payload['payment']['entity']['id'])->first();
            if($payment) {
                $payment->status = 'success';
                $payment->update;
            }
        }

        // If payment failed mark payment status as failed
        if($request->get('event') == 'payment.failed') {
            $payment = Payment::where('transaction_id', '=', $payload['payment']['entity']['id'])->first();
            if($payment) {
                $payment->status = 'failed';
                $payment->update;
            }
        }

        return response()->json(['success' => true], 200);
    }
}
