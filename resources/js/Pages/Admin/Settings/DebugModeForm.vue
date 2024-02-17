<template>
    <arc-action-section>
        <template #title>
            {{ __('Debug Mode') }}
        </template>

        <template #content>
            <div class="max-w-xl text-sm text-gray-600">
                {{ __('Enabling debug mode will expose sensitive data.') }}
            </div>

            <div class="flex flex-col mt-5">
                <!-- Enable/Disable Debug Mode -->
                <div class="flex gap-6 mb-4">
                    <arc-label for="debug_mode">
                        {{ __('Debug Mode') }} ({{ debugMode ? __('Enabled') : __('Disabled') }})
                    </arc-label>
                    <div class="inline-block cursor-pointer rounded-full relative shadow-sm">
                        <InputSwitch id="debug_mode" v-model="mode" />
                    </div>
                </div>
                <arc-confirms-password @confirmed="updateMode">
                    <arc-button type="button" :class="{ 'opacity-25': loading }" :disabled="loading">
                        {{ __('Save') }}
                    </arc-button>
                </arc-confirms-password>
            </div>
        </template>
    </arc-action-section>
</template>

<script>
    import ArcActionMessage from '@/Components/ActionMessage'
    import ArcActionSection from '@/Components/ActionSection'
    import ArcButton from '@/Components/Button'
    import ArcConfirmsPassword from '@/Components/ConfirmsPassword'
    import ArcSecondaryButton from '@/Components/SecondaryButton'
    import ArcLabel from "@/Components/Label";
    import InputSwitch from "primevue/inputswitch";

    export default {
        components: {
            ArcActionMessage,
            ArcActionSection,
            ArcButton,
            ArcConfirmsPassword,
            ArcSecondaryButton,
            ArcLabel,
            InputSwitch,
        },
        props: {
            debugMode: Boolean
        },
        data() {
            return {
                loading: false,
                mode: this.debugMode
            }
        },
        methods: {
            updateMode() {
                this.loading = true;
                this.$inertia.post(route('debug_mode'), {mode: this.mode}, {
                    preserveScroll: true,
                    onSuccess: () => Promise.all([
                        this.loading = false,
                    ]),
                    onFinish: () => (this.loading = false),
                })
            },
        },
    }
</script>
