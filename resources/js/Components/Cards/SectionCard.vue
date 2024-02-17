<template>
    <div class="flex flex-col justify-center items-center p-4 rounded hover:bg-blue-50 cursor-pointer">
        <div class="flex items-center justify-center w-12 h-12 bg-primary rounded-full">
            <span class="font-mono font-semibold text-white">{{ section.name.charAt(0) }}</span>
        </div>
        <div class="pt-4 text-center">
            <p class="text-base leading-none text-primary">{{ section.name }}</p>
        </div>
    </div>
</template>
<script>
    export default {
        name: 'SectionCard',
        props: {
            section: Object
        }
    }
</script>
