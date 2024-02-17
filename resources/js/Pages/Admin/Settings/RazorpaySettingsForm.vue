<template>
    <arc-form-section @submitted="updateSettings">
        <template #title>
            {{ __('Razorpay Settings') }}
        </template>

        <template #form>
            <!-- Enable Razorpay -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="enable_razorpay" :value="__('Enable Razorpay')" />
                <div class="inline-block cursor-pointer rounded-full relative shadow-sm">
                    <InputSwitch id="enable_razorpay" v-model="form.enable_razorpay" />
                </div>
                <arc-input-error :message="form.errors.enable_razorpay" class="mt-2" />
            </div>

            <!-- Key ID -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="key_id" :value="__('Razorpay Key Id')" />
                <arc-input id="key_id" type="text" class="mt-1 block w-full" v-model="form.key_id" />
                <arc-input-error :message="form.errors.key_id" class="mt-2" />
            </div>

            <!-- Key Secret -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="key_secret" :value="__('Razorpay Key Secret')" />
                <arc-input id="key_secret" type="password" class="mt-1 block w-full" v-model="form.key_secret" />
                <arc-input-error :message="form.errors.key_secret" class="mt-2" />
            </div>

            <!-- Webhook URL -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="webhook_url" :value="__('Razorpay Webhook URL')" />
                <arc-input id="webhook_url" type="text" class="mt-1 block w-full bg-gray-200" v-model="webhookURL" readonly="readonly"/>
            </div>

            <!-- Webhook Secret -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="webhook_secret" :value="__('Razorpay Webhook Secret')" />
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
                    enable_razorpay: this.paymentSettings.enable_razorpay,
                    key_id: this.settings.key_id,
                    key_secret: this.settings.key_secret,
                    webhook_secret: this.settings.webhook_secret,
                }),
            }
        },
        methods: {
            updateSettings() {
                this.form.post(route('update_razorpay_settings'), {
                    errorBag: 'updateRazorpaySettings',
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
