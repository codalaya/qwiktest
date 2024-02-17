@if($homePageSettings->enable_top_bar)
    <section class="bg-primary" x-data="{ barOpen: true }">
        <div x-bind:class="!barOpen ? 'hidden' : ''" class="max-w-7xl mx-auto py-1 px-3 sm:px-6 lg:px-8">
            <div class="flex items-center justify-between flex-wrap">
                <div class="w-0 flex-1 flex items-center">
                <span class="flex p-2 rounded-md">
                    <svg class="h-6 w-6 text-secondary rtl:flip" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                         stroke="currentColor" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M11 5.882V19.24a1.76 1.76 0 01-3.417.592l-2.147-6.15M18 13a3 3 0 100-6M5.436 13.683A4.001 4.001 0 017 6h1.832c4.1 0 7.625-1.234 9.168-3v14c-1.543-1.766-5.067-3-9.168-3H7a3.988 3.988 0 01-1.564-.317z" />
                    </svg>
                </span>
                    <p class="ltr:ml-3 rtl:mr-3 font-medium text-white truncate text-sm">
                    <span class="md:hidden">
                        {{ $topBar->message }}
                    </span>
                        <span class="hidden md:inline">
                        {{ $topBar->message }}
                    </span>
                    </p>
                </div>
                <div class="order-3 mt-2 flex-shrink-0 w-full sm:order-2 sm:mt-0 sm:w-auto">
                    <a href="{{ $topBar->button_link }}" target="_blank"
                       class="flex items-center justify-center px-3 py-1 border border-transparent rounded-sm shadow-sm text-sm font-medium text-white bg-secondary hover:opacity-90">
                        {{ $topBar->button_text }}
                    </a>
                </div>
                <div class="order-2 flex-shrink-0 sm:order-3 sm:ltr:ml-3 sm:rtl:mr-3">
                    <button type="button" x-on:click="barOpen = !barOpen"
                            class="ltr:-mr-1 rtl:-ml-1 flex p-2 rounded-sm hover:opacity-80 focus:outline-none focus:ring-2 focus:ring-white sm:ltr:-mr-2 sm:rtl:-mr-2">
                        <span class="sr-only">Dismiss</span>
                        <svg class="h-6 w-6 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                             stroke="currentColor" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M6 18L18 6M6 6l12 12" />
                        </svg>
                    </button>
                </div>
            </div>
        </div>
    </section>

@endif
