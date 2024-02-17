<template>
    <div class="bg-white dark:bg-gray-900 overflow-auto">
        <div class="bg-white">
            <!-- Mobile menu -->
            <div v-show="open" class="fixed inset-0 flex z-40 lg:hidden" aria-modal="true">
                <div v-show="open" class="fixed inset-0 bg-black bg-opacity-25" @click="open = false" aria-hidden="true"></div>

                <div v-show="open" class="relative max-w-xs w-full bg-white shadow-xl pb-12 flex flex-col overflow-y-auto">
                    <div class="px-4 pt-5 pb-2 flex">
                        <button type="button" class="-m-2 p-2 rounded-md inline-flex items-center justify-center text-gray-400" @click="open = false">
                            <span class="sr-only">{{ __('Close menu') }}</span>
                            <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                            </svg>
                        </button>
                    </div>

                    <!-- Links -->
                    <div class="border-t border-gray-200 py-6 px-4 space-y-6">
                        <div class="flow-root">
                            <a :href="route('welcome')+'#explore'" class="-m-2 p-2 block font-medium text-gray-900">{{ __('Explore') }}</a>
                        </div>
                    </div>

                    <div class="border-t border-gray-200 py-6 px-4 space-y-6">
                        <div class="flow-root">
                            <a :href="route('welcome')" class="-m-2 p-2 block font-medium text-gray-900">{{ __('Home') }}</a>
                        </div>
                    </div>
                </div>

            </div>


            <header class="relative bg-white dark:bg-gray-900 dark:border-gray-800 border-b border-gray-100 shadow-lg">
                <nav aria-label="Top" class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="">
                        <div class="h-16 sm:h-20 flex items-center">
                            <button type="button" class="bg-white p-2 rounded-md text-gray-400 lg:hidden" @click="open = true">
                                <span class="sr-only">{{ __('Open menu') }}</span>
                                <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
                                </svg>
                            </button>

                            <!-- Logo -->
                            <div class="ltr:ml-4 rtl:mr-4 flex ltr:lg:ml-0 rtl:lg:ml-0">
                                <a :href="route('welcome')">
                                    <span class="sr-only">Qw</span>
                                    <img class="h-8 w-auto" :src="$page.props.assetUrl + $page.props.general.logo_path" :alt="$page.props.general.app_name">
                                </a>
                            </div>

                            <!-- Menus -->
                            <div class="hidden lg:ltr:ml-8 lg:rtl:mr-8 lg:block lg:self-stretch">
                                <div class="h-full flex rtl:space-x-reverse space-x-8">
                                    <a :href="route('welcome')+'#explore'" class="flex items-center text-sm font-medium text-gray-700 hover:text-gray-800">{{ __('Explore') }}</a>
                                </div>
                            </div>

                            <div class="ltr:ml-auto rtl:mr-auto flex items-center">
                                <!-- Search -->
                                <!--<div class="flex lg:ltr:mr-6 lg:rtl:ml-6">
                                    <a href="#" class="p-2 text-gray-400 hover:text-primary">
                                        <span class="sr-only">{{ __('Search') }}</span>
                                        <svg class="w-6 h-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                                        </svg>
                                    </a>
                                </div>-->

                                <!-- Auth -->
                                <div class="hidden ltr:lg:ml-8 rtl:lg:mr-8 lg:flex lg:flex-1 lg:items-center lg:justify-end lg:space-x-6">
                                    <a :href="route('welcome')" class="flex items-center justify-center px-8 py-2 border border-transparent rounded-sm shadow-sm text-sm font-medium text-white bg-primary hover:opacity-90">
                                        {{ __('Home') }}
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </nav>
            </header>
        </div>
    </div>
</template>
<script>
    export default {
        name: "StoreNavBar",
        data() {
            return {
                open: false,
            }
        },
    }
</script>
