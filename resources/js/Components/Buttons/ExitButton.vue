<template>
    <div class="h-10 flex items-center justify-center gap-2 px-4 py-2 bg-yellow-500 hover:bg-yellow-600 text-white text-sm rounded border border-yellow-300 cursor-pointer">
        <span class="hidden sm:block">{{ name }}</span>
        <svg class="w-5 h-5 rtl:flip" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path></svg>
    </div>
</template>
<script>
    export default {
        props: {
            name: {
                type: String,
                default: 'Exit',
            },
        }
    }
</script>
