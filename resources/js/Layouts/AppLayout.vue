<template>
    <div @keydown.window.escape="sidebar = false" class="h-screen overflow-hidden flex bg-gray-100">
        <arc-banner/>
        <!--Static sidebar for mobile-->
        <div v-show="sidebar" class="fixed inset-0 z-40 flex md:hidden" ref="dialog" aria-modal="true">
            <transition enter-class="transition-opacity ease-linear duration-300" enter-active-class="opacity-0" enter-to-class="opacity-100" leave-class="transition-opacity ease-linear duration-300" leave-active-class="opacity-100" leave-to-class="opacity-0">
                <div v-show="sidebar" class="fixed inset-0 bg-gray-600 bg-opacity-75" @click="sidebar = false" aria-hidden="true">
                </div>
            </transition>
            <transition enter-class="transition ease-in-out duration-300 transform" enter-active-class="-translate-x-full" enter-to-class="translate-x-0" leave-class="transition ease-in-out duration-300 transform" leave-active-class="translate-x-0" leave-to-class="-translate-x-full">
                <div v-show="sidebar" class="relative max-w-xs w-full bg-primary pt-5 pb-4 flex-1 flex flex-col">
                    <transition enter-class="ease-in-out duration-300" enter-active-class="opacity-0" enter-to-class="opacity-100" leave-class="ease-in-out duration-300" leave-active-class="opacity-100" leave-to-class="opacity-0">
                        <div v-show="sidebar" class="absolute top-0 right-0 -mr-12 pt-2">
                            <button type="button"
                                    class="ml-1 flex items-center justify-center h-10 w-10 rounded-full focus:outline-none focus:ring-2 focus:ring-inset focus:ring-white"
                                    @click="sidebar = false">
                                <span class="sr-only">{{ __('Close sidebar') }}</span>
                                <svg class="h-6 w-6 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor"
                                     aria-hidden="true">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                          d="M6 18L18 6M6 6l12 12"></path>
                                </svg>
                            </button>
                        </div>
                    </transition>
                    <div class="flex-shrink-0 px-4 pb-4 border-b border-gray-100 border-opacity-10 flex items-center">
                        <a :href="route('welcome')">
                            <img :src="$page.props.assetUrl + $page.props.general.white_logo_path"
                                 :alt="$page.props.general.app_name" class="h-8 w-auto">
                        </a>
                    </div>
                    <div class="mt-4 flex-1 h-0 overflow-y-auto">
                        <side-bar-nav :is-mobile="true"></side-bar-nav>
                    </div>
                </div>
            </transition>
            <div class="flex-shrink-0 w-14"></div>
        </div>
        <!-- Static sidebar for desktop -->
        <div class="hidden bg-primary md:flex md:flex-shrink-0">
            <div class="w-72 flex flex-col">
                <div class="border-r border-gray-200 pb-4 flex flex-col flex-grow overflow-y-auto">
                    <div class="flex-shrink-0 h-16 px-6 border-b border-gray-100 border-opacity-10 flex items-center">
                        <a :href="route('welcome')">
                            <img :src="$page.props.assetUrl + $page.props.general.white_logo_path"
                                 :alt="$page.props.general.app_name" class="h-8 w-auto">
                        </a>
                    </div>
                    <div class="flex-grow mt-4 flex flex-col">
                        <side-bar-nav :is-mobile="false"></side-bar-nav>
                    </div>
                </div>
            </div>
        </div>
        <div class="flex-1 w-full mx-auto w-0 flex flex-col md:px-0">
            <div class="relative z-20 flex-shrink-0 flex h-16 bg-white sm:border-b border-gray-200 lg:border-none">
                <button type="button" class="border-b border-r border-gray-200 px-4 text-gray-500 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-indigo-500 md:hidden" @click="sidebar = true">
                    <span class="sr-only">{{ __('Open sidebar') }}</span>
                    <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h7"></path>
                    </svg>
                </button>
                <div class="flex-1 max-w-5xl mx-auto border-b border-gray-200 flex justify-between px-4 md:px-0">
                    <div class="flex-1 flex">
                        <form class="w-full flex md:ml-0" action="#" method="GET">
                            <label for="search-field" class="sr-only">{{ __('Search') }}</label>
                            <div class="relative w-full text-gray-400 focus-within:text-gray-600">
                                <div class="pointer-events-none absolute inset-y-0 ltr:left-0 rtl:right-0 flex items-center">
                                    <svg class="h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                                        <path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd"></path>
                                    </svg>
                                </div>
                                <input id="search-field" class="block h-full w-full border-transparent py-2 ltr:pl-8 rtl:pr-8 ltr:pr-3 rtl:pl-3 text-gray-900 placeholder-gray-500 focus:outline-none focus:placeholder-gray-400 focus:ring-0 focus:border-transparent sm:text-sm" placeholder="Search" type="search" name="search">
                            </div>
                        </form>
                    </div>
                    <div class="ltr:ml-4 rtl:mr-4 flex items-center md:ltr:ml-6 md:rtl:mr-6">
                        <!--Rewards Badge-->
                        <!-- <rewards-badge :text-color="'text-primary'" :points="$page.props.user.wallet_balance"></rewards-badge> -->

                        <!--Notification Button-->
                        <!-- <button type="button" class="ltr:ml-3 rtl:mr-3 bg-white p-1 rounded-full text-gray-400 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                            <span class="sr-only">{{ __('View notifications') }}</span>
                            <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"></path>
                            </svg>
                        </button> -->

                        <!--Profile dropdown-->
                        <div class="ltr:ml-3 rtl:mr-3 relative">
                            <arc-dropdown align="right" width="48">
                                <template #trigger>
                                    <button v-if="$page.props.jetstream.managesProfilePhotos"
                                            class="flex border-2 border-transparent rounded-full focus:outline-none focus:border-gray-300 transition duration-150 ease-in-out">
                                        <img class="h-8 w-8 rounded-full object-cover"
                                             :src="$page.props.user.profile_photo_url"
                                             :alt="$page.props.user.first_name"/>
                                    </button>

                                    <span v-else class="inline-flex rounded-md">
                                        <button type="button"
                                                class="inline-flex items-center px-3 py-2 border border-transparent leading-4 font-medium rounded-md text-gray-500 bg-white hover:text-gray-700 focus:outline-none transition ease-in-out duration-150">
                                                                    {{ $page.props.user.first_name }}

                                                                    <svg class="ml-2 -mr-0.5 h-4 w-4" xmlns="http://www.w3.org/2000/svg"
                                                                         viewBox="0 0 20 20" fill="currentColor">
                                                                        <path fill-rule="evenodd"
                                                                              d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                                                              clip-rule="evenodd"/>
                                                                    </svg>
                                                                </button>
                                    </span>
                                </template>
                                <template #content>
                                    <!--Account Management-->
                                    <div class="block px-4 py-2 text-xs text-gray-400">
                                        {{ $page.props.user.first_name }} {{ $page.props.user.last_name }}
                                    </div>

                                    <arc-dropdown-link :href="route('profile.show')">
                                        {{ __('Profile') }}
                                    </arc-dropdown-link>

                                    <!-- <arc-dropdown-link :href="route('user_subscriptions')">
                                        {{ __('My Subscriptions') }}
                                    </arc-dropdown-link> -->

                                    <!-- <arc-dropdown-link :href="route('user_payments')">
                                        {{ __('My Payments') }}
                                    </arc-dropdown-link> -->
