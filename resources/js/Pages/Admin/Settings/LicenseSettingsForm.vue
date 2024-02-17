<template>
    <arc-form-section @submitted="updateSettings">
        <template #title>
            {{ __('Activation Details') }}
        </template>

        <template #form>
            <!-- Purchase Code -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="purchase_code" :value="__('Purchase Code')" />
                <arc-input id="purchase_code" type="text" class="mt-1 block w-full" v-model="form.purchase_code" />
                <arc-input-error :message="form.errors.purchase_code" class="mt-2" />
            </div>

            <!-- Activation Key -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="activation_key" :value="version" />
                <arc-text-area id="activation_key" class="mt-1 block w-full" v-model="form.activation_key" />
                <arc-input-error :message="form.errors.activation_key" class="mt-2" />
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
        },
        props: {
            settings: Object
        },
        data() {
            return {
                form: this.$inertia.form({
                    purchase_code: this.settings.purchase_code,
                    activation_key: this.settings.activation_key,
                }),
            }
        },
        methods: {
            updateSettings() {
                this.form.post(route('update_license_settings'), {
                    errorBag: 'updateLicenseSettings',
                    preserveScroll: true
                });
            },
        },
        computed: {
            version() {
                return this.__('Activation Key') + ' (v'+this.$page.props.appVersion+')';
            }
        }
    }
</script>
