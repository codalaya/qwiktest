<section class="hero-gradient dark:bg-gray-900 border-b border-gray-100 lg:px-4 xl:px-0">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex flex-col sm:flex-col md:flex-row lg:flex-row">
            <div class="flex flex-col lg:w-6/12 md:w-6/12 px-4 lg:px-0 justify-center py-12 sm:py-36">
                <h1 class="text-5xl sm:text-5xl md:text-4xl lg:text-5xl font-bold leading-tight text-primary dark:text-white">{!! $title !!}</h1>
                <p class="text-lg text-gray-600 font-light leading-relaxed pt-8 xl:hidden block">{!! $subtitle !!}</p>
                <p class="text-lg text-gray-600 font-light leading-relaxed pt-8 xl:block hidden w-4/5">
                    {!! $subtitle !!}
                </p>
                <div class="mt-12 flex flex-wrap">
                    <div class="ltr:mr-6 rtl:ml-6 mt-4 sm:mt-0 md:mt-4 lg:mt-0">
                        <a href="{{ $cta_link }}" class="focus:outline-none focus:ring-2 focus:ring-offset-2 focus:bg-primary bg-primary transition duration-150 ease-in-out hover:opacity-90 rounded text-white px-6 py-4 text-lg">
                            {{ $cta_text }}
                        </a>
                    </div>
                </div>
            </div>
            <div class="hidden mt-6 md:mt-0 h-96 md:h-auto md:w-1/2 relative lg:mt-0 ltr:pl-6 rtl:pr-6 sm:ltr:pl-20 sm:rtl:pl-20 sm:flex justify-end sm:block">
                <div class="w-5/6 h-full">
                    <img class="inset-0 absolute object-contain object-bottom z-10 w-auto h-full pt-10" src="{{ asset('storage/'.$image_path) }}" alt="Hero Image" role="img" />
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
