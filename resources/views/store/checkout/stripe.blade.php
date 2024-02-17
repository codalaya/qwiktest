@extends('store.layout')

@section('title', __('Review & Checkout'))

@section('content')
    <main class="bg-gray-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <h1 class="text-2xl font-extrabold py-8">{{ __('Review & Checkout') }}</h1>
            <div class="flex flex-col gap-4 mb-4 -mt-4">
                @include('components.alert-success')
                @include('components.alert-danger')
            </div>
            <div class="max-w-2xl pb-24 mx-auto lg:max-w-none">
                <div class="lg:grid lg:grid-cols-2 lg:gap-x-12">
                    <div>
                        @include('store.checkout.partials._customer_billing_info')
                    </div>
                    <!-- Order summary -->
                    <div class="rounded bg-white shadow-md border border-gray-100 mt-10 pb-4 lg:mt-0">
                        <div class="p-4 lg:p-6">
                            @include('store.checkout.partials._order_summary')
                            <div class="mt-4">
                                <div class="flex flex-col mt-6">
                                    <button id="stripe-button" type="submit" class="mt-4 w-full bg-primary border border-transparent rounded-sm shadow-sm py-2 px-4 text-base font-medium text-white hover:opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-gray-50 focus:ring-current">
                                        {{ __('Pay Now') }}
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
@endsection
@push('scripts')
    {{--This api can't be hosted on localhost--}}
    <script>
        document.getElementById('stripe-button').onclick = function(e){
            window.location = "{{ $checkout_url }}";
        }
    </script>
@endpush
