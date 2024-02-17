<template>
    <div class="bg-white shadow px-4 py-5 border-b-4 border-gray-800 mb-6">
        <h5 class="inline-block bg-green-100 rounded-sm px-2 py-1 mb-4 text-xs leading-3 text-green-700">{{ video.skill }}</h5>
        <div class="q-data mb-4">
            <h4 class="text-base font-semibold mb-2">{{ video.title }}</h4>
        </div>
        <ul class="mt-5">
            <li class="text-gray-600 flex items-center text-sm mb-4">
                <span class="font-semibold">{{ __('Watch Time') }}:</span>
                <span class="ltr:ml-2 rtl:mr-2">{{ video.duration }} Minutes</span>
            </li>
            <li class="text-gray-600 flex items-center text-sm mb-4">
                <span class="font-semibold">{{ __('Difficulty Level') }}:</span>
                <span class="ltr:ml-2 rtl:mr-2">{{ video.difficulty }}</span>
            </li>
        </ul>
        <div class="mt-4 flex justify-between items-center">
            <h5 class="inline-block bg-gray-100 rounded-sm px-2 py-1 text-xs leading-3 text-gray-700">{{ video.code }}</h5>
            <slot name="action"></slot>
        </div>
    </div>
</template>
<script>
    export default {
        name: "AdminPracticeVideoCard",
        props: {
            video: Object,
        },
    }
</script>
