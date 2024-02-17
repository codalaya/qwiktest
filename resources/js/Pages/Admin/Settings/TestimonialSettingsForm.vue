<template>
    <arc-form-section @submitted="updateSettings">
        <template #title>
            {{ __('Testimonial Settings') }}
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

            <div v-for="testimonial in testimonials" class="p-4 bg-gray-50 rounded-md col-span-6 sm:sol-span-4">
                <div class="col-span-12 py-3 font-bold border-b border-gray-200">
                    <span>{{ __('Testimonial') }} {{ testimonial }}</span>
                </div>
                <!-- Testimonial Name -->
                <div class="col-span-12 py-3">
                    <arc-label :for="'testimonial'+testimonial+'_name'" :value="__('Name')" />
                    <arc-input :id="'testimonial'+testimonial+'_name'" type="text" class="mt-1 block w-full" v-model="form['testimonial'+testimonial+'_name']" />
                    <arc-input-error :message="form.errors['testimonial'+testimonial+'_name']" class="mt-2" />
                </div>

                <!-- Testimonial Designation -->
                <div class="col-span-12 py-3">
                    <arc-label :for="'testimonial'+testimonial+'_designation'" :value="__('Designation')" />
                    <arc-input :id="'testimonial'+testimonial+'_designation'" type="text" class="mt-1 block w-full" v-model="form['testimonial'+testimonial+'_designation']" />
                    <arc-input-error :message="form.errors['testimonial'+testimonial+'_designation']" class="mt-2" />
                </div>

                <!-- Testimonial Message -->
                <div class="col-span-12 py-3">
                    <arc-label :for="'testimonial'+testimonial+'_message'" :value="__('Message')" />
                    <arc-text-area :id="'testimonial'+testimonial+'_message'" class="mt-1 block w-full" v-model="form['testimonial'+testimonial+'_message']" />
                    <arc-input-error :message="form.errors['testimonial'+testimonial+'_message']" class="mt-2" />
                </div>

                <!-- Testimonial Image -->
                <div class="col-span-12 py-3">
                    <arc-label :for="'testimonial'+testimonial+'_image'" :value="__('Image')" />
                    <arc-input :id="'testimonial'+testimonial+'_image'" type="text" class="mt-1 block w-full" v-model="form['testimonial'+testimonial+'_image']" />
                    <arc-input-error :message="form.errors['testimonial'+testimonial+'_image']" class="mt-2" />
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
                testimonials: [1,2],
                form: this.$inertia.form({
                    title: this.settings.title,
                    subtitle: this.settings.subtitle,
                    testimonial1_name: this.settings.testimonial1[0],
                    testimonial1_designation: this.settings.testimonial1[1],
                    testimonial1_message: this.settings.testimonial1[2],
                    testimonial1_image: this.settings.testimonial1[3],
                    testimonial2_name: this.settings.testimonial2[0],
                    testimonial2_designation: this.settings.testimonial2[1],
                    testimonial2_message: this.settings.testimonial2[2],
                    testimonial2_image: this.settings.testimonial2[3],
                }),
            }
        },
        methods: {
            updateSettings() {
                this.form.post(route('update_testimonial_settings'), {
                    errorBag: 'updateTestimonialSettings',
                    preserveScroll: true
                });
            },
        },
    }
</script>
