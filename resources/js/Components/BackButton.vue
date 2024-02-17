<template>
    <button @click="goBack" class="text-gray-400 flex ltr:flex-row rtl:flex-row-reverse items-center ltr:mr-4 rtl:ml-4 focus:outline-none">
        <svg class="w-6 h-6 rtl:flip" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path></svg>
        <slot></slot>
    </button>
</template>

<script>
    export default {
        methods: {
            goBack() {
                window.history.back();
            }
        }
    }
</script>
