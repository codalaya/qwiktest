<template>
    <app-layout>
        <template #header>
            <h1 class="app-heading">{{ __('Update Bank Details') }}</h1>
        </template>

        <div class="py-8">
            <div class="card">
                <div class="card-body">
                    <form class="max-w-md mx-auto" @submit.prevent="updateBankDetails">

                        <div class="mt-4">
                            <label for="number-input" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                                Select Preferred Method</label>
                            <select id="preferred" v-model="form.preferred"
                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                                <option value="" disabled>Select Preferred Method</option>
                                <option value="bank">Bank Account</option>
                                <option value="upi">UPI</option>
                            </select>
                            <arc-input-error v-if="form.errors !== undefined && form.errors.bank_account_no"
                                :message="form.errors.bank_account_no" class="mt-2" />
                        </div>
                        <div class="mt-4">
                            <label for="number-input" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                                Bank Account No</label>
                            <input type="text" aria-describedby="helper-text-explanation" v-model="form.bank_account_no"
                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                placeholder="" required />
                            <arc-input-error v-if="form.errors !== undefined && form.errors.bank_account_no"
                                :message="form.errors.bank_account_no" class="mt-2" />
                        </div>
                        <div class="mt-4">
                            <label for="number-input" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                                Bank IFSC</label>
                            <input type="text" aria-describedby="helper-text-explanation" v-model="form.bank_account_ifsc"
                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                placeholder="eg. 100" required />
                            <arc-input-error v-if="form.errors !== undefined && form.errors.bank_account_ifsc"
                                :message="form.errors.bank_account_ifsc" class="mt-2" />
                        </div>
                        <div class="mt-4">
                            <label for="number-input" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                                Account Owner Name </label>
                            <input type="text" aria-describedby="helper-text-explanation" v-model="form.account_owner_name"
                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                placeholder="" required />
                            <arc-input-error v-if="form.errors !== undefined && form.errors.account_owner_name"
                                :message="form.errors.account_owner_name" class="mt-2" />
                        </div>
                        <div class="mt-4">
                            <label for="number-input" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                                UPI ID </label>
                            <input type="text" aria-describedby="helper-text-explanation" v-model="form.upi_id"
                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                placeholder="" required />
                            <arc-input-error v-if="form.errors !== undefined && form.errors.upi_id"
                                :message="form.errors.upi_id" class="mt-2" />
                        </div>

                        <div class="flex justify-center mt-4">
                            <button type="submit"
                                class="text-gray-900 w-full bg-white border border-gray-300 focus:outline-none hover:bg-gray-100 focus:ring-4 focus:ring-gray-100 font-medium rounded-lg text-sm px-5 py-2.5 me-2 mb-2 dark:bg-gray-800 dark:text-white dark:border-gray-600 dark:hover:bg-gray-700 dark:hover:border-gray-600 dark:focus:ring-gray-700">Submit
                            </button>
                        </div>
                    </form>

                </div>
            </div>


        </div>
    </app-layout>
</template>

<script>
import AppLayout from '@/Layouts/AppLayout.vue'
import ArcInputError from "@/Components/InputError";


export default {
    name: 'BankDetails',
    components: {
        AppLayout,
        ArcInputError
    },
    props: {
        owner_name: String,
        ifsc_code: String,
        account_no: String,
        preferred: String,
        upi_id: String,
    },
    data() {
        return {
            form: this.$inertia.form({
                bank_account_no: this.account_no,
                bank_account_ifsc: this.ifsc_code,
                account_owner_name: this.owner_name,
                upi_id: this.upi_id,
                preferred: this.preferred,
            })
        }
    },
    methods: {
        updateBankDetails() {
            this.form.post(route('bank-details'), {
                onSuccess: (response) => this.$toast.add({ severity: 'success', 'summary': 'Bank Detials added.' }),
            })
        }
    },
    mounted() {
        console.log(this.$page.props)
    }
}

</script>
