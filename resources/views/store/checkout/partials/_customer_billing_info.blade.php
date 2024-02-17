<div class="rounded bg-white shadow-md border border-gray-100 pb-4">
    <div class="p-4 lg:p-6">
        <h2 class="text-lg border-b border-gray-200 pb-2 font-semibold text-primary">{{ __('Billing Information') }}</h2>
        <div class="mt-4">
            <dl class="space-y-4">
                <div class="flex items-center justify-between">
                    <dt>
                        {{ __('Full Name') }}
                    </dt>
                    <dd class="font-medium text-gray-900">
                        {{ $billing_information['full_name'] }}
                    </dd>
                </div>
                <div class="flex items-center justify-between">
                    <dt>
                        {{ __('Email') }}
                    </dt>
                    <dd class="font-medium text-gray-900">
                        {{ $billing_information['email'] }}
                    </dd>
                </div>
                <div class="flex items-center justify-between">
                    <dt>
                        {{ __('Phone') }}
                    </dt>
                    <dd class="font-medium text-gray-900">
                        {{ $billing_information['phone'] }}
                    </dd>
                </div>
                <div class="flex items-center justify-between">
                    <dt>
                        {{ __('Address') }}
                    </dt>
                    <dd class="font-medium text-gray-900 text-right">
                        {{ $billing_information['address'] }}<br/>
                        {{ $billing_information['city'] }}<br/>
                        {{ $billing_information['state'] }}<br/>
                        {{ $billing_information['country'] }} - {{ $billing_information['zip'] }}
                    </dd>
                </div>
            </dl>
        </div>
    </div>
</div>
