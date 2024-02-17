<template>
    <arc-form-section @submitted="updateSettings">
        <template #title>
            {{ __('Billing Settings') }}
        </template>

        <template #form>
            <div class="col-span-6 sm:col-span-4">
                <p class="font-mono px-2 py-1 inline-block bg-blue-100 text-gray-600 rounded text-sm">
                    {{ __('hide_field_message') }}
                <p/>
            </div>

            <!-- Vendor Name -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="vendor_name" :value="__('Vendor Name')" />
                <arc-input id="vendor_name" type="text" class="mt-1 block w-full" v-model="form.vendor_name" />
                <arc-input-error :message="form.errors.vendor_name" class="mt-2" />
            </div>

            <!-- Address -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="address" :value="__('Address')" />
                <arc-text-area id="address" class="mt-1 block w-full" v-model="form.address" />
                <arc-input-error :message="form.errors.address" class="mt-2" />
            </div>

            <!-- City -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="city" :value="__('City')" />
                <arc-input id="city" type="text" class="mt-1 block w-full" v-model="form.city" />
                <arc-input-error :message="form.errors.city" class="mt-2" />
            </div>

            <!-- State -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="state" :value="__('State')" />
                <arc-input id="state" type="text" class="mt-1 block w-full" v-model="form.state" />
                <arc-input-error :message="form.errors.state" class="mt-2" />
            </div>

            <!-- Country -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="country" :value="__('Country')" />
                <v-select id="country" v-model="form.country" :options="countries"
                          :reduce="country => country.code" label="name" :placeholder="__('Select a Country')" :dir="$page.props.rtl ? 'rtl' : 'ltr'"/>
                <arc-input-error :message="form.errors.country" class="mt-2" />
            </div>

            <!-- Zip -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="zip" :value="__('Zip')" />
                <arc-input id="zip" type="text" class="mt-1 block w-full" v-model="form.zip" />
                <arc-input-error :message="form.errors.zip" class="mt-2" />
            </div>

            <!-- Phone Number -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="phone_number" :value="__('Phone Number')" />
                <arc-input id="phone_number" type="text" class="mt-1 block w-full" v-model="form.phone_number" />
                <arc-input-error :message="form.errors.phone_number" class="mt-2" />
            </div>

            <!-- Vat Number -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="vat_number" :value="__('VAT Number')" />
                <arc-input id="vat_number" type="text" class="mt-1 block w-full" v-model="form.vat_number" />
                <arc-input-error :message="form.errors.vat_number" class="mt-2" />
            </div>

            <!-- Enable Invoicing -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="enable_invoicing" :value="__('Enable Invoicing')" />
                <div class="cursor-pointer rounded-full relative shadow-sm">
                    <InputSwitch id="enable_invoicing" v-model="form.enable_invoicing" />
                </div>
                <arc-input-error :message="form.errors.enable_invoicing" class="mt-2" />
            </div>

            <!-- Invoice Prefix -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="invoice_prefix" :value="__('Invoice Prefix')" />
                <arc-input id="invoice_prefix" type="text" class="mt-1 block w-full" v-model="form.invoice_prefix" />
                <arc-input-error :message="form.errors.invoice_prefix" class="mt-2" />
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
            countries: Array,
        },
        data() {
            return {
                form: this.$inertia.form({
                    vendor_name: this.settings.vendor_name,
                    invoice_prefix: this.settings.invoice_prefix,
                    address: this.settings.address,
                    city: this.settings.city,
                    zip: this.settings.zip,
                    state: this.settings.state,
                    country: this.settings.country,
                    phone_number: this.settings.phone_number,
                    vat_number: this.settings.vat_number,
                    enable_invoicing: this.settings.enable_invoicing,
                }),
            }
        },
        methods: {
            updateSettings() {
                this.form.post(route('update_billing_settings'), {
                    errorBag: 'updateBillingSettings',
                    preserveScroll: true
                });
            },
        }
    }
</script>
