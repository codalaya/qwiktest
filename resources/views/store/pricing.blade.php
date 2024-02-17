@extends('store.layout')

@section('title', __('Pricing'))

@section('content')
    <div x-data="{category: '{{ $selectedCategory }}'}">
        <section id="categories" class="hero-gradient dark:bg-gray-900 border-b border-gray-100 lg:px-4 xl:px-0">
            <div class="max-w-2xl mx-auto py-16 px-4 sm:py-24 sm:px-6 lg:px-8 lg:max-w-7xl">
                <div class="px-0 sm:px-4 lg:px-0 lg:flex lg:justify-between lg:items-center">
                    <div class="max-w-xl">
                        <h2 class="text-5xl sm:text-5xl md:text-4xl lg:text-5xl font-bold leading-tight text-primary dark:text-white">{{ __('Pricing Plans') }}</h2>
                        <p class="mt-5 text-lg text-gray-600">{{ app(\App\Settings\CategorySettings::class)->subtitle }}</p>
                    </div>
                    <div class="mt-10 w-full max-w-xs lg:mt-0">
                        <label for="category" class="block text-base font-medium text-primary">{{ __('Category') }}</label>
                        <div class="mt-1.5 relative">
                            <select id="category" name="category" x-model="category" class="block w-full bg-none bg-primary bg-opacity-25 border border-transparent text-white focus:ring-white focus:border-white rounded-md">
                                @foreach($categories as $category)
                                    <option class="bg-primary" value="{{ $category['code'] }}">
                                        {{ $category['category'] }} {{ $category['name'] }}
                                    </option>
                                @endforeach
                            </select>
                            <div class="pointer-events-none absolute inset-y-0 right-0 px-2 flex items-center">
                                <svg class="h-4 w-4 text-indigo-300" x-description="Heroicon name: solid/chevron-down" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                                    <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                                </svg>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        @foreach($categories as $category)
            <div x-bind:class="category !== '{{ $category['code'] }}' ? 'hidden' : ''" class="max-w-7xl mx-auto py-12 px-4 sm:py-28 sm:px-6 lg:px-8">
                <div class="lg:text-center">
                    <p class="mt-2 text-3xl leading-8 font-extrabold tracking-tight text-primary sm:text-4xl">
                        {{ $category['name'] }} {{ __('Subscription Plans') }}
                    </p>
                    <p class="mt-4 max-w-2xl text-lg text-gray-500 lg:mx-auto">
                        {{ __('To be paid as a one-time payment.') }}
                    </p>
                </div>
                <div class="mt-16 flex flex-wrap items-center justify-center gap-6">
                    @foreach($category['plans'] as $plan)
                        <x-plan :plan="$plan"/>
                    @endforeach
                </div>
            </div>
        @endforeach
    </div>
@endsection
@push('styles')
    <style>
        .hero-gradient {
            background-image: linear-gradient(rgba(255, 255, 255, 0) 0%, {{ hex2rgba('#'.app(\App\Settings\ThemeSettings::class)->primary_color, 0.03) }} 100%);
            background-repeat: no-repeat;
        }
    </style>
@endpush
