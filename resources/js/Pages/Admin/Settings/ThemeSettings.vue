<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">
                {{ __('Theme Settings') }}
            </h4>
        </template>

        <div>
            <div class="max-w-7xl mx-auto py-10 sm:px-6 lg:px-8">
                <theme-settings-form :settings="themeSettings" />
                <arc-section-border />
                <font-settings-form :settings="themeSettings" />
            </div>
        </div>
    </admin-layout>
</template>

<script>
    import AdminLayout from '@/Layouts/AdminLayout'
    import ArcSectionBorder from "@/Components/SectionBorder";
    import ThemeSettingsForm from "@/Pages/Admin/Settings/ThemeSettingsForm";
    import FontSettingsForm from "@/Pages/Admin/Settings/FontSettingsForm";

    export default {
        components: {
            AdminLayout,
            ArcSectionBorder,
            ThemeSettingsForm,
            FontSettingsForm
        },
        props: {
            themeSettings: Object
        },
        metaInfo() {
            return {
                title: this.title
            }
        },

        computed: {
            title() {
                return this.__('Theme Settings')+' - ' + this.$page.props.general.app_name;
            }
        },
    }
</script>
