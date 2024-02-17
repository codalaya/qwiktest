<template>
    <div class="bg-white">
        <store-nav-bar></store-nav-bar>
        <div class="dark:bg-gray-900 flex items-center justify-center py-12 sm:py-28 px-4 sm:px-6 lg:px-8">
            <div class="max-w-4xl w-full space-y-8">
                <div class="bg-white border-t border-gray-100 shadow-md overflow-hidden sm:rounded-sm">
                    <div class="flex flex-col sm:flex-col md:flex-row lg:flex-row">
                        <div class="hidden border-r border-gray-100 mt-2 md:mt-0 h-24 sm:h-64 md:h-auto md:w-1/2 relative lg:mt-0 pr-6 sm:pr-20 pt-10 sm:flex justify-end sm:block">
                            <div class="w-5/6 h-full">
                                <div class="z-20 absolute top-5 ltr:left-5 rtl:right-5 sm:ltr:left-10 sm:rtl:right-10 sm:top-10">
                                    <h4 class="mt-4 text-xl sm:text-2xl font-bold text-primary tracking-ringtighter" v-html="$page.props.heroSettings.title"></h4>
                                </div>
                                <img class="inset-0 absolute object-contain object-bottom z-10 w-full h-full" :src="$page.props.assetUrl + $page.props.heroSettings.image_path" :alt="$page.props.general.app_name" role="img" />
                            </div>
                        </div>
                        <div class="flex flex-col lg:w-6/12 md:w-6/12 px-4 sm:p-6 justify-center">
                            <slot></slot>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <store-footer v-if="$page.props.homePageSettings.enable_footer" :footer-settings="$page.props.footerSettings"></store-footer>
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
    import StoreFooter from "@/Components/Layout/StoreFooter";
    import StoreNavBar from "@/Components/Layout/StoreNavBar";

    export default {
        components: {
            ArcApplicationMark,
            ArcBanner,
            ArcDropdown,
            ArcDropdownLink,
            ArcNavLink,
            ArcResponsiveNavLink,
            Toast,
            StoreFooter,
            StoreNavBar
        },
        props: {
            canLogin: Boolean,
            canRegister: Boolean,
        },
        methods: {
            logout() {
                this.$inertia.post(route('logout'));
            },
        }
    }
</script>
