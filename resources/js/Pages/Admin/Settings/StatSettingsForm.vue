<template>
    <arc-form-section @submitted="updateSettings">
        <template #title>
            {{ __('Statistics Settings') }}
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

            <div v-for="stat in stats" class="p-4 bg-gray-50 rounded-md col-span-6 sm:sol-span-4">
                <div class="col-span-12 py-3 font-bold border-b border-gray-200">
                    <span>{{ __('Statistic') }} {{ stat }}</span>
                </div>

                <!-- Stat Name -->
                <div class="col-span-12 py-3">
                    <arc-label :for="'stat'+stat+'_name'" :value="__('Name')" />
                    <arc-input :id="'stat'+stat+'_name'" type="text" class="mt-1 block w-full" v-model="form['stat'+stat+'_name']" />
                    <arc-input-error :message="form.errors['stat'+stat+'_name']" class="mt-2" />
                </div>

                <!-- Stat Count -->
                <div class="col-span-12 py-3">
                    <arc-label :for="'stat'+stat+'_count'" :value="__('Count')" />
                    <arc-input :id="'stat'+stat+'_count'" type="text" class="mt-1 block w-full" v-model="form['stat'+stat+'_count']" />
                    <arc-input-error :message="form.errors['stat'+stat+'_count']" class="mt-2" />
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
                stats: [1,2,3],
                form: this.$inertia.form({
                    title: this.settings.title,
                    subtitle: this.settings.subtitle,
                    stat1_count: this.settings.stat1[0],
                    stat1_name: this.settings.stat1[1],
                    stat2_count: this.settings.stat2[0],
                    stat2_name: this.settings.stat2[1],
                    stat3_count: this.settings.stat3[0],
                    stat3_name: this.settings.stat3[1],
                }),
            }
        },
        methods: {
            updateSettings() {
                this.form.post(route('update_stat_settings'), {
                    errorBag: 'updateStatSettings',
                    preserveScroll: true
                });
            },
        },
    }
</script>
