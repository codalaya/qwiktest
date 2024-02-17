<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">
                {{ __('Payment Settings') }}
            </h4>
        </template>

        <div>
            <div class="max-w-7xl mx-auto py-10 sm:px-6 lg:px-8">
                <payment-settings-form :settings="paymentSettings" :payment-processors="paymentProcessors" :currencies="currencies"/>
                <arc-section-border />
                <paypal-settings-form :settings="paypalSettings" :payment-settings="paymentSettings"></paypal-settings-form>
                <arc-section-border />
                <stripe-settings-form :settings="stripeSettings" :payment-settings="paymentSettings"></stripe-settings-form>
                <arc-section-border />
                <razorpay-settings-form :settings="razorpaySettings" :payment-settings="paymentSettings"></razorpay-settings-form>
                <arc-section-border />
                <bank-settings-form :settings="bankSettings" :payment-settings="paymentSettings"></bank-settings-form>
            </div>
        </div>
    </admin-layout>
</template>

<script>
    import AdminLayout from '@/Layouts/AdminLayout'
    import ArcSectionBorder from "@/Components/SectionBorder";
    import PaymentSettingsForm from "@/Pages/Admin/Settings/PaymentSettingsForm";
    import BankSettingsForm from "@/Pages/Admin/Settings/BankSettingsForm";
    import RazorpaySettingsForm from "@/Pages/Admin/Settings/RazorpaySettingsForm";
    import PaypalSettingsForm from "@/Pages/Admin/Settings/PaypalSettingsForm";
    import StripeSettingsForm from "@/Pages/Admin/Settings/StripeSettingsForm";

    export default {
        components: {
            AdminLayout,
            ArcSectionBorder,
            PaymentSettingsForm,
            BankSettingsForm,
            RazorpaySettingsForm,
            StripeSettingsForm,
            PaypalSettingsForm
        },
        props: {
            paymentSettings: Object,
            bankSettings: Object,
            razorpaySettings: Object,
            paypalSettings: Object,
            stripeSettings: Object,
            paymentProcessors: Array,
            currencies: Array,
        },
        metaInfo() {
            return {
                title: this.title
            }
        },

        computed: {
            title() {
                return this.__('Payment Settings')+' - ' + this.$page.props.general.app_name;
            }
        },
    }
</script>
