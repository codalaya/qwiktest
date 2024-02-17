<section class="bg-primary">
    <div class="max-w-7xl mx-auto py-12 px-4 sm:py-28 sm:px-6 lg:px-8">
        <div class="max-w-4xl mx-auto text-center">
            <h2 class="text-3xl font-extrabold text-secondary sm:text-4xl">
                {{ $title }}
            </h2>
            <p class="mt-3 text-xl text-white opacity-90 sm:mt-4">
                {{ $subtitle }}
            </p>
        </div>
        <dl class="mt-10 text-center sm:max-w-3xl sm:mx-auto sm:grid sm:grid-cols-3 sm:gap-8">
            <div class="flex flex-col">
                <dt class="order-2 mt-2 text-lg leading-6 font-medium text-white opacity-90">
                    {{ $stat1[1] }}
                </dt>
                <dd class="order-1 text-5xl font-extrabold text-white">
                    {{ $stat1[0] }}
                </dd>
            </div>
            <div class="flex flex-col mt-10 sm:mt-0">
                <dt class="order-2 mt-2 text-lg leading-6 font-medium text-white opacity-90">
                    {{ $stat2[1] }}
                </dt>
                <dd class="order-1 text-5xl font-extrabold text-white">
                    {{ $stat2[0] }}
                </dd>
            </div>
            <div class="flex flex-col mt-10 sm:mt-0">
                <dt class="order-2 mt-2 text-lg leading-6 font-medium text-white opacity-90">
                    {{ $stat3[1] }}
                </dt>
                <dd class="order-1 text-5xl font-extrabold text-white">
                    {{ $stat3[0] }}
                </dd>
            </div>
        </dl>
    </div>
</section>
