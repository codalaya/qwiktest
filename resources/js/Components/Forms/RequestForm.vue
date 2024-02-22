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
        <div v-else>
            <div class="container mx-auto my-4">
                <Message severity="warn" :closable="false">Make sure to transfer money to ser first before marking
                    request status completed.</Message>

                <div class="grid md:grid-cols-2 gap-4 mt-4">
                    <div class="md:col-span-2">
                        <div class="text-sm">Name</div>
                        <div class="text-base text-black">{{ userData.account_owner_name }}</div>
                    </div>
                    <div>
                        <div class="text-sm">Bank Accout No</div>
                        <div class="text-base text-black">{{ userData.bank_account_no }}</div>
                    </div>
                    <div>
                        <div class="text-sm">IFSC</div>
                        <div class="text-base text-black">{{ userData.bank_account_ifsc }}</div>
                    </div>
                    <div>
                        <div class="text-sm">Requested Amount</div>
                        <div class="text-base text-black">{{ userData.amount }}</div>
                    </div>
                    <div>
                        <div class="text-sm">Preferred Method of Payment</div>
                        <div class="text-base text-black">{{ userData.preferred_payment_method }}</div>
                    </div>

                    <div>
                        <div class="text-sm">UPI</div>
                        <div class="text-base text-black">{{ userData.upi_id }}</div>
                    </div>
                </div>
            </div>


            <form class="my-6 w-11/12 mx-auto xl:w-full xl:mx-0" @submit.prevent="submitForm">
                <label for="status" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Select your
                    country</label>
                <select id="status" v-model="form.status"
                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                    <option value="completed">Completed</option>
                    <option value="pending">Pending</option>
                </select>
                <div class="w-full flex mt-4">
                    <Button type="submit" :label="editFlag ? __('Update') : __('Create')" />
                </div>
            </form>
        </div>
    </div>
</template>
<script>
import InputText from 'primevue/inputtext';
import Button from 'primevue/button';
import InputSwitch from 'primevue/inputswitch';
import TextEditor from "@/Components/TextEditor";
import FormInputShimmer from "@/Components/Shimmers/FormInputShimmer";
import FormSwitchShimmer from "@/Components/Shimmers/FormSwitchShimmer";
import vSelect from "vue-select";
import Message from 'primevue/message';

export default {
    name: 'UserForm',
    components: {
        InputText,
        Button,
        InputSwitch,
        TextEditor,
        FormInputShimmer,
        FormSwitchShimmer,
        vSelect, Message,
    },
    props: {
        editFlag: Boolean,
        requestId: Number,
        formErrors: Object,
        title: ''
    },
    data() {
        return {
            errors: {},
            userData: {},
            form: {
                status: '',
                _method: 'PATCH',
            },
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
            this.editFlag ? this.update() : this.create();
        },

        create() {
            this.$toast.add({
                severity: 'danger',
                summary: 'This function is not implemented.',
            })
        },

        update() {
            this.formValidated = true;
            this.$inertia.patch(route('withdrawl-requests.update', { id: this.requestId }), this.form, {
                onSuccess: () => {
                    if (Object.keys(this.errors).length === 0) {
                        this.$emit('close', true);
                    }
                },
            });
        },
        fetch() {
            if (this.editFlag) {
                let _this = this;
                _this.loading = true;
                axios.get(route('withdrawl-requests.edit', { id: this.requestId }))
                    .then(function (response) {
                        let data = response.data;
                        _this.userData.account_owner_name = data.account_owner_name;
                        _this.userData.bank_account_no = data.bank_account_no;
                        _this.userData.bank_account_ifsc = data.bank_account_ifsc;
                        _this.userData.preferred_payment_method = data.preferred_payment_method;
                        _this.userData.upi_id = data.upi_id;
                        _this.form.status = data.status;
                        _this.userData.amount = data.amount;

                    })
                    .catch(function (error) {
                        _this.loading = false;
                    })
                    .then(function () {
                        _this.loading = false;
                    });
            }
        }
    },
    mounted() {
        if (this.editFlag === true) {
            this.fetch();
        }
    }
}
</script>
