<template>
    <app-layout>
        <template #header>
            <h1 class="app-heading">{{ __('Withdrawl from Wallet') }}</h1>
        </template>

        <div class="py-8">
            <div class="card">
                <div class="card-body">

                    <form class="max-w-md mx-auto" @submit.prevent="queueWithdrawl">
                        <div>
                            <label for="number-input" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                                amount</label>
                            <input type="number" id="number-input" aria-describedby="helper-text-explanation"
                                v-model="form.amount"
                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                placeholder="eg. 100" required />
                            <arc-input-error v-if="form.errors !== undefined && form.errors.amount"
                                :message="form.errors.amount" class="mt-2" />
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
    name: 'Withdraw',
    components: {
        AppLayout,
        ArcInputError,
    },
    data() {
        return {
            form: this.$inertia.form({
                amount: 30,
            })
        }
    },
    methods: {
        queueWithdrawl() {
            this.form.post(route('withdraw'), {
                onSuccess: (response) => this.$toast.add({ severity: 'success', 'summary': 'Withdraw added.' }),
            })
        }
    }
}

</script>
