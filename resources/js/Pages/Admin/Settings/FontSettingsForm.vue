<template>
    <arc-form-section @submitted="updateSettings">
        <template #title>
            {{ __('Font Settings') }}
        </template>

        <template #form>
            <!-- Mail Host -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="default_font" :value="__('Default Font Name')" />
                <arc-input id="default_font" type="text" class="mt-1 block w-full" placeholder="E.g. Roboto" v-model="form.default_font" />
                <arc-input-error :message="form.errors.default_font" class="mt-2" />
            </div>

            <!-- User Name -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="default_font_url" :value="__('Default Font URL')" />
                <arc-input id="default_font_url" type="text" class="mt-1 block w-full" v-model="form.default_font_url" />
                <arc-input-error :message="form.errors.default_font_url" class="mt-2" />
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
    import ColorPicker from 'primevue/colorpicker';

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
            ColorPicker,
        },
        props: {
            settings: Object
        },
        data() {
            return {
                form: this.$inertia.form({
                    default_font: this.settings.default_font,
                    default_font_url: this.settings.default_font_url,
                }),
            }
        },
        methods: {
            updateSettings() {
                this.form.post(route('update_font_settings'), {
                    errorBag: 'updateFontSettings',
                    preserveScroll: true
                });
            },
        },
    }
</script>
