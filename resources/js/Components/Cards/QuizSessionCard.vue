<template>
    <div class="w-full flex flex-col justify-between items-start rounded shadow bg-white py-6 px-6 hover:shadow-lg">
        <div class="flex items-center justify-center bg-green-100 rounded mb-1">
            <p class="font-mono text-xs leading-loose text-center text-green-700 px-2">{{ quizSession.quizType }}</p>
        </div>
        <h1 class="text-lg font-semibold text-gray-800 leading-5 py-2">{{ quizSession.title }}</h1>
        <div class="w-full flex items-end justify-between mt-4">
            <slot name="action"></slot>
        </div>
    </div>
</template>
<script>
    export default {
        name: 'PracticeSessionCard',
        props: {
            quizSession: Object
        }
    }
</script>
