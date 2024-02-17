<template>
    <div class="flex justify-between items-center mb-2">
        <div class="relative inline-flex">
            <h4 class="py-4 text-xl font-semibold leading-tight text-primary">{{ __(title) }}</h4>
            <slot v-if="$slots.icon" name="icon"></slot>
        </div>
        <slot v-if="$slots.action" name="action"></slot>
    </div>
</template>
<script>
    export default {
        name: "SectionHeader",
        props: {
            title: String
        }
    }
</script>
