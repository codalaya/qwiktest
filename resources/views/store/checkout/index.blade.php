@extends('store.layout')

@section('title', __('Checkout'))

@section('content')
    <main class="bg-gray-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <h1 class="text-2xl font-extrabold py-8">{{ __('Checkout') }}</h1>
            <div class="flex flex-col gap-4 mb-4 -mt-4">
                @include('components.alert-success')
                @include('components.alert-danger')
            </div>
            <div class="max-w-2xl pb-24 mx-auto lg:max-w-none" x-data="{ payment: '{{ app(\App\Settings\PaymentSettings::class)->default_payment_processor }}' }">
                <form method="POST" action="{{ route('process_checkout', ['plan' => $plan]) }}" class="lg:grid lg:grid-cols-2 lg:gap-x-12">
                    @csrf
                    <input type="hidden" name="payment_id" value="{{ $payment_id }}">
                    <div>
                        <!-- Payment Method -->
                        <div class="rounded bg-white shadow-md border pb-4 border-gray-100">
                            <div class="p-4 lg:p-6">
                                <h2 class="text-lg border-b border-gray-200 pb-2 font-semibold text-primary">{{ __('Payment Method') }}</h2>
                                <div class="mt-4 space-y-4 flex flex-col">
                                    @foreach($paymentProcessors as $processor)
                                        <div class="flex items-center justify-between">
                                            <div class="flex items-center cursor-pointer">
                                                <input x-model="payment" id="{{ $processor['code'] }}" name="payment_method" type="radio" value="{{ $processor['code'] }}" {{ $processor['default'] ? 'checked' : '' }} class="cursor-pointer focus:ring-current h-4 w-4 text-primary border-gray-300">
                                                <label for="{{ $processor['code'] }}" class="ml-3 flex items-center block font-medium text-gray-700 cursor-pointer">
                                                    <img class="h-8 rounded border border-gray-200" src="{{ url('/') }}/images/{{ $processor['code'] }}.svg" alt="{{ $processor['name'] }}">
                                                    <span class="ml-2 font-semibold">{{ $processor['name'] }}</span>
                                                </label>
                                            </div>
                                            <div class="hidden sm:block text-sm text-gray-500">{{ $processor['description'] }}</div>
                                        </div>
                                    @endforeach
                                </div>
                            </div>
                        </div>

                        <!-- Billing Information -->
                        <div class="rounded bg-white shadow-md border border-gray-100 mt-10 pb-4">
                            <div class="p-4 lg:p-6">
                                <h2 class="text-lg border-b border-gray-200 pb-2 font-semibold text-primary">{{ __('Billing Information') }}</h2>
                                <!-- Full name -->
                                <div class="mt-4 grid grid-cols-1 gap-y-6 sm:grid-cols-2 sm:gap-x-4">
                                    <div class="sm:col-span-2">
                                        <label for="full_name" class="block font-medium text-gray-700">{{ __('Full name') }}</label>
                                        <div class="mt-1">
                                            <input type="text" name="full_name" id="full_name" value="{{ old('full_name') ?? ($billing_information['full_name'] ?? null) }}" class="block w-full rounded-sm shadow-sm focus:ring-current focus:border-primary {{ $errors->has('full_name') ? ' border-red-300' : 'border-gray-300' }}" >
                                        </div>
                                        @if ($errors->has('full_name'))
                                            <div class="text-xs mt-1 text-red-500" role="alert"><span>{{ $errors->first('full_name') }}</span></div>
                                        @endif
                                    </div>
                                    <!-- Email -->
                                    <div>
                                        <label for="email" class="block font-medium text-gray-700">{{ __('Email') }}</label>
                                        <div class="mt-1">
                                            <input type="text" name="email" id="email" value="{{ old('email') ?? ($billing_information['email'] ?? null) }}" autocomplete="email" class="block w-full rounded-sm shadow-sm focus:ring-current focus:border-primary {{ $errors->has('email') ? ' border-red-300' : 'border-gray-300' }}">
                                        </div>
                                        @if ($errors->has('email'))
                                            <div class="text-xs mt-1 text-red-500" role="alert"><span>{{ $errors->first('email') }}</span></div>
                                        @endif
                                    </div>
                                    <!-- Phone -->
                                    <div>
                                        <label for="phone" class="block font-medium text-gray-700">{{ __('Phone') }}</label>
                                        <div class="mt-1">
                                            <input type="text" name="phone" id="phone" value="{{ old('phone') ?? ($billing_information['phone'] ?? null) }}" autocomplete="tel" class="block w-full rounded-sm shadow-sm focus:ring-current focus:border-primary {{ $errors->has('phone') ? ' border-red-300' : 'border-gray-300' }}">
                                        </div>
                                        @if ($errors->has('phone'))
                                            <div class="text-xs mt-1 text-red-500" role="alert"><span>{{ $errors->first('phone') }}</span></div>
                                        @endif
                                    </div>
                                    <!-- Address -->
                                    <div class="sm:col-span-2">
                                        <label for="address" class="block font-medium text-gray-700">{{ __('Address') }}</label>
                                        <div class="mt-1">
                                            <input type="text" name="address" id="address" value="{{ old('address') ?? ($billing_information['address'] ?? null) }}" autocomplete="street-address" class="block w-full rounded-sm shadow-sm focus:ring-current focus:border-primary {{ $errors->has('address') ? ' border-red-300' : 'border-gray-300' }}">
                                        </div>
                                        @if ($errors->has('address'))
                                            <div class="text-xs mt-1 text-red-500" role="alert"><span>{{ $errors->first('address') }}</span></div>
                                        @endif
                                    </div>
                                    <!-- City -->
                                    <div>
                                        <label for="city" class="block font-medium text-gray-700">{{ __('City') }}</label>
                                        <div class="mt-1">
                                            <input type="text" name="city" id="city" value="{{ old('city') ?? ($billing_information['city'] ?? null) }}" class="block w-full rounded-sm shadow-sm focus:ring-current focus:border-primary {{ $errors->has('city') ? ' border-red-300' : 'border-gray-300' }}">
                                        </div>
                                        @if ($errors->has('city'))
                                            <div class="text-xs mt-1 text-red-500" role="alert"><span>{{ $errors->first('city') }}</span></div>
                                        @endif
                                    </div>
                                    <!-- State -->
                                    <div>
                                        <label for="state" class="block font-medium text-gray-700">{{ __('State') }}</label>
                                        <div class="mt-1">
                                            <input type="text" name="state" id="state" value="{{ old('state') ?? ($billing_information['state'] ?? null) }}" class="block w-full rounded-sm shadow-sm focus:ring-current focus:border-primary {{ $errors->has('state') ? ' border-red-300' : 'border-gray-300' }}">
                                        </div>
                                        @if ($errors->has('state'))
                                            <div class="text-xs mt-1 text-red-500" role="alert"><span>{{ $errors->first('state') }}</span></div>
                                        @endif
                                    </div>
                                    <!-- Country -->
                                    <div>
                                        <label for="country" class="block font-medium text-gray-700">{{ __('Country') }}</label>
                                        <div class="mt-1">
                                            <select id="country" name="country" value="{{ old('country') ?? ($billing_information['country'] ?? null) }}" autocomplete="country" class="block w-full rounded-sm shadow-sm focus:ring-current focus:border-primary {{ $errors->has('country') ? ' border-red-300' : 'border-gray-300' }}">
                                                @foreach($countries as $country)
                                                    <option value="{{ $country['code'] }}" {{ $country['code'] == 'US' ? 'selected' : '' }}>{{ $country['name'] }}</option>
                                                @endforeach
                                            </select>
                                        </div>
                                        @if ($errors->has('country'))
                                            <div class="text-xs mt-1 text-red-500" role="alert"><span>{{ $errors->first('country') }}</span></div>
                                        @endif
                                    </div>
                                    <!-- Zip Code -->
                                    <div>
                                        <label for="zip" class="block font-medium text-gray-700">{{ __('Postal code') }}</label>
                                        <div class="mt-1">
                                            <input type="text" name="zip" id="zip" value="{{ old('zip') ?? ($billing_information['zip'] ?? null) }}" autocomplete="zip" class="block w-full rounded-sm shadow-sm focus:ring-current focus:border-primary {{ $errors->has('zip') ? ' border-red-300' : 'border-gray-300' }}">
                                        </div>
                                        @if ($errors->has('zip'))
                                            <div class="text-xs mt-1 text-red-500" role="alert"><span>{{ $errors->first('zip') }}</span></div>
                                        @endif
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Order summary -->
                    <div class="rounded bg-white shadow-md border border-gray-100 mt-10 pb-4 lg:mt-0">
                        <div class="p-4 lg:p-6">
                            @include('store.checkout.partials._order_summary')
                            <div class="mt-4">
                                <template x-if="payment == 'bank'">
                                    <div class="flex flex-col">
                                        @include('components.bank_details')
                                        <div class="mt-4">{{ __('When transferring the bank payment, please must include the following Payment ID in the reference field of the payment.') }}</div>
                                        <div class="mt-2 px-4 py-2 rounded-md bg-blue-50 border border-blue-200">
                                            {{ $payment_id }}
                                        </div>
                                        <button type="submit" class="mt-6 w-full bg-primary border border-transparent rounded-sm shadow-sm py-2 px-4 text-base font-medium text-white hover:opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-gray-50 focus:ring-current">
                                            {{ __('Submit Bank Payment') }}
                                        </button>
                                    </div>
                                </template>
                                <template x-if="payment != 'bank'">
                                    <div class="flex flex-col mt-6">
                                        <div class="text-sm font-italic">{{ __('Note: You can review your order on the next page before making the payment.') }}</div>
                                        <button type="submit" class="mt-4 w-full bg-primary border border-transparent rounded-sm shadow-sm py-2 px-4 text-base font-medium text-white hover:opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-gray-50 focus:ring-current">
                                            {{ __('Review & Checkout') }}
                                        </button>
                                    </div>
                                </template>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </main>
@endsection
