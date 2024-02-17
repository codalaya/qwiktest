<template>
    <arc-form-section @submitted="updateSettings">
        <template #title>
            {{ __('Hero Settings') }}
        </template>

        <template #form>
            <!-- Hero Title -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="title" :value="__('Title')" />
                <arc-input id="title" type="text" class="mt-1 block w-full" v-model="form.title" autocomplete="title" />
                <arc-input-error :message="form.errors.title" class="mt-2" />
            </div>

            <!-- Hero Subtitle -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="subtitle" :value="__('Subtitle')" />
                <arc-text-area id="subtitle" class="mt-1 block w-full" v-model="form.subtitle" />
                <arc-input-error :message="form.errors.subtitle" class="mt-2" />
            </div>

            <!-- CTA Text -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="cta_text" :value="__('CTA Text')" />
                <arc-input id="cta_text" type="text" class="mt-1 block w-full" v-model="form.cta_text" autocomplete="cta_text" />
                <arc-input-error :message="form.errors.cta_text" class="mt-2" />
            </div>

            <!-- CTA Link -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="cta_link" :value="__('CTA Link')" />
                <arc-input id="cta_link" type="text" class="mt-1 block w-full" v-model="form.cta_link" autocomplete="cta_link" />
                <arc-input-error :message="form.errors.cta_link" class="mt-2" />
            </div>


            <!-- Hero Image Path -->
            <div class="col-span-6 sm:col-span-4">
                <input type="file" class="hidden"
                       ref="image"
                       @change="updateImagePreview">

                <arc-label for="image" :value="__('Image')" />

                <div class="mt-2" v-show="!imagePreview">
                    <img :src="$page.props.assetUrl + settings.image_path" alt="Hero Image" class="h-64 object-cover">
                </div>

                <!-- New Hero Image Preview -->
                <div class="mt-2" v-show="imagePreview">
                                <span class="block h-64"
                                      :style="'background-size: contain; background-repeat: no-repeat; background-position: center center; background-image: url(\'' + imagePreview + '\');'">
                                </span>
                </div>

                <arc-secondary-button class="mt-2 ltr:mr-2 rtl:ml-2" type="button" @click.native.prevent="selectNewImage">
                    {{ __('Select A New Image') }}
                </arc-secondary-button>

                <arc-input-error :message="form.errors.hero_image_path" class="mt-2" />
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
            ArcSecondaryButton,
        },
        props: {
            settings: Object
        },
        data() {
            return {
                form: this.$inertia.form({
                    title: this.settings.title,
                    subtitle: this.settings.subtitle,
                    cta_text: this.settings.cta_text,
                    cta_link: this.settings.cta_link,
                    image_path: this.settings.image_path,
                }),
                imagePreview: null,
            }
        },
        methods: {
            updateSettings() {
                if (this.$refs.image) {
                    this.form.image_path = this.$refs.image.files[0]
                }

                this.form.post(route('update_hero_settings'), {
                    errorBag: 'updateHeroSettings',
                    preserveScroll: true
                });
            },

            selectNewImage() {
                this.$refs.image.click();
            },

            updateImagePreview() {
                const reader = new FileReader();

                reader.onload = (e) => {
                    this.imagePreview = e.target.result;
                };

                reader.readAsDataURL(this.$refs.image.files[0]);
            },
        },
    }
</script>
