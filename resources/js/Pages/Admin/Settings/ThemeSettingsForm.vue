<template>
    <arc-form-section @submitted="updateSettings">
        <template #title>
            {{ __('Theme Settings') }}
        </template>

        <template #form>
            <div class="col-span-6 sm:col-span-4">
                <div class="grid grid-cols-1 gap-2 items-center justify-between w-full">
                    <div :style="{'background-color': '#'+form.primary_color, 'color': '#'+form.secondary_color}" class="p-4 h-12 flex items-center justify-center rounded-sm text-sm font-semibold border border-gray-200">
                        Primary BG + Secondary Text
                    </div>
                    <div :style="{'background-color': '#'+form.secondary_color, 'color': '#'+form.primary_color}" class="p-4 h-12 flex items-center justify-center rounded-sm text-sm font-semibold border border-gray-200">
                        Secondary BG + Primary Text
                    </div>
                    <div :style="{'background-color': '#'+form.primary_color}" class="p-4 h-12 flex items-center justify-center rounded-sm text-sm text-white font-semibold border border-gray-200">
                        Primary BG + White Text
                    </div>
                    <div :style="{'color': '#'+form.primary_color}" class="p-4 h-12 flex items-center justify-center rounded-sm bg-white text-sm font-semibold border border-gray-200">
                        White BG + Primary Text
                    </div>
                    <div :style="{'color': '#'+form.secondary_color}" class="p-4 h-12 flex items-center justify-center rounded-sm bg-white text-sm font-semibold border border-gray-200">
                        White BG + Secondary Text
                    </div>
                </div>
            </div>

            <!-- Primary Color -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="primary_color" :value="__('Primary Color') + ' ('+__('Dark')+')'" />
                <div class="flex items-center">
                    <ColorPicker v-model="form.primary_color" :format="'hex'" />
                    <arc-input id="primary_color" type="text" class="mt-1 block w-full" v-model="form.primary_color" />
                </div>
                <arc-input-error :message="form.errors.primary_color" class="mt-2" />
            </div>

            <!-- Secondary Color -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="secondary_color" :value="__('Secondary Color') + ' ('+__('Light')+')'" />
                <div class="flex items-center">
                    <ColorPicker v-model="form.secondary_color" :format="'hex'" />
                    <arc-input id="secondary_color" type="text" class="mt-1 block w-full" v-model="form.secondary_color" />
                </div>
                <arc-input-error :message="form.errors.secondary_color" class="mt-2" />
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
                    primary_color: this.settings.primary_color,
                    secondary_color: this.settings.secondary_color,
                }),
            }
        },
        methods: {
            updateSettings() {
                this.form.post(route('update_theme_settings'), {
                    errorBag: 'updateThemeSettings',
                    preserveScroll: true
                });
            },
        },
    }
</script>
