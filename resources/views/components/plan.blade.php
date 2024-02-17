<div class="w-full sm:w-80 relative bg-white border rounded-lg shadow-sm divide-y divide-gray-200 {{ $plan['popular'] ? 'border-secondary' : 'border-gray-200' }}">
    <div class="p-6">
        @if($plan['popular'])
            <p class="absolute top-0 ltr:right-6 rtl:left-6 py-1.5 px-4 bg-secondary rounded-full text-sm font-semibold uppercase tracking-wide text-white transform -translate-y-1/2">{{ __('Most Popular') }}</p>
        @endif
        <div class="flex gap-2 items-center justify-start">
            <h2 class="text-lg leading-6 font-semibold text-primary">{{ $plan['name'] }}</h2>
            @if($plan['has_discount'])
                <div class="flex items-center justify-center bg-green-100 rounded">
                    <p class="font-mono text-sm leading-loose text-center text-green-700 px-2 uppercase">{{ __('Save') }} {{ $plan['discount_percentage'] }}</p>
                </div>
            @endif
        </div>
        <p class="mt-4 text-gray-500">{{ $plan['description'] }}</p>
        <p class="mt-6">
            @if($plan['has_discount'])
                <span class="text-3xl font-bold text-gray-800"><span class="line-through">{{ $plan['price'] }}</span> {{ $plan['discounted_price'] }}</span>
            @else
                <span class="text-3xl font-bold text-gray-800">{{ $plan['price'] }}</span>
            @endif
            <span class="text-base font-medium text-secondary">/{{ __('month') }}</span>
        </p>
            <p class="mt-4 max-w-2xl text-gray-500 lg:mx-auto">
                {{ __('To be paid') }} {{ $plan['total_price'] }} {{ __('for') }} {{ $plan['duration'] }} {{ __('months') }}
            </p>
        <a href="{{ route('checkout', ['plan' => $plan['code']]) }}" class="mt-4 block w-full bg-gray-800 border bg-primary rounded-md py-2 font-semibold text-white text-center hover:opacity-90">
            {{ __('Buy Plan') }}
        </a>
    </div>
    <div class="pt-6 pb-8 px-6">
        <h3 class="font-medium text-gray-900 tracking-wide">{{ $plan['duration'] }} {{ __('Months') }}  {{ __('Unlimited Access To') }}</h3>
        <ul role="list" class="mt-6 space-y-4">
            @foreach($plan['features'] as $feature)
                <li class="flex space-x-3">
                    @if($feature['included'])
                        <svg class="flex-shrink-0 h-5 w-5 text-green-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                            <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" />
                        </svg>
                    @else
                        <svg class="flex-shrink-0 h-5 w-5 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path></svg>
                    @endif
                    <span class="rtl:pr-2 text-gray-500">{{ __($feature['name']) }}</span>
                </li>
            @endforeach
        </ul>
    </div>
</div>