<!--
                                    <arc-dropdown-link :href="route('api-tokens.index')"
                                                       v-if="$page.props.jetstream.hasApiFeatures">
                                        {{ __('API Tokens') }}
                                    </arc-dropdown-link> -->

                                    <div class="border-t border-gray-100"></div>

                                    <!--Authentication-->
                                    <form method="post" :action="route('logout')">
                                        <input type="hidden" name="_token" :value="$page.props.csrf_token" />
                                        <arc-dropdown-link as="button">
                                            {{ __('Logout') }}
                                        </arc-dropdown-link>
                                    </form>
                                </template>
                            </arc-dropdown>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Page header -->
            <div class="bg-white z-10 shadow">
                <div class="max-w-5xl mx-auto">
                    <div class="py-4">
                        <div class="px-4 sm:px-6 md:px-0">
                            <div class="flex flex-col md:flex-row items-start md:items-center justify-between">
                                <div>
                                    <slot name="header"></slot>
                                </div>
                                <div v-if="$slots.actions" class="sm:mb-0 sm:mt-0">
                                    <slot name="actions"></slot>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <perfect-scrollbar class="flex-1 relative h-full z-0 overflow-hidden focus:outline-none" ref="scroll" :options="scrollbarOptions">
                <main class="max-w-5xl mx-auto">
                    <div class="px-4 sm:px-6 md:px-0">
                        <Message v-show="$page.props.successMessage" severity="success" :closable="false">
                            {{ $page.props.successMessage }}
                        </Message>
                        <Message v-if="$page.props.errorMessage" severity="error" :closable="false">
                            {{ $page.props.errorMessage }}
                        </Message>
                        <slot></slot>
                    </div>
                </main>
            </perfect-scrollbar>
            <Toast position="top-right"/>
            <!--Modal Portal-->
            <portal-target name="modal" multiple>
            </portal-target>
        </div>
    </div>
</template>

<script>
    import ArcApplicationMark from '@/Components/ApplicationMark'
    import ArcBanner from '@/Components/Banner'
    import ArcDropdown from '@/Components/Dropdown'
    import ArcDropdownLink from '@/Components/DropdownLink'
    import ArcNavLink from '@/Components/NavLink'
    import ArcResponsiveNavLink from '@/Components/ResponsiveNavLink'
    import Toast from 'primevue/toast';
    import RewardsBadge from "@/Components/RewardsBadge";
    import Message from "primevue/message";
    import SideBarNav from "@/Components/SideBarNav";
    import {PerfectScrollbar} from "vue2-perfect-scrollbar";

    export default {
        components: {
            ArcApplicationMark,
            ArcBanner,
            ArcDropdown,
            ArcDropdownLink,
            ArcNavLink,
            ArcResponsiveNavLink,
            Toast,
            Message,
            RewardsBadge,
            SideBarNav,
            PerfectScrollbar
        },

        props: {
            canLogin: Boolean,
            canRegister: Boolean,
        },

        data() {
            return {
                showingNavigationDropdown: false,
                sidebar: false,
                scrollbarOptions: {
                    swipeEasing: true,
                    suppressScrollX: true,
                    maxScrollbarLength: 100
                },
            }
        },

        methods: {
            switchToTeam(team) {
                this.$inertia.put(route('current-team.update'), {
                    'team_id': team.id
                }, {
                    preserveState: false
                })
            },

            toggleMenu(flag) {
                let value = document.getElementById("menu");
                if (flag) {
                    value.classList.remove("hidden");
                } else {
                    value.classList.add("hidden");
                }
            },

            logout() {
                this.$inertia.post(route('logout'));
            },
        }
    }
</script>
