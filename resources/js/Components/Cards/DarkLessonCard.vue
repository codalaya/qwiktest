<template>
    <div class="w-full overflow-hidden dark_question_card rounded cursor-pointer mb-1">
        <div :class="[active ? 'bg-gray-900 text-gray-200': 'text-gray-400']" class="hover:bg-gray-900 hover:text-gray-200 rounded p-4">
            <div class="flex items-start gap-4">
                <div class="w-8 h-8 rounded-sm bg-gray-700 text-sm flex justify-center items-center">{{ sno }}</div>
                <div class="flex flex-col">
                    <div class="leading-tight text-sm mb-1">{{ lesson.title }}</div>
                    <p class="inline-flex text-xs leading-5 font-semibold items-center">
                        <svg class="w-3 h-3 ltr:mr-1 rtl:ml-1" xmlns="http://www.w3.org/2000/svg" enable-background="new 0 0 24 24" viewBox="0 0 24 24" fill="currentColor"><g><rect fill="none" height="24" width="24"/></g><g><g><g><path d="M15,1H9v2h6V1z M11,14h2V8h-2V14z M19.03,7.39l1.42-1.42c-0.43-0.51-0.9-0.99-1.41-1.41l-1.42,1.42 C16.07,4.74,14.12,4,12,4c-4.97,0-9,4.03-9,9s4.02,9,9,9s9-4.03,9-9C21,10.88,20.26,8.93,19.03,7.39z M12,20c-3.87,0-7-3.13-7-7 s3.13-7,7-7s7,3.13,7,7S15.87,20,12,20z"/></g></g></g></svg>
                        <span>{{ lesson.read_time }} {{ __('Min Read') }}</span>
                    </p>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    export default {
        name: 'DarkLessonCard',
        props: {
            lesson: Object,
            sno: Number,
            active: Boolean,
        },
        created() {
            this.$nextTick(function() {
                window.renderMathInElement(this.$el);
            });
        }
    }
</script>
