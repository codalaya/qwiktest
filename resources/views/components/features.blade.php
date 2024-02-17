<section class="border-b border-gray-100">
    <div class="max-w-7xl mx-auto py-12 px-4 sm:py-28 sm:px-6 lg:px-8">
        <div class="lg:text-center">
            <h2 class="text-base text-secondary font-semibold tracking-wide uppercase">{{ __('Features') }}</h2>
            <p class="mt-2 text-3xl leading-8 font-extrabold tracking-tight text-primary sm:text-4xl">
                {{ $title }}
            </p>
            <p class="mt-4 max-w-2xl text-xl text-gray-500 lg:mx-auto">
                {{ $subtitle }}
            </p>
        </div>
        <div class="mt-10">
            <dl class="space-y-10 md:space-y-0 md:grid md:grid-cols-2 md:gap-x-8 md:gap-y-10">
                @foreach([1,2,3,4] as $i)
                    <div class="relative">
                        <dt>
                            <img class="absolute flex items-center justify-center h-12 w-12 rounded-md bg-primary text-white" src="{{ ${"feature".$i}[2]  }}" alt="{{ ${"feature".$i}[0] }}" role="img" />
                            <p class="ltr:ml-16 rtl:mr-16 text-lg leading-6 font-medium text-gray-900">{{ ${"feature".$i}[0] }}</p>
                        </dt>
                        <dd class="mt-2 ltr:ml-16 rtl:mr-16 text-base text-gray-500">
                            {{ ${"feature".$i}[1] }}
                        </dd>
                    </div>
                @endforeach
            </dl>
        </div>
    </div>
</section>
