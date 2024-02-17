<div class="mt-4 p-6 bg-gray-50 border border-gray-200 rounded-sm">
    <h4 class="font-semibold mb-2 underline">{{ __('Bank Account Details') }}</h4>
    <div class="w-full flex gap-4 sm:justify-center items-center">
        <table class="w-full table-auto">
            <tbody>
            @if($bankSettings->bank_name != '-')
                <tr>
                    <td class="border border-gray-300 px-4 py-2 text-gray-800 font-medium">{{ __('Bank Name') }}</td>
                    <td class="border border-gray-300 px-4 py-2 text-gray-800">{{ $bankSettings->bank_name  }}</td>
                </tr>
            @endif
            @if($bankSettings->account_owner != '-')
                <tr>
                    <td class="border border-gray-300 px-4 py-2 text-gray-800 font-medium">{{ __('Account Owner') }}</td>
                    <td class="border border-gray-300 px-4 py-2 text-gray-800">{{ $bankSettings->account_owner  }}</td>
                </tr>
            @endif
            @if($bankSettings->account_number != '-')
                <tr>
                    <td class="border border-gray-300 px-4 py-2 text-gray-800 font-medium">{{ __('Account Number') }}</td>
                    <td class="border border-gray-300 px-4 py-2 text-gray-800">{{ $bankSettings->account_number  }}</td>
                </tr>
            @endif
            @if($bankSettings->iban != '-')
                <tr>
                    <td class="border border-gray-300 px-4 py-2 text-gray-800 font-medium">{{ __('IBAN') }}</td>
                    <td class="border border-gray-300 px-4 py-2 text-gray-800">{{ $bankSettings->iban  }}</td>
                </tr>
            @endif
            @if($bankSettings->routing_number != '-')
                <tr>
                    <td class="border border-gray-300 px-4 py-2 text-gray-800 font-medium">{{ __('Routing Number') }}</td>
                    <td class="border border-gray-300 px-4 py-2 text-gray-800">{{ $bankSettings->routing_number  }}</td>
                </tr>
            @endif
            @if($bankSettings->bic_swift != '-')
                <tr>
                    <td class="border border-gray-300 px-4 py-2 text-gray-800 font-medium">{{ __('BIC/Swift') }}</td>
                    <td class="border border-gray-300 px-4 py-2 text-gray-800">{{ $bankSettings->bic_swift  }}</td>
                </tr>
            @endif
            @if($bankSettings->other_details != '-')
                <tr>
                    <td class="border border-gray-300 px-4 py-2 text-gray-800 font-medium">{{ __('Other Details') }}</td>
                    <td class="border border-gray-300 px-4 py-2 text-gray-800">{{ $bankSettings->other_details  }}</td>
                </tr>
            @endif
            </tbody>
        </table>
    </div>
</div>
