<template>
    <arc-form-section @submitted="updateSettings">
        <template #title>
            {{ __('Feature Settings') }}
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

            <div v-for="feature in features" class="p-4 bg-gray-50 rounded-md col-span-6 sm:sol-span-4">
                <div class="col-span-12 py-3 font-bold border-b border-gray-200">
                    <span>{{ __('Feature') }} {{ feature }}</span>
                </div>
                <!-- Feature 1 Caption -->
                <div class="col-span-12 py-3">
                    <arc-label :for="'feature'+feature+'_caption'" :value="__('Caption')" />
                    <arc-input :id="'feature'+feature+'_caption'" type="text" class="mt-1 block w-full" v-model="form['feature'+feature+'_caption']" />
                    <arc-input-error :message="form.errors['feature'+feature+'_caption']" class="mt-2" />
                </div>

                <!-- Feature 1 Description -->
                <div class="col-span-12 py-3">
                    <arc-label :for="'feature'+feature+'_description'" :value="__('Description')" />
                    <arc-text-area :id="'feature'+feature+'_description'" class="mt-1 block w-full" v-model="form['feature'+feature+'_description']" />
                    <arc-input-error :message="form.errors['feature'+feature+'_description']" class="mt-2" />
                </div>

                <!-- Feature 1 Icon URL -->
                <div class="col-span-12 py-3">
                    <arc-label :for="'feature'+feature+'_icon_url'" :value="__('Icon URL') + ' (100x100)'" />
                    <arc-input :id="'feature'+feature+'_icon_url'" type="text" class="mt-1 block w-full" v-model="form['feature'+feature+'_icon_url']" />
                    <arc-input-error :message="form.errors['feature'+feature+'_icon_url']" class="mt-2" />
                </div>
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
                features: [1,2,3,4],
                form: this.$inertia.form({
                    title: this.settings.title,
                    subtitle: this.settings.subtitle,
                    feature1_caption: this.settings.feature1[0],
                    feature1_description: this.settings.feature1[1],
                    feature1_icon_url: this.settings.feature1[2],
                    feature2_caption: this.settings.feature2[0],
                    feature2_description: this.settings.feature2[1],
                    feature2_icon_url: this.settings.feature2[2],
                    feature3_caption: this.settings.feature3[0],
                    feature3_description: this.settings.feature3[1],
                    feature3_icon_url: this.settings.feature3[2],
                    feature4_caption: this.settings.feature4[0],
                    feature4_description: this.settings.feature4[1],
                    feature4_icon_url: this.settings.feature4[2],
                }),
            }
        },
        methods: {
            updateSettings() {
                this.form.post(route('update_feature_settings'), {
                    errorBag: 'updateFeatureSettings',
                    preserveScroll: true
                });
            },
        },
    }
</script>
