<template>
    <div class="w-full card">
        <div class="card-body relative flex flex-col justify-between items-start">
            <h1 class="text-lg font-semibold text-gray-800 leading-5 py-2">{{ exam.title }}</h1>
            <div class="my-4">
                <div class="flex ltr:flex-row rtl:flex-row-reverse items-center">
                    <div>
                        <p class="text-lg font-semibold leading-tight text-green-600">{{ exam.total_questions }}</p>
                        <p class="font-mono text-sm leading-3 mt-2 text-gray-500">{{ __('Questions') }}</p>
                    </div>
                    <div class="ml-11">
                        <p class="text-lg font-semibold leading-tight text-green-600">{{ exam.total_duration }}</p>
                        <p class="font-mono text-sm leading-3 mt-2 text-gray-500">{{ __('Minutes') }}</p>
                    </div>
                    <div class="ml-11">
                        <p class="text-lg font-semibold leading-tight text-green-600">{{ exam.total_marks }}</p>
                        <p class="font-mono text-sm leading-3 mt-2 text-gray-500">{{ __('Marks') }}</p>
                    </div>
                </div>
            </div>
            <div class="w-full flex items-center justify-between mt-4">
                <div class="flex items-center py-2">
                    <div class="w-2 h-2 bg-yellow-600 rounded-full"></div>
                    <p class="font-mono text-sm leading-3 text-yellow-600 ltr:ml-1 rtl:mr-1">{{ exam.type }}</p>
                </div>
                <slot name="action"></slot>
            </div>
        </div>
    </div>
</template>
<script>
    export default {
        name: 'ExamCard',
        props: {
            exam: Object
        }
    }
</script>
