<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">
                {{ __('Maintenance Settings') }} (v{{ appVersion }})
            </h4>
        </template>

        <div>
            <div class="max-w-7xl mx-auto py-10 sm:px-6 lg:px-8">
                <clear-cache-form></clear-cache-form>
                <arc-section-border />
                <expire-schedules-form></expire-schedules-form>
                <arc-section-border />
                <storage-links-form></storage-links-form>
                <arc-section-border />
                <update-app-form></update-app-form>
                <arc-section-border />
                <debug-mode-form :debug-mode="debugMode"></debug-mode-form>
            </div>
        </div>
    </admin-layout>
</template>

<script>
    import AdminLayout from '@/Layouts/AdminLayout'
    import ArcSectionBorder from "@/Components/SectionBorder";
    import ClearCacheForm from "@/Pages/Admin/Settings/ClearCacheForm";
    import DebugModeForm from "@/Pages/Admin/Settings/DebugModeForm";
    import ExpireSchedulesForm from "@/Pages/Admin/Settings/ExpireSchedulesForm";
    import UpdateAppForm from "@/Pages/Admin/Settings/UpdateAppForm";
    import StorageLinksForm from "@/Pages/Admin/Settings/StorageLinksForm";

    export default {
        components: {
            AdminLayout,
            ArcSectionBorder,
            ClearCacheForm,
            ExpireSchedulesForm,
            UpdateAppForm,
            DebugModeForm,
            StorageLinksForm
        },
        props: {
            appVersion: String,
            debugMode: Boolean
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        computed: {
            title() {
                return this.__('Maintenance Settings')+' - ' + this.$page.props.general.app_name;
            }
        },
    }
</script>
