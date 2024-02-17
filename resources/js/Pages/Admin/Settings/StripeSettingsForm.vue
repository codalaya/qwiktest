<template>
    <arc-form-section @submitted="updateSettings">
        <template #title>
            {{ __('Stripe Settings') }}
        </template>

        <template #form>
            <!-- Enable Stripe -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="enable_stripe" :value="__('Enable Stripe')" />
                <div class="inline-block cursor-pointer rounded-full relative shadow-sm">
                    <InputSwitch id="enable_stripe" v-model="form.enable_stripe" />
                </div>
                <arc-input-error :message="form.errors.enable_stripe" class="mt-2" />
            </div>

            <!-- Api Key -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="api_key" :value="__('Api Key')" />
                <arc-input id="api_key" type="text" class="mt-1 block w-full" v-model="form.api_key" />
                <arc-input-error :message="form.errors.api_key" class="mt-2" />
            </div>

            <!-- Secret Key -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="secret_key" :value="__('Secret Key')" />
                <arc-input id="secret_key" type="password" class="mt-1 block w-full" v-model="form.secret_key" />
                <arc-input-error :message="form.errors.secret_key" class="mt-2" />
            </div>

            <!-- Webhook URL -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="webhook_url" :value="__('Stripe Webhook URL')" />
                <arc-input id="webhook_url" type="text" class="mt-1 block w-full bg-gray-200" v-model="webhookURL" readonly="readonly"/>
            </div>

            <!-- Webhook Secret -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="webhook_secret" :value="__('Stripe Webhook Secret')" />
                <arc-input id="webhook_secret" type="password" class="mt-1 block w-full" v-model="form.webhook_secret"/>
                <arc-input-error :message="form.errors.webhook_secret" class="mt-2" />
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
    import InputSwitch from "primevue/inputswitch";

    export default {
        components: {
            AdminLayout,
            ArcActionMessage,
            ArcButton,
            ArcFormSection,
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
                    enable_stripe: this.paymentSettings.enable_stripe,
                    api_key: this.settings.api_key,
                    secret_key: this.settings.secret_key,
                    webhook_secret: this.settings.webhook_secret,
                }),
            }
        },
        methods: {
            updateSettings() {
                this.form.post(route('update_stripe_settings'), {
                    errorBag: 'updateStripeSettings',
                    preserveScroll: true
                });
            },
        },
        computed: {
            webhookURL() {
                return this.$page.props.appUrl+this.settings.webhook_url;
            }
        }
    }
</script>
