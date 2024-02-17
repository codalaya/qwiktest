<template>
    <arc-form-section @submitted="updateSettings">
        <template #title>
            {{ __('PayPal Settings') }}
        </template>

        <template #form>
            <!-- Enable PayPal -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="enable_paypal" :value="__('Enable PayPal')" />
                <div class="inline-block cursor-pointer rounded-full relative shadow-sm">
                    <InputSwitch id="enable_paypal" v-model="form.enable_paypal" />
                </div>
                <arc-input-error :message="form.errors.enable_paypal" class="mt-2" />
            </div>

            <!-- Client ID -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="client_id" :value="__('Client Id')" />
                <arc-input id="client_id" type="text" class="mt-1 block w-full" v-model="form.client_id" />
                <arc-input-error :message="form.errors.client_id" class="mt-2" />
            </div>

            <!-- Secret -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="secret" :value="__('Secret')" />
                <arc-input id="secret" type="password" class="mt-1 block w-full" v-model="form.secret" />
                <arc-input-error :message="form.errors.secret" class="mt-2" />
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
            paymentSettings: Object,
        },
        data() {
            return {
                form: this.$inertia.form({
                    enable_paypal: this.paymentSettings.enable_paypal,
                    client_id: this.settings.client_id,
                    secret: this.settings.secret
                }),
            }
        },
        methods: {
            updateSettings() {
                this.form.post(route('update_paypal_settings'), {
                    errorBag: 'updatePaypalSettings',
                    preserveScroll: true
                });
            },
        },
    }
</script>
