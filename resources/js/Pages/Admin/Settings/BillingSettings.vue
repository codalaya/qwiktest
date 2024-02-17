<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">
                {{ __('Billing Settings') }}
            </h4>
        </template>

        <div>
            <div class="max-w-7xl mx-auto py-10 sm:px-6 lg:px-8">
                <billing-settings-form :settings="billingSettings" :countries="countries"/>
                <arc-section-border />
                <tax-settings-form :settings="taxSettings"></tax-settings-form>
            </div>
        </div>
    </admin-layout>
</template>

<script>
    import AdminLayout from '@/Layouts/AdminLayout'
    import ArcSectionBorder from "@/Components/SectionBorder";
    import BillingSettingsForm from "@/Pages/Admin/Settings/BillingSettingsForm";
    import TaxSettingsForm from "@/Pages/Admin/Settings/TaxSettingsForm";

    export default {
        components: {
            AdminLayout,
            ArcSectionBorder,
            BillingSettingsForm,
            TaxSettingsForm,
        },
        props: {
            billingSettings: Object,
            taxSettings: Object,
            countries: Array,
        },
        metaInfo() {
            return {
                title: this.title
            }
        },

        computed: {
            title() {
                return this.__('Billing & Tax Settings')+' - ' + this.$page.props.general.app_name;
            }
        },
    }
</script>
