<template>
    <div>
        <div class="ltr:ml-0 rtl:mr-0 transition md:ltr:ml-60 md:rtl:mr-60">
            <arc-banner />
        </div>
        <div class="min-h-screen">
            <nav
                class="fixed top-0 ltr:left-0 rtl:right-0 z-20 h-full pb-10 overflow-hidden transition origin-left transform bg-gray-900 w-60 md:ltr:translate-x-0 md:rtl:-translate-x-0"
                :class="{ 'ltr:-translate-x-full rtl:translate-x-full' : !sideBar, 'translate-x-0' : sideBar }"
                @click="sideBar = false">
                <inertia-link class="flex items-center px-4 py-5" :href="route('home')">
                    <img :src="$page.props.assetUrl + $page.props.general.logo_path" :alt="$page.props.general.app_name" class="h-8 w-auto">
                </inertia-link>
                <perfect-scrollbar class="h-full overflow-hidden" ref="scroll" :options="scrollbarOptions">
                    <nav class="text-sm font-medium pb-16 text-gray-400" aria-label="Main Navigation">
                        <template v-for="item in items">
                            <sidebar-dropdown v-if="item.active && item.item_type === 'dropdown'" :title="item.label" :items="item.items">
                                <template #icon>
                                    <span v-html="item.icon"></span>
                                </template>
                            </sidebar-dropdown>
                            <sidebar-link v-if="item.active === true && item.item_type === 'link'" :title="item.label" :url="item.url">
                                <template #icon>
                                    <span v-html="item.icon"></span>
                                </template>
                            </sidebar-link>
                            <div class="my-4 mx-4 uppercase font-semibold text-green-500 text-xs" v-if="item.item_type === 'divider'">
                                {{ item.label }}
                            </div>
                        </template>
                    </nav>
                </perfect-scrollbar>
            </nav>
            <div class="ltr:ml-0 rtl:mr-0 transition md:ltr:ml-60 md:rtl:mr-60">
                <header class="bg-white shadow flex items-center justify-between w-full md:mx-auto md:sticky md:z-30 md:top-0 px-4 h-14">
                    <button class="block btn btn-light-secondary md:hidden" @click="sideBar = true">
                        <span class="sr-only">{{ __('Menu') }}</span>
                        <svg class="w-4 h-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z" clip-rule="evenodd" />
                        </svg>
                    </button>
                    <div class="hidden -ml-3 form-icon md:block w-96">
                        <inertia-link class="text-sm font-semibold px-4 py-5 capitalize" :href="route('home')">
                            {{ __($page.props.user.role_id) }} {{ __('Dashboard') }}
                        </inertia-link>
                    </div>
                    <div class="flex items-center">
                        <!-- Dark Mode Switch -->
                        <!--<div class="flex justify-between items-center mr-8">
                            <label for="dark_mode" class="text-xs text-gray-800 pb-1">{{ __('Dark Mode') }}</label>
                            <div class="cursor-pointer rounded-full relative shadow-sm">
                                <InputSwitch id="dark_mode" v-model="darkMode" @change="changeMode"/>
                            </div>
                        </div>-->
                        <a href="#" class="flex text-gray-500">
                            <svg class="flex-shrink-0 w-5 h-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                <path d="M10 2a6 6 0 00-6 6v3.586l-.707.707A1 1 0 004 14h12a1 1 0 00.707-1.707L16 11.586V8a6 6 0 00-6-6zM10 18a3 3 0 01-3-3h6a3 3 0 01-3 3z" />
                            </svg>
                        </a>
                        <!-- Account Dropdown -->
                        <div class="ltr:ml-4 rtl:mr-4 relative">
                            <arc-dropdown align="right" width="48">
                                <template #trigger>
                                    <button v-if="$page.props.jetstream.managesProfilePhotos" class="flex border-2 border-transparent rounded-full focus:outline-none focus:border-gray-300 transition duration-150 ease-in-out">
                                        <img class="h-8 w-8 rounded-full object-cover" :src="$page.props.user.profile_photo_url" :alt="$page.props.user.name" />
                                    </button>

                                    <span v-else class="inline-flex rounded-md">
                                            <button type="button" class="inline-flex items-center px-3 py-2 border border-transparent leading-4 font-medium rounded-md text-gray-500 bg-white hover:text-gray-700 focus:outline-none transition ease-in-out duration-150">
                                                {{ $page.props.user.name }}

                                                <svg class="ml-2 -mr-0.5 h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                                    <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
                                                </svg>
                                            </button>
                                        </span>
                                </template>

                                <template #content>
                                    <!-- Account Management -->
                                    <div class="block px-4 py-2 text-xs text-gray-400">
                                        {{ __('Manage Account') }}
                                    </div>

                                    <arc-dropdown-link :href="route('profile.show')">
                                        {{ __('Profile') }}
                                    </arc-dropdown-link>

                                    <arc-dropdown-link :href="route('api-tokens.index')" v-if="$page.props.jetstream.hasApiFeatures">
                                        {{ __('Api Tokens') }}
                                    </arc-dropdown-link>

                                    <div class="border-t border-gray-100"></div>

                                    <!-- Authentication -->
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
                </header>
                <section>
                    <div class="container mx-auto pt-4 px-4 sm:px-6 lg:px-8">
                        <div class="flex flex-col md:flex-row items-start md:items-center justify-between">
                            <div>
                                <slot name="header"></slot>
                            </div>
                            <div class="mb-6 sm:mb-0 sm:mt-0">
                                <slot name="actions"></slot>
                            </div>
                        </div>
                    </div>
                </section>
                <!-- Page Content -->
                <main>
                    <div class="container mx-auto px-4 sm:px-6 lg:px-8">
                        <Message v-if="$page.props.successMessage" severity="success" :closable="false">{{ $page.props.successMessage }}</Message>
                        <Message v-if="$page.props.errorMessage" severity="error" :closable="false">{{ $page.props.errorMessage }}</Message>
                    </div>

                    <slot></slot>
                </main>

                <!-- Modal Portal -->
                <portal-target name="modal" multiple>
                </portal-target>

                <ConfirmDialog></ConfirmDialog>
                <Toast :position="$page.props.rtl ? 'bottom-left' : 'bottom-right'" />
                <Toast :position="$page.props.rtl ? 'top-left' : 'top-right'" group="lm"/>
            </div>
            <!-- Sidebar Backdrop -->
            <div class="fixed inset-0 z-10 w-screen h-screen bg-black bg-opacity-25 md:hidden" v-show="sideBar" @click="sideBar = false"></div>
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
    import ConfirmDialog from 'primevue/confirmdialog';
    import Toast from 'primevue/toast';
    import Message from 'primevue/message';
    import SidebarDropdown from "@/Components/SidebarDropdown";
    import SidebarLink from "@/Components/SidebarLink";
    import { PerfectScrollbar } from 'vue2-perfect-scrollbar'
    import InputSwitch from "primevue/inputswitch";
    export default {
        components: {
            ArcApplicationMark,
            ArcBanner,
            ArcDropdown,
            ArcDropdownLink,
            ArcNavLink,
            ArcResponsiveNavLink,
            ConfirmDialog,
            Message,
            Toast,
            SidebarDropdown,
            SidebarLink,
            PerfectScrollbar,
            InputSwitch
        },

        props: {
            successMessage: String,
            errorMessage: String,
        },
        data: function() {
            return {
                sideBar: false,
                darkMode: false,
                scrollbarOptions: {
                    suppressScrollX: true
                },

                items: [
                    {
                        label:'Home Dashboard',
                        item_type: 'link',
                        icon: '<svg class="flex-shrink-0 w-5 h-5 ltr:mr-2 rtl:ml-2 transition group-hover:text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path></svg>',
                        url: route('admin_dashboard'),
                        active: this.$page.props.user.role_id === 'admin',
                    },
                    // {
                    //     label:'Home Dashboard',
                    //     item_type: 'link',
                    //     icon: '<svg class="flex-shrink-0 w-5 h-5 ltr:mr-2 rtl:ml-2 transition group-hover:text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path></svg>',
                    //     url: route('instructor_dashboard'),
                    //     active: this.$page.props.user.role_id === 'instructor',
                    // },
                    {
                        label: 'File Manager',
                        item_type: 'link',
                        url: route('file-manager'),
                        icon: '<svg class="flex-shrink-0 w-5 h-5 ltr:mr-2 rtl:ml-2 transition group-hover:text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7v8a2 2 0 002 2h6M8 7V5a2 2 0 012-2h4.586a1 1 0 01.707.293l4.414 4.414a1 1 0 01.293.707V15a2 2 0 01-2 2h-2M8 7H6a2 2 0 00-2 2v10a2 2 0 002 2h8a2 2 0 002-2v-2"></path></svg>',
                        active: this.$page.props.user.role_id === 'admin'
                    },
                    {
                        item_type: 'divider',
                        label: 'Engage'
                    },
                    {
                        label: 'Manage Tests',
                        item_type: 'dropdown',
                        icon:'<svg class="flex-shrink-0 w-5 h-5 ltr:mr-2 rtl:ml-2 transition group-hover:text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.75 17L9 20l-1 1h8l-1-1-.75-3M3 13h18M5 17h14a2 2 0 002-2V5a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path></svg>',
                        active: this.$page.props.user.role_id === 'admin' || this.$page.props.user.role_id === 'instructor',
                        items:[
                            {
                                label:'Quizzes',
                                url: route('quizzes.index'),
                                active: this.$page.props.user.role_id === 'admin' || this.$page.props.user.role_id === 'instructor',
                            },
                            {
                                label:'Exams',
                                url: route('exams.index'),
                                active: this.$page.props.user.role_id === 'admin' || this.$page.props.user.role_id === 'instructor',
                            },
                            {
                                label:'Quiz Types',
                                url: route('quiz-types.index'),
                                active: this.$page.props.user.role_id === 'admin' || this.$page.props.user.role_id === 'instructor',
                            },
                            {
                                label:'Exam Types',
                                url: route('exam-types.index'),
                                active: this.$page.props.user.role_id === 'admin' || this.$page.props.user.role_id === 'instructor',
                            },
                        ],
                    },
                    // {
                    //     label: 'Manage Learning',
                    //     item_type: 'dropdown',
                    //     icon:'<svg class="flex-shrink-0 w-5 h-5 ltr:mr-2 rtl:ml-2 transition group-hover:text-gray-300" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M0 0h24v24H0z" fill="none"/><path d="M9 21c0 .55.45 1 1 1h4c.55 0 1-.45 1-1v-1H9v1zm3-19C8.14 2 5 5.14 5 9c0 2.38 1.19 4.47 3 5.74V17c0 .55.45 1 1 1h6c.55 0 1-.45 1-1v-2.26c1.81-1.27 3-3.36 3-5.74 0-3.86-3.14-7-7-7zm2.85 11.1l-.85.6V16h-4v-2.3l-.85-.6C7.8 12.16 7 10.63 7 9c0-2.76 2.24-5 5-5s5 2.24 5 5c0 1.63-.8 3.16-2.15 4.1z"/></svg>',
                    //     active: this.$page.props.user.role_id === 'admin' || this.$page.props.user.role_id === 'instructor',
                    //     items:[
                    //         {
                    //             label:'Practice Sets',
                    //             url: route('practice-sets.index'),
                    //             active: this.$page.props.user.role_id === 'admin' || this.$page.props.user.role_id === 'instructor',
                    //         },
                    //         {
                    //             label:'Lessons',
                    //             url: route('practice.configure_lessons'),
                    //             active: this.$page.props.user.role_id === 'admin' || this.$page.props.user.role_id === 'instructor',
                    //         },
                    //         {
                    //             label:'Videos',
                    //             url: route('practice.configure_videos'),
                    //             active: this.$page.props.user.role_id === 'admin' || this.$page.props.user.role_id === 'instructor',
                    //         },
                    //     ],
                    // },
                    {
                        item_type: 'divider',
                        label: 'Library',
                    },
                    {
                        label:'Question Bank',
                        item_type: 'dropdown',
                        icon:'<svg class="flex-shrink-0 w-5 h-5 ltr:mr-2 rtl:ml-2 transition group-hover:text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8.228 9c.549-1.165 2.03-2 3.772-2 2.21 0 4 1.343 4 3 0 1.4-1.278 2.575-3.006 2.907-.542.104-.994.54-.994 1.093m0 3h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>',
                        active: this.$page.props.user.role_id === 'admin' || this.$page.props.user.role_id === 'instructor',
                        items:[
                            {
                                label:'Questions',
                                url: route('questions.index'),
                                active: this.$page.props.user.role_id === 'admin' || this.$page.props.user.role_id === 'instructor',
                            },
                            {
                                label:'Import Questions',
                                url: route('initiate_import_questions'),
                                active: this.$page.props.user.role_id === 'admin' || this.$page.props.user.role_id === 'instructor',
                            },
                            {
                                label:'Comprehensions',
                                url: route('comprehensions.index'),
                                active: this.$page.props.user.role_id === 'admin' || this.$page.props.user.role_id === 'instructor',
                            },
                            {
                                label: 'Question Types',
                                url: route('question-types.index'),
                                active: this.$page.props.user.role_id === 'admin' || this.$page.props.user.role_id === 'instructor',
                            }
                        ],
                    },
                    // {
                    //     label:'Lesson Bank',
                    //     item_type: 'link',
                    //     icon:'<svg class="flex-shrink-0 w-5 h-5 ltr:mr-2 rtl:ml-2 transition group-hover:text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path></svg>',
                    //     active: this.$page.props.user.role_id === 'admin' || this.$page.props.user.role_id === 'instructor',
                    //     url: route('lessons.index'),
                    // },
                    // {
                    //     label:'Video Bank',
                    //     item_type: 'link',
                    //     icon:'<svg class="flex-shrink-0 w-5 h-5 ltr:mr-2 rtl:ml-2 transition group-hover:text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.752 11.168l-3.197-2.132A1 1 0 0010 9.87v4.263a1 1 0 001.555.832l3.197-2.132a1 1 0 000-1.664z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>',
                    //     active: this.$page.props.user.role_id === 'admin' || this.$page.props.user.role_id === 'instructor',
                    //     url: route('videos.index'),
                    // },
                    // {
                    //     item_type: 'divider',
                    //     label: 'Configuration'
                    // },
                    // {
                    //     label:'Monetization',
                    //     item_type: 'dropdown',
                    //     icon:'<svg class="flex-shrink-0 w-5 h-5 ltr:mr-2 rtl:ml-2 transition group-hover:text-gray-300"  xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M0 0h24v24H0V0z" fill="none"/><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8zm.31-8.86c-1.77-.45-2.34-.94-2.34-1.67 0-.84.79-1.43 2.1-1.43 1.38 0 1.9.66 1.94 1.64h1.71c-.05-1.34-.87-2.57-2.49-2.97V5H10.9v1.69c-1.51.32-2.72 1.3-2.72 2.81 0 1.79 1.49 2.69 3.66 3.21 1.95.46 2.34 1.15 2.34 1.87 0 .53-.39 1.39-2.1 1.39-1.6 0-2.23-.72-2.32-1.64H8.04c.1 1.7 1.36 2.66 2.86 2.97V19h2.34v-1.67c1.52-.29 2.72-1.16 2.73-2.77-.01-2.2-1.9-2.96-3.66-3.42z"/></svg>',
                    //     active: this.$page.props.user.role_id === 'admin',
                    //     items:[
                    //         {
                    //             label:'Plans',
                    //             url: route('plans.index'),
                    //             active: this.$page.props.user.role_id === 'admin',
                    //         },
                    //         {
                    //             label:'Subscriptions',
                    //             url: route('subscriptions.index'),
                    //             active: this.$page.props.user.role_id === 'admin',
                    //         },
                    //         {
                    //             label:'Payments',
                    //             url: route('payments.index'),
                    //             active: this.$page.props.user.role_id === 'admin',
                    //         },
                    //     ]
                    // },
                    {
                        label:'Manage Users',
                        item_type: 'dropdown',
                        icon:'<svg class="flex-shrink-0 w-5 h-5 ltr:mr-2 rtl:ml-2 transition group-hover:text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"></path></svg>',
                        active: this.$page.props.user.role_id === 'admin',
                        items:[
                            {
                                label:'Users',
                                url: route('users.index'),
                                active: this.$page.props.user.role_id === 'admin',
                            },
                            {
                                label:'User Groups',
                                url: route('user-groups.index'),
                                active: this.$page.props.user.role_id === 'admin',
                            },
                            // {
                            //     label:'Import Users',
                            //     url: route('initiate_import_users'),
                            //     active: this.$page.props.user.role_id === 'admin',
                            // },
                        ],
                    },
                    {
                        label:'Manage Categories',
                        item_type: 'dropdown',
                        icon: '<svg class="flex-shrink-0 w-5 h-5 ltr:mr-2 rtl:ml-2 transition group-hover:text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"></path></svg>',
                        active: this.$page.props.user.role_id === 'admin',
                        items:[
                            {
                                label:'Categories',
                                url: route('categories.index'),
                                active: this.$page.props.user.role_id === 'admin',
                            },
                            {
                                label:'Sub Categories',
                                url: route('sub-categories.index'),
                                active: this.$page.props.user.role_id === 'admin',
                            },
                            {
                                label:'Tags',
                                url: route('tags.index'),
                                active: this.$page.props.user.role_id === 'admin',
                            },
                        ]
                    },
                    {
                        label:'Manage Subjects',
                        item_type: 'dropdown',
                        icon: '<svg class="flex-shrink-0 w-5 h-5 ltr:mr-2 rtl:ml-2 transition group-hover:text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"></path></svg>',
                        active: this.$page.props.user.role_id === 'admin' || this.$page.props.user.role_id === 'instructor',
                        items: [
                            {
                                label:'Sections',
                                url: route('sections.index'),
                                active: this.$page.props.user.role_id === 'admin' || this.$page.props.user.role_id === 'instructor',
                            },
                            {
                                label:'Skills',
                                url: route('skills.index'),
                                active: this.$page.props.user.role_id === 'admin' || this.$page.props.user.role_id === 'instructor',
                            },
                            {
                                label:'Topics',
                                url: route('topics.index'),
                                active: this.$page.props.user.role_id === 'admin' || this.$page.props.user.role_id === 'instructor',
                            },
                        ]
                    },
                    // {
                    //     label:'Settings',
                    //     item_type: 'dropdown',
                    //     icon:'<svg class="flex-shrink-0 w-5 h-5 ltr:mr-2 rtl:ml-2 transition group-hover:text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path></svg>',
                    //     active: this.$page.props.user.role_id === 'admin',
                    //     items:[
                    //         {
                    //             label:'General Settings',
                    //             url: route('general_settings'),
                    //             active: this.$page.props.user.role_id === 'admin',
                    //         },
                    //         {
                    //             label:'Localization Settings',
                    //             url: route('localization_settings'),
                    //             active: this.$page.props.user.role_id === 'admin',
                    //         },
                    //         {
                    //             label:'Home Page Settings',
                    //             url: route('home_page_settings'),
                    //             active: this.$page.props.user.role_id === 'admin',
                    //         },
                    //         {
                    //             label:'Email Settings',
                    //             url: route('email_settings'),
                    //             active: this.$page.props.user.role_id === 'admin',
                    //         },
                    //         {
                    //             label:'Payment Settings',
                    //             url: route('payment_settings'),
                    //             active: this.$page.props.user.role_id === 'admin',
                    //         },
                    //         {
                    //             label:'Billing & Tax Settings',
                    //             url: route('billing_tax_settings'),
                    //             active: this.$page.props.user.role_id === 'admin',
                    //         },
                    //         {
                    //             label:'Theme Settings',
                    //             url: route('theme_settings'),
                    //             active: this.$page.props.user.role_id === 'admin',
                    //         },
                    //         {
                    //             label:'Maintenance Settings',
                    //             url: route('maintenance_settings'),
                    //             active: this.$page.props.user.role_id === 'admin',
                    //         },
                    //     ]
                    // },
                ]
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

            changeMode() {
                if (this.darkMode) {
                    document.documentElement.classList.add('dark')
                } else {
                    document.documentElement.classList.remove('dark')
                }
            },

            logout() {
                this.$inertia.post(route('logout'));
            },
        },
    }
</script>
