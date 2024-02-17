<template>
    <arc-form-section @submitted="updateSettings">
        <template #title>
            {{ __('Home Page Settings') }}
        </template>

        <template #form>
            <!-- Enable Top Bar -->
            <div class="col-span-6 sm:col-span-4">
                <div class="flex justify-between items-center">
                    <div class="w-9/12">
                        <label for="enable_top_bar" class="text-sm text-gray-800 pb-1">{{ __('Enable TopBar') }} ({{ form.enable_top_bar ? __('Enabled') : __('Disabled') }})</label>
                    </div>
                    <div class="cursor-pointer rounded-full relative shadow-sm">
                        <InputSwitch id="enable_top_bar" v-model="form.enable_top_bar" />
                    </div>
                </div>
                <arc-input-error :message="form.errors.enable_top_bar" class="mt-2" />
            </div>

            <!-- Enable Search -->
            <!--<div class="col-span-6 sm:col-span-4">
                <div class="flex justify-between items-center">
                    <div class="w-9/12">
                        <label for="enable_search" class="text-sm text-gray-800 pb-1">{{ __('Enable Search') }} ({{ form.enable_search ? __('Enabled') : __('Disabled') }})</label>
                    </div>
                    <div class="cursor-pointer rounded-full relative shadow-sm">
                        <InputSwitch id="enable_search" v-model="form.enable_search" />
                    </div>
                </div>
                <arc-input-error :message="form.errors.enable_search" class="mt-2" />
            </div>-->

            <!-- Enable Hero -->
            <div class="col-span-6 sm:col-span-4">
                <div class="flex justify-between items-center">
                    <div class="w-9/12">
                        <label for="enable_hero" class="text-sm text-gray-800 pb-1">{{ __('Enable Hero') }} ({{ form.enable_hero ? __('Enabled') : __('Disabled') }})</label>
                    </div>
                    <div class="cursor-pointer rounded-full relative shadow-sm">
                        <InputSwitch id="enable_hero" v-model="form.enable_hero" />
                    </div>
                </div>
                <arc-input-error :message="form.errors.enable_hero" class="mt-2" />
            </div>

            <!-- Enable Features -->
            <div class="col-span-6 sm:col-span-4">
                <div class="flex justify-between items-center">
                    <div class="w-9/12">
                        <label for="enable_features" class="text-sm text-gray-800 pb-1">{{ __('Enable Features') }} ({{ form.enable_features ? __('Enabled') : __('Disabled') }})</label>
                    </div>
                    <div class="cursor-pointer rounded-full relative shadow-sm">
                        <InputSwitch id="enable_features" v-model="form.enable_features" />
                    </div>
                </div>
                <arc-input-error :message="form.errors.enable_features" class="mt-2" />
            </div>

            <!-- Enable Categories -->
            <div class="col-span-6 sm:col-span-4">
                <div class="flex justify-between items-center">
                    <div class="w-9/12">
                        <label for="enable_categories" class="text-sm text-gray-800 pb-1">{{ __('Enable Categories') }} ({{ form.enable_categories ? __('Enabled') : __('Disabled') }})</label>
                    </div>
                    <div class="cursor-pointer rounded-full relative shadow-sm">
                        <InputSwitch id="enable_categories" v-model="form.enable_categories" />
                    </div>
                </div>
                <arc-input-error :message="form.errors.enable_features" class="mt-2" />
            </div>

            <!-- Enable Stats -->
            <div class="col-span-6 sm:col-span-4">
                <div class="flex justify-between items-center">
                    <div class="w-9/12">
                        <label for="enable_stats" class="text-sm text-gray-800 pb-1">{{ __('Enable Stats') }} ({{ form.enable_stats ? __('Enabled') : __('Disabled') }})</label>
                    </div>
                    <div class="cursor-pointer rounded-full relative shadow-sm">
                        <InputSwitch id="enable_stats" v-model="form.enable_stats" />
                    </div>
                </div>
                <arc-input-error :message="form.errors.enable_stats" class="mt-2" />
            </div>

            <!-- Enable Testimonials -->
            <div class="col-span-6 sm:col-span-4">
                <div class="flex justify-between items-center">
                    <div class="w-9/12">
                        <label for="enable_testimonials" class="text-sm text-gray-800 pb-1">{{ __('Enable Testimonials') }} ({{ form.enable_testimonials ? __('Enabled') : __('Disabled') }})</label>
                    </div>
                    <div class="cursor-pointer rounded-full relative shadow-sm">
                        <InputSwitch id="enable_testimonials" v-model="form.enable_testimonials" />
                    </div>
                </div>
                <arc-input-error :message="form.errors.enable_testimonials" class="mt-2" />
            </div>

            <!-- Enable CTA -->
            <div class="col-span-6 sm:col-span-4">
                <div class="flex justify-between items-center">
                    <div class="w-9/12">
                        <label for="enable_cta" class="text-sm text-gray-800 pb-1">{{ __('Enable CTA') }} ({{ form.enable_cta ? __('Enabled') : __('Disabled') }})</label>
                    </div>
                    <div class="cursor-pointer rounded-full relative shadow-sm">
                        <InputSwitch id="enable_cta" v-model="form.enable_cta" />
                    </div>
                </div>
                <arc-input-error :message="form.errors.enable_cta" class="mt-2" />
            </div>

            <!-- Enable Footer -->
            <div class="col-span-6 sm:col-span-4">
                <div class="flex justify-between items-center">
                    <div class="w-9/12">
                        <label for="enable_footer" class="text-sm text-gray-800 pb-1">{{ __('Enable Footer') }} ({{ form.enable_footer ? __('Enabled') : __('Disabled') }})</label>
                    </div>
                    <div class="cursor-pointer rounded-full relative shadow-sm">
                        <InputSwitch id="enable_footer" v-model="form.enable_footer" />
                    </div>
                </div>
                <arc-input-error :message="form.errors.enable_footer" class="mt-2" />
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
    import ArcTextArea from "@/Components/TextArea";
    import ArcInputError from "@/Components/InputError";
    import ArcLabel from "@/Components/Label";
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
            InputSwitch
        },
        props: {
            settings: Object
        },
        data() {
            return {
                form: this.$inertia.form({
                    enable_top_bar: this.settings.enable_top_bar,
                    enable_search: this.settings.enable_search,
                    enable_hero: this.settings.enable_hero,
                    enable_features: this.settings.enable_features,
                    enable_categories: this.settings.enable_categories,
                    enable_testimonials: this.settings.enable_testimonials,
                    enable_stats: this.settings.enable_stats,
                    enable_cta: this.settings.enable_cta,
                    enable_footer: this.settings.enable_footer,
                }),
                imagePreview: null,
            }
        },
        methods: {
            updateSettings() {
                this.form.post(route('update_home_page_settings'), {
                    errorBag: 'updateHomePageSettings',
                    preserveScroll: true
                });
            },
        },
    }
</script>
