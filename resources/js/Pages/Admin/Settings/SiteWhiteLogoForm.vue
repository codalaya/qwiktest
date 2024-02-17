<template>
    <arc-form-section @submitted="updateSettings">
        <template #title>
            {{ __('Site White Logo') }}
        </template>

        <template #form>

            <!-- Site Logo -->
            <div class="col-span-6 sm:col-span-4">
                <input id="white_logo" type="file" class="hidden"
                       name="white_logo" ref="white_logo"
                       @change="updateLogoPreview">

                <arc-label for="logo" :value="__('Site White Logo')" />

                <div class="p-4 bg-gray-500 rounded my-4" v-show="!logoPreview">
                    <img :src="$page.props.assetUrl + settings.white_logo_path" :alt="settings.app_name" class="h-10 object-cover">
                </div>

                <!-- New Logo Preview -->
                <div class="p-4 bg-gray-500 rounded my-4" v-show="logoPreview">
                    <span class="block h-10"
                          :style="'background-size: contain; background-repeat: no-repeat; background-position: center center; background-image: url(\'' + logoPreview + '\');'">
                                </span>
                </div>

                <arc-secondary-button class="mt-2 ltr:mr-2 rtl:ml-2" type="button" @click.native.prevent="selectNewLogo">
                    {{ __('Select A New Image') }}
                </arc-secondary-button>

                <arc-input-error :message="form.errors.logo_path" class="mt-2" />
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
    import ArcInputError from "@/Components/InputError";
    import ArcLabel from "@/Components/Label";
    import ArcSecondaryButton from "@/Components/SecondaryButton";
    import InputSwitch from "primevue/inputswitch";

    export default {
        components: {
            AdminLayout,
            ArcActionMessage,
            ArcButton,
            ArcFormSection,
            ArcInputError,
            ArcLabel,
            ArcSecondaryButton,
            InputSwitch,
        },
        props: {
            settings: Object,
        },
        data() {
            return {
                form: this.$inertia.form({
                    white_logo_path: this.settings.white_logo_path,
                }),
                logoPreview: null,
            }
        },
        methods: {
            updateSettings() {
                if (this.$refs.white_logo) {
                    this.form.white_logo_path = this.$refs.white_logo.files[0]
                }

                this.form.post(route('update_white_logo'), {
                    errorBag: 'updateWhiteLogo',
                    preserveScroll: true
                });
            },

            selectNewLogo() {
                this.$refs.white_logo.click();
            },

            updateLogoPreview() {
                const logoReader = new FileReader();

                logoReader.onload = (e) => {
                    this.logoPreview = e.target.result;
                };

                logoReader.readAsDataURL(this.$refs.white_logo.files[0]);
            },
        },
    }
</script>
