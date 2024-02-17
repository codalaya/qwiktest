<template>
    <arc-form-section @submitted="updateSettings">
        <template #title>
            {{ __('Tax Settings') }}
        </template>

        <template #form>
            <!-- Enable Tax -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="enable_tax" :value="__('Enable Tax')" />
                <div class="inline-block cursor-pointer rounded-full relative shadow-sm">
                    <InputSwitch id="enable_tax" v-model="form.enable_tax" />
                </div>
                <arc-input-error :message="form.errors.enable_tax" class="mt-2" />
            </div>

            <!-- Tax Name -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="tax_name" :value="__('Tax Name')" />
                <arc-input id="tax_name" type="text" class="mt-1 block w-full" v-model="form.tax_name" />
                <arc-input-error :message="form.errors.tax_name" class="mt-2" />
            </div>

            <!-- Tax Amount Type -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="tax_amount_type" :value="__('Tax Amount Type')" />
                <v-select id="tax_amount_type" v-model="form.tax_amount_type" :options="taxAmountTypes"
                          :reduce="t => t.code" label="name" :dir="$page.props.rtl ? 'rtl' : 'ltr'"/>
                <arc-input-error :message="form.errors.tax_amount_type" class="mt-2" />
            </div>

            <!-- Tax Amount -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="tax_amount" :value="__('Tax Amount')" />
                <arc-input id="tax_amount" type="text" class="mt-1 block w-full" v-model="form.tax_amount" />
                <arc-input-error :message="form.errors.tax_amount" class="mt-2" />
            </div>

            <!-- Tax Type -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="tax_type" :value="__('Tax Type')" />
                <v-select id="tax_type" v-model="form.tax_type" :options="taxTypes"
                          :reduce="t => t.code" label="name" :dir="$page.props.rtl ? 'rtl' : 'ltr'"/>
                <arc-input-error :message="form.errors.tax_type" class="mt-2" />
            </div>

            <!-- Enable Additional Tax -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="enable_additional_tax" :value="__('Enable Additional Tax')" />
                <div class="inline-block cursor-pointer rounded-full relative shadow-sm">
                    <InputSwitch id="enable_additional_tax" v-model="form.enable_additional_tax" />
                </div>
                <arc-input-error :message="form.errors.enable_additional_tax" class="mt-2" />
            </div>

            <!-- Additional Tax Name -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="additional_tax_name" :value="__('Additional Tax Name')" />
                <arc-input id="additional_tax_name" type="text" class="mt-1 block w-full" v-model="form.additional_tax_name" />
                <arc-input-error :message="form.errors.additional_tax_name" class="mt-2" />
            </div>

            <!-- Additional Tax Amount Type -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="additional_tax_amount_type" :value="__('Additional Tax Amount Type')" />
                <v-select id="additional_tax_amount_type" v-model="form.additional_tax_amount_type" :options="taxAmountTypes"
                          :reduce="t => t.code" label="name" :dir="$page.props.rtl ? 'rtl' : 'ltr'"/>
                <arc-input-error :message="form.errors.additional_tax_amount_type" class="mt-2" />
            </div>

            <!-- Additional Tax Amount -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="additional_tax_amount" :value="__('Additional Tax Amount')" />
                <arc-input id="additional_tax_amount" type="text" class="mt-1 block w-full" v-model="form.additional_tax_amount" />
                <arc-input-error :message="form.errors.additional_tax_amount" class="mt-2" />
            </div>

            <!-- Additional Tax Type -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="additional_tax_type" :value="__('Additional Tax Type')" />
                <v-select id="additional_tax_type" v-model="form.additional_tax_type" :options="taxTypes"
                          :reduce="t => t.code" label="name" :dir="$page.props.rtl ? 'rtl' : 'ltr'"/>
                <arc-input-error :message="form.errors.additional_tax_type" class="mt-2" />
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
            InputSwitch,
            ArcSecondaryButton,
        },
        props: {
            settings: Object,
        },
        data() {
            return {
                form: this.$inertia.form({
                    enable_tax: this.settings.enable_tax,
                    tax_name: this.settings.tax_name,
                    tax_type: this.settings.tax_type,
                    tax_amount_type: this.settings.tax_amount_type,
                    tax_amount: this.settings.tax_amount,
                    enable_additional_tax: this.settings.enable_additional_tax,
                    additional_tax_name: this.settings.additional_tax_name,
                    additional_tax_type: this.settings.additional_tax_type,
                    additional_tax_amount_type: this.settings.additional_tax_amount_type,
                    additional_tax_amount: this.settings.additional_tax_amount,
                }),
                taxTypes: [
                    {code: 'inclusive', name: 'Inclusive'},
                    {code: 'exclusive', name: 'Exclusive'}
                ],
                taxAmountTypes: [
                    {code: 'fixed', name: 'Fixed'},
                    {code: 'percentage', name: 'Percentage'}
                ]
            }
        },
        methods: {
            updateSettings() {
                this.form.post(route('update_tax_settings'), {
                    errorBag: 'updateTaxSettings',
                    preserveScroll: true
                });
            },
        }
    }
</script>
