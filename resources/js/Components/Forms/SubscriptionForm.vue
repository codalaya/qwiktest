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
            <form-switch-shimmer></form-switch-shimmer>
        </div>
        <form v-else class="my-6 w-11/12 mx-auto xl:w-full xl:mx-0" @submit.prevent="submitForm">
            <!-- User Dropdown -->
            <div class="w-full flex flex-col mb-6">
                <label for="user_id" class="pb-2 font-semibold text-gray-800">{{ __('User') }}<span class="ml-1 text-red-400">*</span></label>
                <v-select id="user_id" v-model="form.user_id" :options="users" :reduce="user => user.id" label="name" @search="searchUsers" :placeholder="__('Choose User')" :dir="$page.props.rtl ? 'rtl' : 'ltr'">
                    <template v-slot:no-options="{ search, searching }">
                        <template v-if="searching">{{ __('No results were found for this search') }}.</template>
                        <em v-else class="opacity-50">{{ __('Start typing to search') }}.</em>
                    </template>
                </v-select>
                <small id="user_id-help" v-if="errors.user_id" class="p-invalid">{{ errors.user_id }}</small>
            </div>

            <!-- Plan Dropdown -->
            <div class="w-full flex flex-col mb-6">
                <label for="plan_id" class="pb-2 font-semibold text-gray-800">{{ __('Plan') }}<span class="ml-1 text-red-400">*</span></label>
                <v-select id="plan_id" v-model="form.plan_id" :options="plans" :reduce="plan => plan.id" label="name" @search="searchPlans" :placeholder="__('Choose Plan')" :dir="$page.props.rtl ? 'rtl' : 'ltr'">
                    <template v-slot:no-options="{ search, searching }">
                        <template v-if="searching">{{ __('No results were found for this search') }}.</template>
                        <em v-else class="opacity-50">{{ __('Start typing to search') }}.</em>
                    </template>
                </v-select>
                <small id="plan_id-help" v-if="errors.plan_id" class="p-invalid">{{ errors.plan_id }}</small>
            </div>

            <!-- Status Dropdown -->
            <div class="w-full flex flex-col mb-6">
                <label for="status" class="pb-2 font-semibold text-gray-800">{{ __('Status') }}<span class="ml-1 text-red-400">*</span></label>
                <v-select id="status" v-model="form.status" :options="statusTypes" :reduce="status => status.value" label="text" :placeholder="__('Choose Status')" :dir="$page.props.rtl ? 'rtl' : 'ltr'">
                    <template v-slot:no-options="{ search, searching }">
                        <template v-if="searching">{{ __('No results were found for this search') }}.</template>
                        <em v-else class="opacity-50">{{ __('Start typing to search') }}.</em>
                    </template>
                </v-select>
                <small id="status-help" v-if="errors.status" class="p-invalid">{{ errors.status }}</small>
            </div>

            <!-- Submit Button -->
            <div class="w-full flex">
                <Button type="submit" :label="__('Create')" />
            </div>
        </form>
    </div>
</template>
<script>
    import Button from 'primevue/button';
    import InputSwitch from 'primevue/inputswitch';
    import FormInputShimmer from "@/Components/Shimmers/FormInputShimmer";
    import FormSwitchShimmer from "@/Components/Shimmers/FormSwitchShimmer";
    import vSelect from "vue-select";
    export default {
        name: 'SubscriptionForm',
        components: {
            Button,
            InputSwitch,
            FormInputShimmer,
            FormSwitchShimmer,
            vSelect
        },
        props: {
            statusTypes: Array,
            formErrors: Object,
            title: ''
        },
        data() {
            return {
                errors: {},
                form: {
                    user_id: null,
                    plan_id: null,
                    status: '',
                },
                plans: [],
                users: [],
                debounce: null,
                formValidated: false,
                loading: false,
            }
        },
        watch: {
            formErrors(val) {
                this.errors = val;
            },
        },
        methods: {
            submitForm() {
                this.formValidated = true;
                this.$inertia.post(route('subscriptions.store'), this.form, {
                    onSuccess: () => {
                        if (Object.keys(this.errors).length === 0) {
                            this.$emit('close', true);
                        }
                    },
                });
            },
            searchUsers(search, loading) {
                if(search !== '') {
                    let _this = this;
                    loading(true);
                    clearTimeout(this.debounce);
                    this.users = [];
                    this.debounce = setTimeout(() => {
                        axios.get(route('search_users', {query: search}))
                            .then(function (response) {
                                _this.users = response.data.users;
                                loading(false);
                            })
                            .catch(function (error) {
                                loading(false);
                            });
                    }, 600)
                }
            },
            searchPlans(search, loading) {
                if(search !== '') {
                    let _this = this;
                    loading(true);
                    clearTimeout(this.debounce);
                    this.plans = [];
                    this.debounce = setTimeout(() => {
                        axios.get(route('search_plans', {query: search}))
                            .then(function (response) {
                                _this.plans = response.data.plans;
                                loading(false);
                            })
                            .catch(function (error) {
                                loading(false);
                            });
                    }, 600)
                }
            },
        },
    }
</script>
