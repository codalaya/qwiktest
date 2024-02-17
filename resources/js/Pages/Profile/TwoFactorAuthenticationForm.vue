<template>
    <arc-action-section>
        <template #title>
            {{ __('Two Factor Authentication') }}
        </template>

        <template #content>
            <h3 class="text-lg font-medium text-gray-900" v-if="twoFactorEnabled">
                {{ __('You have enabled two factor authentication') }}.
            </h3>

            <h3 class="text-lg font-medium text-gray-900" v-else>
                {{ __('You have not enabled two factor authentication') }}.
            </h3>

            <div class="mt-3 max-w-xl text-sm text-gray-600">
                <p>
                    {{ __('two_factor_message') }}
                </p>
            </div>

            <div v-if="twoFactorEnabled">
                <div v-if="qrCode">
                    <div class="mt-4 max-w-xl  text-gray-600">
                        <p class="font-semibold">
                            {{ __('tfa_qr_message') }}
                        </p>
                    </div>

                    <div class="mt-4 dark:p-4 dark:w-56 dark:bg-white" v-html="qrCode">
                    </div>
                </div>

                <div v-if="recoveryCodes.length > 0">
                    <div class="mt-4 max-w-xl  text-gray-600">
                        <p class="font-semibold">
                            {{ __('tfa_recovery_message') }}
                        </p>
                    </div>

                    <div class="grid gap-1 max-w-xl mt-4 px-4 py-4 font-mono  bg-gray-100 rounded-lg">
                        <div v-for="code in recoveryCodes" :key="code">
                            {{ code }}
                        </div>
                    </div>
                </div>
            </div>

            <div class="mt-5">
                <div v-if="! twoFactorEnabled">
                    <arc-confirms-password @confirmed="enableTwoFactorAuthentication">
                        <arc-button type="button" :class="{ 'opacity-25': enabling }" :disabled="enabling">
                            {{ __('Enable') }}
                        </arc-button>
                    </arc-confirms-password>
                </div>

                <div v-else>
                    <arc-confirms-password @confirmed="regenerateRecoveryCodes">
                        <arc-secondary-button class="mr-3"
                                        v-if="recoveryCodes.length > 0">
                            {{ __('Regenerate Recovery Codes') }}
                        </arc-secondary-button>
                    </arc-confirms-password>

                    <arc-confirms-password @confirmed="showRecoveryCodes">
                        <arc-secondary-button class="mr-3" v-if="recoveryCodes.length === 0">
                            {{ __('Show Recovery Codes') }}
                        </arc-secondary-button>
                    </arc-confirms-password>

                    <arc-confirms-password @confirmed="disableTwoFactorAuthentication">
                        <arc-danger-button
                                        :class="{ 'opacity-25': disabling }"
                                        :disabled="disabling">
                            {{ __('Disable') }}
                        </arc-danger-button>
                    </arc-confirms-password>
                </div>
            </div>
        </template>
    </arc-action-section>
</template>

<script>
    import ArcActionSection from '@/Components/ActionSection'
    import ArcButton from '@/Components/Button'
    import ArcConfirmsPassword from '@/Components/ConfirmsPassword'
    import ArcDangerButton from '@/Components/DangerButton'
    import ArcSecondaryButton from '@/Components/SecondaryButton'

    export default {
        components: {
            ArcActionSection,
            ArcButton,
            ArcConfirmsPassword,
            ArcDangerButton,
            ArcSecondaryButton,
        },

        data() {
            return {
                enabling: false,
                disabling: false,

                qrCode: null,
                recoveryCodes: [],
            }
        },

        methods: {
            enableTwoFactorAuthentication() {
                this.enabling = true

                this.$inertia.post('/user/two-factor-authentication', {}, {
                    preserveScroll: true,
                    onSuccess: () => Promise.all([
                        this.showQrCode(),
                        this.showRecoveryCodes(),
                    ]),
                    onFinish: () => (this.enabling = false),
                })
            },

            showQrCode() {
                return axios.get('/user/two-factor-qr-code')
                        .then(response => {
                            this.qrCode = response.data.svg
                        })
            },

            showRecoveryCodes() {
                return axios.get('/user/two-factor-recovery-codes')
                        .then(response => {
                            this.recoveryCodes = response.data
                        })
            },

            regenerateRecoveryCodes() {
                axios.post('/user/two-factor-recovery-codes')
                        .then(response => {
                            this.showRecoveryCodes()
                        })
            },

            disableTwoFactorAuthentication() {
                this.disabling = true

                this.$inertia.delete('/user/two-factor-authentication', {
                    preserveScroll: true,
                    onSuccess: () => (this.disabling = false),
                })
            },
        },

        computed: {
            twoFactorEnabled() {
                return ! this.enabling && this.$page.props.user.two_factor_enabled
            }
        }
    }
</script>
