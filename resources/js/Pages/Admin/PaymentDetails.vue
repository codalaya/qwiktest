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
                            {{ __('Payment ID') }}
                        </dt>
                        <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                            {{ payment.payment_id }}
                        </dd>
                    </div>
                    <div class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                        <dt class="text-sm font-medium text-gray-500">
                            {{ __('Plan') }}
                        </dt>
                        <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                            {{ payment.plan }}
                        </dd>
                    </div>
                    <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                        <dt class="text-sm font-medium text-gray-500">
                            {{ __('Date') }}
                        </dt>
                        <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                            {{ payment.date }}
                        </dd>
                    </div>
                    <div class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                        <dt class="text-sm font-medium text-gray-500">
                            {{ __('Amount') }}
                        </dt>
                        <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                            {{ payment.amount }}
                        </dd>
                    </div>
                    <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                        <dt class="text-sm font-medium text-gray-500">
                            {{ __('Subscription User') }}
                        </dt>
                        <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                            {{ payment.user }}
                        </dd>
                    </div>
                    <div class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                        <dt class="text-sm font-medium text-gray-500">
                            {{ __('Payment Method') }}
                        </dt>
                        <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                            {{ payment.method }}
                        </dd>
                    </div>
                    <div v-if="!editFlag" class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                        <dt class="text-sm font-medium text-gray-500">
                            {{ __('Status') }}
                        </dt>
                        <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2 uppercase">
                            {{ payment.status }} <span class="ml-2 text-xs text-blue-500 cursor-pointer underline" @click="editFlag = true">{{ __('Edit') }}</span>
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
                            {{ __('Invoice') }}
                        </dt>
                        <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                            <ul role="list" class="border border-gray-200 rounded-md divide-y divide-gray-200">
                                <li class="pl-3 pr-4 py-3 flex items-center justify-between text-sm">
                                    <div class="w-0 flex-1 flex items-center">
                                        <svg class="flex-shrink-0 h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                                            <path fill-rule="evenodd" d="M8 4a3 3 0 00-3 3v4a5 5 0 0010 0V7a1 1 0 112 0v4a7 7 0 11-14 0V7a5 5 0 0110 0v4a3 3 0 11-6 0V7a1 1 0 012 0v4a1 1 0 102 0V7a3 3 0 00-3-3z" clip-rule="evenodd" />
                                        </svg>
                                        <span class="ml-2 flex-1 w-0 truncate">{{ payment.invoice_no }}</span>
                                    </div>
                                    <div class="ml-4 flex-shrink-0">
                                        <a :href="route('download_invoice', {id: payment.payment_id})" target="_blank" class="font-medium text-indigo-600 hover:text-indigo-500">
                                            {{ __('Download') }}
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
        name: 'PaymentDetails',
        components: {
            FormInputShimmer,
            ArcLabel,
            ArcInputError,
            ArcButton
        },
        props: {
            paymentId: Number,
            statusTypes: Array,
            errors: Object,
            title: ''
        },
        data() {
            return {
                payment: Object,
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
                this.$inertia.patch(route('payments.update', { id: this.paymentId }), this.form, {
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
                axios.get(route('payments.show', { id: this.paymentId }))
                    .then(function (response) {
                        _this.payment = response.data.payment;
                        _this.form.status = response.data.payment.status;
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
