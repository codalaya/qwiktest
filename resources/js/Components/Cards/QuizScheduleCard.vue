<template>
    <div class="w-full card">
        <div class="relative card-body flex flex-col justify-between items-start">
            <h1 class="text-lg font-semibold text-gray-800 leading-5 pb-2">{{ quiz.title }}</h1>
            <div class="w-full flex flex-col sm:gap-4 items-center">
                <div v-if="quiz.scheduleType === 'Fixed'" class="w-full mt-4 p-4 rounded-sm bg-yellow-50 border border-yellow-100 flex flex-col gap-4">
                    <p class="text-sm uppercase font-mono font-medium leading-3 text-yellow-600">{{ __('Fixed Schedule Time') }}</p>
                    <div class="flex items-center text-gray-600">
                        <i class="pi pi-calendar text-green-500"></i>
                        <p class="text-sm font-mono leading-none text-gray-700 dark:text-gray-100 ltr:ml-2 rtl:mr-2">{{ quiz.starts_at }}</p>
                    </div>
                    <div class="flex items-center text-gray-600">
                        <i class="pi pi-clock text-red-500"></i>
                        <p class="text-sm font-mono leading-none text-gray-700 dark:text-gray-100 ltr:ml-2 rtl:mr-2">{{ quiz.ends_at }}</p>
                    </div>
                    <div class="flex items-center text-gray-600">
                        <i class="pi pi-globe text-green-500"></i>
                        <p class="text-sm font-mono leading-none text-gray-700 dark:text-gray-100 ltr:ml-2 rtl:mr-2">{{ __('Timezone') }} - {{ quiz.timezone }}</p>
                    </div>
                </div>
                <div v-else class="w-full mt-4 p-4 rounded-sm bg-yellow-50 border border-yellow-100 flex flex-col gap-4">
                    <p class="text-sm uppercase font-mono font-medium leading-3 text-yellow-600">{{ __('Quiz Available Between') }}</p>
                    <div class="flex items-center text-gray-600">
                        <i class="pi pi-calendar text-green-500"></i>
                        <p class="text-sm font-mono leading-none text-gray-700 dark:text-gray-100 ltr:ml-2 rtl:mr-2">{{ quiz.starts_at }}</p>
                    </div>
                    <div class="flex items-center text-gray-600">
                        <i class="pi pi-calendar text-red-500"></i>
                        <p class="text-sm font-mono leading-none text-gray-700 dark:text-gray-100 ltr:ml-2 rtl:mr-2">{{ quiz.ends_at }}</p>
                    </div>
                    <div class="flex items-center text-gray-600">
                        <i class="pi pi-globe text-green-500"></i>
                        <p class="text-sm font-mono leading-none text-gray-700 dark:text-gray-100 ltr:ml-2 rtl:mr-2">{{ __('Timezone') }} - {{ quiz.timezone }}</p>
                    </div>
                </div>
            </div>
            <div class="my-4">
                <div class="flex ltr:flex-row rtl:flex-row-reverse items-center">
                    <div>
                        <p class="text-lg font-semibold leading-tight text-green-600">{{ quiz.total_questions }}</p>
                        <p class="font-mono text-sm leading-3 mt-2 text-gray-500">{{ __('Questions') }}</p>
                    </div>
                    <div class="ml-11">
                        <p class="text-lg font-semibold leading-tight text-green-600">{{ quiz.total_duration }}</p>
                        <p class="font-mono text-sm leading-3 mt-2 text-gray-500">{{ __('Minutes') }}</p>
                    </div>
                    <div class="ml-11">
                        <p class="text-lg font-semibold leading-tight text-green-600">{{ quiz.total_marks }}</p>
                        <p class="font-mono text-sm leading-3 mt-2 text-gray-500">{{ __('Marks') }}</p>
                    </div>
                </div>
            </div>
            <div class="w-full flex items-center justify-between mt-4">
                <div class="flex items-center py-2">
                    <div class="w-2 h-2 bg-yellow-600 rounded-full"></div>
                    <p class="font-mono text-sm leading-3 text-yellow-600 ltr:ml-1 rtl:mr-1">{{ quiz.type }}</p>
                </div>
                <slot name="action"></slot>
            </div>
        </div>
    </div>
</template>
<script>
    export default {
        name: 'QuizScheduleCard',
        props: {
            quiz: Object,
        }
    }
</script>
