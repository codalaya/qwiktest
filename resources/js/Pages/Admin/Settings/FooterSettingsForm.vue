<template>
    <arc-form-section @submitted="updateSettings">
        <template #title>
            {{ __('Footer Settings') }}
        </template>

        <template #form>
            <!-- Copyright Text -->
            <div class="col-span-6 sm:col-span-4">
                <arc-label for="copyright_text" :value="__('Copyright Text')" />
                <arc-input id="copyright_text" type="text" class="mt-1 block w-full" v-model="form.copyright_text" />
                <arc-input-error :message="form.errors.copyright_text" class="mt-2" />
            </div>

            <!-- Enable Links -->
            <div class="col-span-6 sm:col-span-4">
                <div class="flex justify-between items-center">
                    <div class="w-9/12">
                        <label for="enable_links" class="text-sm text-gray-800 pb-1">{{ __('Enable Footer Links') }} ({{ form.enable_links ? __('Enabled') : __('Disabled') }})</label>
                    </div>
                    <div class="cursor-pointer rounded-full relative shadow-sm">
                        <InputSwitch id="enable_links" v-model="form.enable_links" />
                    </div>
                </div>
                <arc-input-error :message="form.errors.enable_links" class="mt-2" />
            </div>

            <!-- Footer Links -->
            <div v-for="(link, index) in form.footer_links" class="p-4 bg-gray-50 rounded-md col-span-6 sm:col-span-4">
                <div class="col-span-12 flex justify-between items-center py-3 font-bold border-b border-gray-200">
                    <span>{{ __('Link') }} {{ index+1 }}</span>
                    <div class="cursor-pointer rounded-full relative shadow-sm">
                        <InputSwitch :id="'enable_link_'+index" v-model="form.footer_links[index][2]" />
                    </div>
                </div>
                <!-- Link Text -->
                <div class="col-span-12 py-3">
                    <arc-label :for="'text_'+index" :value="__('Link Text')" />
                    <arc-input :id="'text_'+index" type="text" class="mt-1 block w-full" v-model="form.footer_links[index][0]" />
                    <!--                        <arc-input-error :message="form.errors.footer_links[index][0]" class="mt-2" />-->
                </div>
                <!-- Link -->
                <div class="col-span-12 py-3">
                    <arc-label :for="'link_'+index" :value="__('Link')" />
                    <arc-input :id="'link_'+index" type="text" class="mt-1 block w-full" v-model="form.footer_links[index][1]" />
                    <!--                        <arc-input-error :message="form.errors.footer_links[index][1]" class="mt-2" />-->
                </div>
            </div>

            <!-- Enable Social Links -->
            <div class="col-span-6 sm:col-span-4">
                <div class="flex justify-between items-center">
                    <div class="w-9/12">
                        <label for="enable_social_links" class="text-sm text-gray-800 pb-1">{{ __('Enable Social Links') }} ({{ form.enable_social_links ? __('Enabled') : __('Disabled') }})</label>
                    </div>
                    <div class="cursor-pointer rounded-full relative shadow-sm">
                        <InputSwitch id="enable_social_links" v-model="form.enable_social_links" />
                    </div>
                </div>
                <arc-input-error :message="form.errors.enable_social_links" class="mt-2" />
            </div>

            <!-- Social Links -->
            <div class="p-4 bg-gray-50 rounded-md col-span-6 sm:col-span-4">
                <div class="mb-2" v-for="site in social_sites">
                    <arc-label class="capitalize" :for="site+'_link'" :value="__(site)" />
                    <div class="flex justify-between items-center">
                        <div class="cursor-pointer rounded-full relative shadow-sm">
                            <InputSwitch :id="'enable_'+site" v-model="form['enable_'+site]" />
                        </div>
                        <div class="w-9/12">
                            <arc-input :id="site+'_link'" type="text" class="mt-1 block w-full" v-model="form[site+'_link']" />
                        </div>
                    </div>
                    <arc-input-error :message="form.errors[site+'_link']" class="mt-2" />
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
    import InputSwitch from "primevue/inputswitch";

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
            InputSwitch
        },
        props: {
            settings: Object
        },
        data() {
            return {
                social_sites: ['facebook', 'twitter', 'youtube', 'instagram', 'linkedin', 'github'],
                form: this.$inertia.form({
                    copyright_text: this.settings.copyright_text,
                    enable_links: this.settings.enable_links,
                    footer_links: this.settings.footer_links,
                    enable_social_links: this.settings.enable_social_links,
                    enable_facebook: this.settings.social_links.facebook[1],
                    facebook_link: this.settings.social_links.facebook[2],
                    enable_twitter: this.settings.social_links.twitter[1],
                    twitter_link: this.settings.social_links.twitter[2],
                    enable_youtube: this.settings.social_links.youtube[1],
                    youtube_link: this.settings.social_links.youtube[2],
                    enable_instagram: this.settings.social_links.instagram[1],
                    instagram_link: this.settings.social_links.instagram[2],
                    enable_linkedin: this.settings.social_links.linkedin[1],
                    linkedin_link: this.settings.social_links.linkedin[2],
                    enable_github: this.settings.social_links.github[1],
                    github_link: this.settings.social_links.github[2]
                }),
            }
        },
        methods: {
            updateSettings() {
                this.form.post(route('update_footer_settings'), {
                    errorBag: 'updateFooterSettings',
                    preserveScroll: true
                });
            },
        },
    }
</script>
