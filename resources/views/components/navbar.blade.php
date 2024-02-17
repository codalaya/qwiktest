<div class="bg-white dark:bg-gray-900 overflow-auto">
    <div x-data="{ open: false }" @keydown.window.escape="open = false" class="bg-white">
        <!-- Mobile menu -->
        <div x-show="open" class="fixed inset-0 flex z-40 lg:hidden" x-description="Off-canvas menu for mobile, show/hide based on off-canvas menu state." x-ref="dialog" aria-modal="true">

            <div x-show="open" x-transition:enter="transition-opacity ease-linear duration-300" x-transition:enter-start="opacity-0" x-transition:enter-end="opacity-100" x-transition:leave="transition-opacity ease-linear duration-300" x-transition:leave-start="opacity-100" x-transition:leave-end="opacity-0" x-description="Off-canvas menu overlay, show/hide based on off-canvas menu state."
                 class="fixed inset-0 bg-black bg-opacity-25" @click="open = false" aria-hidden="true"></div>

            <div x-show="open" x-transition:enter="transition ease-in-out duration-300 transform" x-transition:enter-start="ltr:-translate-x-full rtl:translate-x-full" x-transition:enter-end="translate-x-0" x-transition:leave="transition ease-in-out duration-300 transform" x-transition:leave-start="translate-x-0" x-transition:leave-end="ltr:-translate-x-full rtl:translate-x-full" x-description="Off-canvas menu, show/hide based on off-canvas menu state."
                 class="relative max-w-xs w-full bg-white shadow-xl pb-12 flex flex-col overflow-y-auto">
                <div class="px-4 pt-5 pb-2 flex">
                    <button type="button" class="-m-2 p-2 rounded-md inline-flex items-center justify-center text-gray-400" @click="open = false">
                        <span class="sr-only">{{ __('Close menu') }}</span>
                        <svg class="h-6 w-6" x-description="Heroicon name: outline/x" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                        </svg>
                    </button>
                </div>

                <!-- Links -->
                <div class="border-t border-gray-200 py-6 px-4 space-y-6">
                    <div class="flow-root">
                        <a href="{{ url('/') }}#explore" class="-m-2 p-2 block font-medium text-gray-900">{{ __('Explore') }}</a>
                    </div>
                    <div class="flow-root">
                        <a href="{{ route('learn_practice') }}" class="-m-2 p-2 block font-medium text-gray-900">{{ __('Learn & Practice') }}</a>
                    </div>
                    <div class="flow-root">
                        <a href="{{ route('quiz_dashboard') }}" class="-m-2 p-2 block font-medium text-gray-900">{{ __('Quizzes') }}</a>
                    </div>
                    <div class="flow-root">
                        <a href="{{ route('pricing') }}#explore" class="-m-2 p-2 block font-medium text-gray-900">{{ __('Pricing') }}</a>
                    </div>
                </div>

                <div class="border-t border-gray-200 py-6 px-4 space-y-6">
                    <div class="flow-root">
                        <a href="{{ route('login') }}" class="-m-2 p-2 block font-medium text-gray-900">{{ __('Login') }}</a>
                    </div>
                </div>
            </div>

        </div>

        <header class="relative bg-white dark:bg-gray-900 dark:border-gray-800 border-b border-gray-100 shadow-lg">
            <nav aria-label="Top" class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="">
                    <div class="h-16 sm:h-20 flex items-center">
                        <button type="button" x-description="Mobile menu toggle, controls the 'mobileMenuOpen' state." class="bg-white p-2 rounded-md text-gray-400 lg:hidden" @click="open = true">
                            <span class="sr-only">{{ __('Open menu') }}</span>
                            <svg class="h-6 w-6" x-description="Heroicon name: outline/menu" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
                            </svg>
                        </button>

                        <!-- Logo -->
                        <div class="ltr:mr-4 rtl:ml-4 flex ltr:lg:ml-0 rtl:lg:ml-0">
                            <a href="{{ route('welcome') }}">
                                <span class="sr-only">{{ $siteSettings->app_name }}</span>
                                <img class="h-8 w-auto" src="{{ asset('storage/'.$siteSettings->logo_path) }}" alt="{{ $siteSettings->app_name }}">
                            </a>
                        </div>

                        <!-- Menus -->
                        <div class="hidden lg:ltr:ml-8 lg:rtl:mr-8 lg:block lg:self-stretch">
                            <div class="h-full flex rtl:space-x-reverse space-x-8">
                                <a href="{{ url('/') }}#explore" class="flex items-center font-medium text-gray-700 hover:text-gray-800">{{ __('Explore') }}</a>
                                <a href="{{ route('learn_practice') }}" class="flex items-center font-medium text-gray-700 hover:text-gray-800">{{ __('Learn & Practice') }}</a>
                                <a href="{{ route('quiz_dashboard') }}" class="flex items-center font-medium text-gray-700 hover:text-gray-800">{{ __('Quizzes') }}</a>
                                <a href="{{ route('pricing') }}" class="flex items-center font-medium text-gray-700 hover:text-gray-800">{{ __('Pricing') }}</a>
                            </div>
                        </div>

                        <div class="ltr:ml-auto rtl:mr-auto flex items-center">
                            <!-- Auth -->
                            @guest
                                <div class="hidden ltr:lg:ml-8 rtl:lg:mr-8 lg:flex lg:flex-1 lg:items-center lg:justify-end lg:space-x-6">
                                    <a href="{{ route('login') }}" class="flex items-center justify-center px-8 py-2 border border-transparent rounded-sm shadow-sm text-sm font-medium text-white bg-primary hover:opacity-90">
                                        {{ __('Login') }}
                                    </a>
                                </div>
                            @endguest
                            @auth
                                <div class="hidden ltr:lg:ml-8 rtl:lg:mr-8 lg:flex lg:flex-1 lg:items-center lg:justify-end lg:space-x-6">
                                    <a href="{{ route('home') }}" class="flex items-center justify-center px-8 py-2 border border-transparent rounded-sm shadow-sm text-sm font-medium text-white bg-primary hover:opacity-90">
                                        {{ __('Go to Dashboard') }}
                                    </a>
                                </div>
                            @endauth
                        </div>
                    </div>
                </div>
            </nav>
        </header>
    </div>
</div>
