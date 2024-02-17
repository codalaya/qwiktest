<section class="hero-gradient dark:bg-gray-900 border-b border-gray-100 lg:px-4 xl:px-0">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex flex-col sm:flex-col md:flex-row lg:flex-row">
            <div class="hidden mt-6 md:mt-0 h-96 md:h-auto md:w-1/2 relative lg:mt-0 ltr:pr-6 rtl:pl-6 sm:ltr:pl-20 sm:rtl:pl-20 sm:flex justify-end sm:block">
                <div class="w-5/6 h-full">
                    <img class="inset-0 absolute object-contain object-bottom z-10 w-auto h-full pt-10" src="{{ asset('storage/'.$hero->image_path) }}" alt="Hero Image" role="img" />
                </div>
            </div>
            <div class="flex flex-col items-start lg:w-6/12 md:w-6/12 px-4 lg:px-0 md:ml-8 justify-center py-12 sm:py-36">
                @if($least_price)
                    <div class="mb-6 py-1.5 px-4 flex items-center justify-start bg-secondary rounded-full text-sm font-semibold text-white">
                        <svg class="w-4 h-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M0 0h24v24H0V0z" fill="none"/><path d="M4 6h16v2H4zm2-4h12v2H6zm14 8H4c-1.1 0-2 .9-2 2v8c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2v-8c0-1.1-.9-2-2-2zm0 10H4v-8h16v8zm-10-7.27v6.53L16 16z"/></svg>
                        <span class="pl-2">{{ __('Subscription starts from') }} {{ $least_price }}/{{ __('month') }}</span>
                    </div>
                @endif
                <h1 class="text-5xl sm:text-5xl md:text-4xl lg:text-5xl font-bold leading-tight text-primary dark:text-white">{{ $category['headline'] ?: $category['name'] }}</h1>
                <p class="text-lg text-gray-600 leading-relaxed pt-8 xl:hidden block">{{ $category['short_description'] }}</p>
                <p class="text-lg text-gray-600 leading-relaxed pt-8 xl:block hidden w-4/5">
                    {{ $category['short_description'] }}
                </p>
                <div class="mt-12 flex flex-wrap">
                    <div class="ltr:mr-6 rtl:ml-6 mt-4 sm:mt-0 md:mt-4 lg:mt-0">
                        <a href="#pricing" class="focus:outline-none focus:ring-2 focus:ring-offset-2 focus:bg-primary bg-primary transition duration-150 ease-in-out hover:opacity-90 rounded text-white px-6 py-4 text-lg">
                            {{ __('View Pricing') }}
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
@push('styles')
    <style>
        .hero-gradient {
            background-image: linear-gradient(rgba(255, 255, 255, 0) 0%, {{ hex2rgba('#'.app(\App\Settings\ThemeSettings::class)->primary_color, 0.03) }} 100%);
            background-repeat: no-repeat;
        }
    </style>
@endpush
