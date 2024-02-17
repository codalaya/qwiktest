<template>
    <div class="overflow-y-auto h-screen px-2">
        <div class="bg-gray-100 py-4 lg:py-4 rounded">
            <div class="container px-6 mx-auto flex ltr:flex-row rtl:flex-row-reverse">
                <div>
                    <h4 class="text-base font-semibold leading-tight text-gray-800">
                        {{ title }}
                    </h4>
                </div>
            </div>
        </div>
        <div v-if="loading" class="my-6 w-11/12 mx-auto xl:w-full xl:mx-0">
            <form-input-shimmer></form-input-shimmer>
            <form-input-shimmer></form-input-shimmer>
            <form-input-shimmer></form-input-shimmer>
        </div>
        <div v-else class="mt-6 w-11/12 mx-auto xl:w-full xl:mx-0">
            <div>
                <dl>
                    <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                        <dt class="text-sm font-medium text-gray-500">
                            {{ __('Subscription ID') }}
                        </dt>
                        <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                            {{ subscription.code }}
                        </dd>
                    </div>
                    <div class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                        <dt class="text-sm font-medium text-gray-500">
                            {{ __('Plan') }}
                        </dt>
                        <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                            {{ subscription.plan }}
                        </dd>
                    </div>
                    <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                        <dt class="text-sm font-medium text-gray-500">
                            {{ __('Payment User') }}
                        </dt>
                        <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                            {{ subscription.user }}
                        </dd>
                    </div>
                    <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                        <dt class="text-sm font-medium text-gray-500">
                            {{ __('Subscription Starts') }}
                        </dt>
                        <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                            {{ subscription.starts }}
                        </dd>
                    </div>
                    <div class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                        <dt class="text-sm font-medium text-gray-500">
                            {{ __('Subscription Ends') }}
                        </dt>
                        <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                            {{ subscription.ends }}
                        </dd>
                    </div>
                    <div v-if="!editFlag" class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                        <dt class="text-sm font-medium text-gray-500">
                            {{ __('Status') }}
                        </dt>
                        <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2 uppercase">
                            {{ subscription.status }} <span class="ml-2 text-xs text-blue-500 cursor-pointer underline" @click="editFlag = true">{{ __('Edit') }}</span>
                        </dd>
                    </div>
                    <div v-if="editFlag" class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                        <dt class="text-sm font-medium text-gray-500">
                            {{ __('Update Status') }}
                        </dt>
                        <dd class="mt-1 sm:mt-0 sm:col-span-2">
                            <form @submit.prevent="update">
                                <!-- Status -->
                                <div class="col-span-6 sm:col-span-4">
                                    <arc-label for="status">
                                       {{ __('Status') }} <span class="ml-2 text-xs text-blue-500 cursor-pointer underline" @click="editFlag = false">{{ __('Close') }}</span>
                                    </arc-label>
                                    <v-select id="status" v-model="form.status" :options="statusTypes"
                                              :reduce="t => t.value" label="text" :dir="$page.props.rtl ? 'rtl' : 'ltr'"/>
                                    <arc-input-error v-if="errors !== undefined && errors.status" :message="errors.status" class="mt-2" />
                                </div>
                                <arc-button :class="{ 'opacity-25': form.processing }" class="mt-1" :disabled="form.processing">
                                    {{ __('Update') }}
                                </arc-button>
                            </form>
                        </dd>
                    </div>
                    <div class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                        <dt class="text-sm font-medium text-gray-500">
                            {{ __('Payment Method') }}
                        </dt>
                        <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                            {{ subscription.payment }}
                        </dd>
                    </div>
                    <div v-if="subscription.payment_id" class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                        <dt class="text-sm font-medium text-gray-500">
                            {{ __('Online Payment Details') }}
                        </dt>
                        <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                            <ul role="list" class="border border-gray-200 rounded-md divide-y divide-gray-200">
                                <li class="pl-3 pr-4 py-3 flex items-center justify-between text-sm">
                                    <div class="w-0 flex-1 flex items-center">
                                        <svg class="flex-shrink-0 h-4 w-6 text-gray-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="none" stroke="currentColor" aria-hidden="true">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"></path>
                                        </svg>
                                        <span class="ml-2 flex-1 w-0 truncate">{{ subscription.payment_id }}</span>
                                    </div>
                                    <div class="ml-4 flex-shrink-0">
                                        <a :href="route('download_invoice', {id: subscription.payment_id})" target="_blank" class="font-medium text-indigo-600 hover:text-indigo-500">
                                            {{ __('View Invoice') }}
                                        </a>
                                    </div>
                                </li>
                            </ul>
                        </dd>
                    </div>
                </dl>
            </div>
        </div>
    </div>
</template>
<script>
    import FormInputShimmer from "@/Components/Shimmers/FormInputShimmer";
    import ArcLabel from "@/Components/Label";
    import ArcInputError from "@/Components/InputError";
    import ArcButton from "@/Components/Button";
    export default {
        name: 'SubscriptionDetails',
        components: {
            FormInputShimmer,
            ArcLabel,
            ArcInputError,
            ArcButton
        },
        props: {
            subscriptionId: Number,
            statusTypes: Array,
            errors: Object,
            title: ''
        },
        data() {
            return {
                subscription: Object,
                form: {
                    status: '',
                },
                loading: false,
                editFlag: false,
            }
        },
        methods: {
            update() {
                this.formValidated = true;
                this.$inertia.patch(route('subscriptions.update', { id: this.subscriptionId }), this.form, {
                    onSuccess: () => {
                        if (Object.keys(this.errors).length === 0) {
                            this.$emit('close', true);
                        }
                    },
                });
            },
            fetch() {
                let _this = this;
                _this.loading = true;
                axios.get(route('subscriptions.show', { id: this.subscriptionId }))
                    .then(function (response) {
                        _this.subscription = response.data.subscription;
                        _this.form.status = response.data.subscription.status;
                    })
                    .catch(function (error) {
                        _this.loading = false;
                    })
                    .then(function () {
                        _this.loading = false;
                    });
            }
        },
        mounted() {
            this.fetch();
        }
    }
</script>
