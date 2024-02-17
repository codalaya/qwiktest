<template>
    <div class="text-center">
        <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
        </svg>
        <h3 class="mt-2 text-lg font-medium text-gray-900">{{ __(title) }}</h3>
        <p class="mt-1 text-gray-500">
            {{ __(message) }}
        </p>
        <div class="mt-6">
            <a :href="route('pricing')" class="inline-flex items-center px-4 py-2 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-primary hover:opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-current">
                {{ __(buttonText) }}
            </a>
        </div>
    </div>
</template>
<script>
    export default {
        name: "ContentLocked",
        props: {
            title: {
                type: String,
                default: 'Subscribe to Access'
            },
            message: {
                type: String,
                default: 'You don\'t have an active plan to see this content. Please subscribe.'
            },
            buttonText: {
                type: String,
                default: 'See Pricing'
            }
        }
    }
</script>
