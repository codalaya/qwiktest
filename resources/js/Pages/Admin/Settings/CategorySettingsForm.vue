<template>
    <arc-form-section @submitted="updateSettings">
        <template #title>
            {{ __('Category Settings') }}
        </template>

        <template #form>
            <!-- Feature Title -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="title" :value="__('Title')" />
                <arc-input id="title" type="text" class="mt-1 block w-full" v-model="form.title" autocomplete="title" />
                <arc-input-error :message="form.errors.title" class="mt-2" />
            </div>

            <!-- Feature Subtitle -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="subtitle" :value="__('Subtitle')" />
                <arc-text-area id="subtitle" class="mt-1 block w-full" v-model="form.subtitle" />
                <arc-input-error :message="form.errors.subtitle" class="mt-2" />
            </div>

            <!-- Button Text -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="limit" :value="__('Item Limit')" />
                <arc-input id="limit" type="number" class="mt-1 block w-full" v-model="form.limit" />
                <arc-input-error :message="form.errors.limit" class="mt-2" />
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
                    title: this.settings.title,
                    subtitle: this.settings.subtitle,
                    limit: this.settings.limit,
                }),
            }
        },
        methods: {
            updateSettings() {
                this.form.post(route('update_category_settings'), {
                    errorBag: 'updateCategorySettings',
                    preserveScroll: true
                });
            },
        },
    }
</script>
