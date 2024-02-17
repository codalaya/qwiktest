<template>
    <div class="fib-options">
        <div class="transition duration-150 ease-in-out w-full mx-auto py-3 px-4 bg-white lg:flex items-center justify-between shadow rounded">
            <div class="lg:flex sm:items-start lg:items-center">
                <div class="flex items-end">
                    <div class="ltr:mr-2 rtl:ml-2 text-red-400">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" fill="currentColor">
                            <path class="heroicon-ui" d="M12 22a10 10 0 1 1 0-20 10 10 0 0 1 0 20zm0-2a8 8 0 1 0 0-16 8 8 0 0 0 0 16zm0-9a1 1 0 0 1 1 1v4a1 1 0 0 1-2 0v-4a1 1 0 0 1 1-1zm0-4a1 1 0 1 1 0 2 1 1 0 0 1 0-2z" />
                        </svg>
                    </div>
                    <p class="ltr:mr-2 rtl:ml-2 text-sm font-bold text-red-400">{{ __('Note') }}</p>
                </div>
                <div class="h-1 w-1 bg-gray-300 dark:bg-gray-700 rounded-full ltr:mr-2 rtl:ml-2 hidden xl:block"></div>
                <p class="text-sm text-gray-600 dark:text-gray-400 pt-2 lg:pt-0 pb-2 lg:pb-0 w-4/5 lg:w-auto">
                    {{ __('fib_instruction_note') }}
                </p>
            </div>
        </div>
        <!--<div class="w-full">
            <div class="flex justify-between items-center mb-8">
                <div class="w-9/12">
                    <label for="case_sensitive" class="font-semibold text-gray-800 pb-1">Case Sensitive</label>
                    <p v-if="preferences.case_sensitive" class="text-gray-500">Yes (Answers will be considered as case sensitive).</p>
                    <p v-if="!preferences.case_sensitive" class="text-gray-500">No (Answers will not be considered as case sensitive).</p>
                </div>
                <div class="cursor-pointer rounded-full relative shadow-sm">
                    <InputSwitch id="case_sensitive" v-model="preferences.case_sensitive" />
                </div>
            </div>
            <div class="flex justify-between items-center">
                <div class="w-9/12">
                    <label for="is_numeric" class="font-semibold text-gray-800 pb-1">Is Numeric</label>
                    <p v-if="preferences.is_numeric" class="text-gray-500">Yes (Answers will be considered as numbers).</p>
                    <p v-if="!preferences.is_numeric" class="text-gray-500">No (Answers will not be considered as numbers).</p>
                </div>
                <div class="cursor-pointer rounded-full relative shadow-sm">
                    <InputSwitch id="is_numeric" v-model="preferences.is_numeric" />
                </div>
            </div>
        </div>-->
    </div>
</template>
<script>
    import InputSwitch from 'primevue/inputswitch';
    export default {
        name: 'FIBOptions',
        components: {
            InputSwitch
        },
        props: {
            parentPreferences: Object,
        },
        data: function () {
            return {
                preferences: this.parentPreferences,
            }
        },
        methods: {
            selectAnswer (event) {
                this.$emit('modifyPreferences', this.preferences)
            }
        }
    }
</script>
