<template>
    <div class="w-full card">
        <div class="card-body">
            <h1 class="text-lg font-semibold text-gray-800 leading-5 mb-4">{{ practiceSet.title }}</h1>
            <div class="w-full flex items-center justify-between">
                <h2 class="font-mono text-gray-600 text-sm">{{ practiceSet.total_questions }} {{ __('Questions') }}</h2>
                <slot name="action"></slot>
            </div>
        </div>
    </div>
</template>
<script>
    export default {
        name: 'PracticeSetCard',
        props: {
            practiceSet: Object
        }
    }
</script>
