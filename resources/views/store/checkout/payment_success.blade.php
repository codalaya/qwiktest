@extends('store.layout')

@section('title', __('Payment Success'))

@section('content')
    <main class="bg-gray-50">
        <div class="max-w-7xl flex justify-center mx-auto py-16 sm:py-32 px-4 sm:px-6 lg:px-8">
            <div class="inline-block align-bottom bg-white rounded-lg px-4 pt-5 pb-4 text-left shadow-xl sm:my-8 sm:align-middle sm:max-w-sm sm:w-full sm:p-6">
                <div>
                    <div class="mx-auto flex items-center justify-center h-12 w-12 rounded-full bg-green-100">
                        <svg class="h-6 w-6 text-green-600" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                        </svg>
                    </div>
                    <div class="mt-3 text-center sm:mt-5">
                        <h3 class="text-lg leading-6 font-semibold text-gray-900" id="modal-title">
                            {{ __('Payment Success') }}
                        </h3>
                        <div class="mt-2">
                            <p class="text-sm text-gray-500">
                                {{ __('You have successfully completed the payment.') }}
                            </p>
                        </div>
                    </div>
                </div>
                <div class="mt-5 sm:mt-6">
                    <a href="{{ route('user_dashboard') }}" class="inline-flex justify-center w-full rounded-md border border-transparent shadow-sm px-4 py-2 bg-primary text-base font-medium text-white hover:opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-current sm:text-sm">
                        {{ __('Go to Dashboard') }}
                    </a>
                </div>
            </div>
        </div>
    </main>
@endsection
