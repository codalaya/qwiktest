<section id="pricing" class="bg-gray-50 border-b border-gray-100">
    <div class="max-w-7xl mx-auto py-12 px-4 sm:py-28 sm:px-6 lg:px-8">
        <div class="lg:text-center">
            <h2 class="text-base text-secondary font-semibold tracking-wide uppercase">{{ __('Pricing') }}</h2>
            <p class="mt-2 text-3xl leading-8 font-extrabold tracking-tight text-primary sm:text-4xl">
                {{ $category['name'] }} {{ __('Subscription Plans') }}
            </p>
            <p class="mt-4 max-w-2xl text-lg text-gray-500 lg:mx-auto">
                {{ __('To be paid as a one-time payment.') }}
            </p>
        </div>
        <div class="mt-16 flex flex-wrap items-center justify-center gap-6">
            @foreach($plans as $plan)
                <x-plan :plan="$plan"/>
            @endforeach
        </div>
    </div>
</section>
