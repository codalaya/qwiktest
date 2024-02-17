<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">
                {{ __('License Settings') }}
            </h4>
        </template>

        <div>
            <div class="max-w-7xl mx-auto py-10 sm:px-6 lg:px-8">
                <license-settings-form :settings="licenseSettings" />
            </div>
        </div>
    </admin-layout>
</template>

<script>
    import AdminLayout from '@/Layouts/AdminLayout'
    import ArcSectionBorder from "@/Components/SectionBorder";
    import LicenseSettingsForm from "@/Pages/Admin/Settings/LicenseSettingsForm";

    export default {
        components: {
            AdminLayout,
            ArcSectionBorder,
            LicenseSettingsForm
        },
        props: {
            licenseSettings: Object
        },
        metaInfo() {
            return {
                title: this.title
            }
        },

        computed: {
            title() {
                return this.__('License Settings')+' - ' + this.$page.props.general.app_name;
            }
        },
    }
</script>
