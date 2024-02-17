<template>
    <arc-form-section @submitted="updateSettings">
        <template #title>
            {{ __('Top Bar Settings') }}
        </template>

        <template #form>
            <!-- Message -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="message" :value="__('Message')" />
                <arc-text-area id="message" class="mt-1 block w-full" v-model="form.message" />
                <arc-input-error :message="form.errors.message" class="mt-2" />
            </div>

            <!-- Button Text -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="button_text" :value="__('Button Text')" />
                <arc-input id="button_text" type="text" class="mt-1 block w-full" v-model="form.button_text" autocomplete="button_text" />
                <arc-input-error :message="form.errors.button_text" class="mt-2" />
            </div>

            <!-- Button Link -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="button_link" :value="__('Button Link')" />
                <arc-input id="button_link" type="text" class="mt-1 block w-full" v-model="form.button_link" autocomplete="hero_cta_text" />
                <arc-input-error :message="form.errors.button_link" class="mt-2" />
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

    export default {
        components: {
            AdminLayout,
            ArcActionMessage,
            ArcButton,
            ArcFormSection,
            ArcInput,
            ArcTextArea,
            ArcInputError,
            ArcLabel,
        },
        props: {
            settings: Object
        },
        data() {
            return {
                form: this.$inertia.form({
                    message: this.settings.message,
                    button_text: this.settings.button_text,
                    button_link: this.settings.button_link,
                }),
            }
        },
        methods: {
            updateSettings() {
                this.form.post(route('update_top_bar_settings'), {
                    errorBag: 'updateTopBarSettings',
                    preserveScroll: true
                });
            },
        },
    }
</script>
