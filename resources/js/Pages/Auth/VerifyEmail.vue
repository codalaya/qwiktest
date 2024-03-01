<template>
    <arc-authentication-card>
        <template #logo>
            <application-logo />
        </template>

        <div class="mb-4 text-sm text-gray-600">
            {{ __('verify_email_message') }}
        </div>

        <div class="mb-4 font-medium text-sm text-green-600" v-if="verificationLinkSent">
            {{ __('verification_link_sent') }}
        </div>

        <form @submit.prevent="submit">
            <div class="mt-4 flex items-center justify-between">
                <arc-button :class="{ 'opacity-25': form.processing }" :disabled="form.processing">
                    {{ __('Resend Verification Email') }}
                </arc-button>
            </div>
        </form>
        <div class="flex justify-center">
            <button @click="logout" method="post" as="button" class="underline text-sm text-gray-600 hover:text-gray-900">{{
                __('Logout') }}</button>
        </div>
    </arc-authentication-card>
</template>

<script>
import ArcAuthenticationCard from '@/Components/AuthenticationCard'
import ArcButton from '@/Components/Button'
import ApplicationLogo from "@/Components/ApplicationLogo";

export default {
    components: {
        ArcAuthenticationCard,
        ArcButton,
        ApplicationLogo
    },

    props: {
        status: String
    },

    data() {
        return {
            form: this.$inertia.form()
        }
    },

    metaInfo() {
        return {
            title: this.title
        }
    },

    methods: {
        submit() {
            this.form.post(this.route('verification.send'))
        },
        logout() {
            // this.$inertia.post(route('logout'), {
            //     onSuccess: (r) => {
            //         console.log('loggint out');
            //         location.reload();
            //     }
            // })
            axios.post(route('logout')).then(re => {
                console.log('logoging out');
                location.reload();
            })
        }
    },

    computed: {
        verificationLinkSent() {
            return this.status === 'verification-link-sent';
        },
        title() {
            return this.__('Verification Email') + ' - ' + this.$page.props.general.app_name;
        }
    }
}
</script>
