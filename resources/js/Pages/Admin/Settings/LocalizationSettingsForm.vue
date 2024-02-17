<template>
    <arc-form-section @submitted="updateSettings">
        <template #title>
            {{ __('Localization Settings') }}
        </template>

        <template #form>
            <!-- Default Locale -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="locale" :value="__('Default Locale')" />
                <v-select id="locale" v-model="form.default_locale" :options="languages"
                          :reduce="lang => lang.id" label="name" placeholder="Select a Locale" :dir="$page.props.rtl ? 'rtl' : 'ltr'"/>
                <arc-input-error :message="form.errors.default_locale" class="mt-2" />
            </div>
            <div class="col-span-6 sm:col-span-4">
                <p v-if="form.default_locale" class="font-mono px-2 py-1 inline-block bg-blue-100 text-gray-600 rounded text-sm">
                    <strong>"{{ form.default_locale }}.json"</strong> {{ __('language_file_message') }}
                <p/>
            </div>
            <!-- Default Direction -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="direction" :value="__('Default Direction')" />
                <v-select id="direction" v-model="form.default_direction" :options="directions"
                          :reduce="lang => lang.id" label="name" placeholder="Select a Direction" :dir="$page.props.rtl ? 'rtl' : 'ltr'"/>
                <arc-input-error :message="form.errors.default_direction" class="mt-2" />
            </div>
            <!-- Default Timezone -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="timezone" :value="__('Default Timezone')" />
                <v-select id="timezone" v-model="form.default_timezone" :options="timezones"
                          placeholder="Select a Timezone" :dir="$page.props.rtl ? 'rtl' : 'ltr'"/>
                <arc-input-error :message="form.errors.default_timezone" class="mt-2" />
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
    import ArcSecondaryButton from "@/Components/SecondaryButton";
    import vSelect from "vue-select";

    export default {
        name: "LocalizationSettingsForm",
        components: {
            AdminLayout,
            ArcActionMessage,
            ArcButton,
            ArcFormSection,
            ArcInput,
            ArcTextArea,
            ArcInputError,
            ArcLabel,
            ArcSecondaryButton,
            vSelect
        },
        props: {
            settings: Object,
            timezones: Array,
            languages: Array
        },
        data() {
            return {
                form: this.$inertia.form({
                    default_locale: this.settings.default_locale,
                    default_direction: this.settings.default_direction,
                    default_timezone: this.settings.default_timezone,
                }),
                directions: [
                    {
                        id: 'ltr',
                        name: 'Left to Right (LTR)'
                    },
                    {
                        id: 'rtl',
                        name: 'Right to Left (RTL)'
                    }
                ],
                imagePreview: null,
            }
        },
        methods: {
            updateSettings() {
                this.form.post(route('update_localization_settings'), {
                    errorBag: 'updateLocalizationSettings',
                    preserveScroll: true
                });
            },
        },
    }
</script>
