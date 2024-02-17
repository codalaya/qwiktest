<template>
    <arc-form-section @submitted="updateSettings">
        <template #title>
            {{ __('Payment Settings') }}
        </template>

        <template #form>
            <!-- Default Payment Gateway -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="default_payment_processor" :value="__('Default Payment Processor')" />
                <v-select id="locale" v-model="form.default_payment_processor" :options="paymentProcessors"
                          :reduce="payment => payment.code" label="name" :placeholder="__('Select a Processor')" :dir="$page.props.rtl ? 'rtl' : 'ltr'"/>
                <arc-input-error :message="form.errors.default_payment_processor" class="mt-2" />
            </div>

            <!-- Default Currency -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="default_currency" :value="__('Currency')" />
                <v-select id="default_currency" v-model="form.default_currency" :options="currencies"
                          :reduce="currency => currency.code" label="name" :placeholder="__('Select a Currency')" :dir="$page.props.rtl ? 'rtl' : 'ltr'"/>
                <arc-input-error :message="form.errors.default_currency" class="mt-2" />
            </div>

            <!-- Currency Symbol -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="currency_symbol" :value="__('Currency Symbol')" />
                <arc-input id="currency_symbol" type="text" class="mt-1 block w-full" v-model="form.currency_symbol" />
                <arc-input-error :message="form.errors.currency_symbol" class="mt-2" />
            </div>

            <!-- Currency Symbol Position -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="currency_symbol_position" :value="__('Currency Symbol Position')" />
                <v-select id="currency_symbol_position" v-model="form.currency_symbol_position" :options="positions"
                          :reduce="position => position.id" label="name" :placeholder="__('Select Position')" :dir="$page.props.rtl ? 'rtl' : 'ltr'"/>
                <arc-input-error :message="form.errors.currency_symbol_position" class="mt-2" />
            </div>
        </template>

        <template #actions>
            <arc-action-message :on="form.recentlySuccessful" class="mr-3">
                {{ __('Saved') }}.
            </arc-action-message>

            <arc-button :class="{ 'opacity-25': form.processing }" :disabled="form.processing">
                {{ __('Save') }}
            </arc-button>
        </template>
    </arc-form-section>
</template>
<script>
    import AdminLayout from '@/Layouts/AdminLayout'
    import ArcActionMessage from "@/Components/ActionMessage";
    import ArcButton from "@/Components/Button";
    import ArcFormSection from "@/Components/FormSection";
    import ArcInput from "@/Components/Input";
    import ArcInputError from "@/Components/InputError";
    import ArcLabel from "@/Components/Label";
    import ArcSecondaryButton from "@/Components/SecondaryButton";
    import ArcTextArea from "@/Components/TextArea";
    import InputSwitch from "primevue/inputswitch";

    export default {
        components: {
            AdminLayout,
            ArcActionMessage,
            ArcButton,
            ArcFormSection,
            ArcTextArea,
            ArcInput,
            ArcInputError,
            ArcLabel,
            ArcSecondaryButton,
            InputSwitch
        },
        props: {
            settings: Object,
            paymentProcessors: Array,
            currencies: Array,
        },
        data() {
            return {
                form: this.$inertia.form({
                    default_payment_processor: this.settings.default_payment_processor,
                    default_currency: this.settings.default_currency,
                    currency_symbol: this.settings.currency_symbol,
                    currency_symbol_position: this.settings.currency_symbol_position,
                }),
                positions: [
                    {id: 'left', name: 'Left'},
                    {id: 'right', name: 'Right'},
                ]
            }
        },
        methods: {
            updateSettings() {
                this.form.post(route('update_payment_settings'), {
                    errorBag: 'updatePaymentSettings',
                    preserveScroll: true
                });
            },
        }
    }
</script>
