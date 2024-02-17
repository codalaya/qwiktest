<template>
    <div class="m-2 group rounded-md overflow-hidden shadow-md border-gray-800 bg-white">
        <div class="w-full h-44 relative flex justify-center items-center text-gray-100">
            <img class="w-full h-full" :src="video.thumbnail" alt="Thumbnail" />
            <div v-if="!subscription" class="absolute top-2 ltr:right-2 rtl:left-2 flex-shrink-0 flex">
                <p :class="[video.paid ? 'bg-gray-100 text-gray-800': 'bg-green-100 text-green-800']" class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full items-center">
                    <svg v-if="video.paid" class="w-3 h-3 ltr:mr-1 rtl:ml-1" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 11V7a4 4 0 118 0m-4 8v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2z"></path></svg>
                    <span>{{ video.paid ? __('Unlock') : __('Free') }}</span>
                </p>
            </div>
            <div class="absolute opacity-50 group-hover:opacity-100">
                <svg class="w-10 h-10" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M0 0h24v24H0V0z" fill="none"/><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 14.5v-9l6 4.5-6 4.5z"/></svg>
            </div>
        </div>
        <div class="desc flex flex-col items-start p-4 text-gray-800">
            <p class="title font-semibold block">{{ video.title }}</p>
            <div class="flex-shrink-0 flex mt-2">
                <p class="px-2 bg-gray-100 text-gray-600 inline-flex text-xs leading-5 font-semibold rounded-sm items-center">
                    <svg class="w-3 h-3 ltr:mr-1 rtl:ml-1" xmlns="http://www.w3.org/2000/svg" enable-background="new 0 0 24 24" viewBox="0 0 24 24" fill="currentColor"><g><rect fill="none" height="24" width="24"/></g><g><g><g><path d="M15,1H9v2h6V1z M11,14h2V8h-2V14z M19.03,7.39l1.42-1.42c-0.43-0.51-0.9-0.99-1.41-1.41l-1.42,1.42 C16.07,4.74,14.12,4,12,4c-4.97,0-9,4.03-9,9s4.02,9,9,9s9-4.03,9-9C21,10.88,20.26,8.93,19.03,7.39z M12,20c-3.87,0-7-3.13-7-7 s3.13-7,7-7s7,3.13,7,7S15.87,20,12,20z"/></g></g></g></svg>
                    <span>{{ video.watch_time }} {{ __('Min') }}</span>
                </p>
            </div>
        </div>
    </div>
</template>
<script>
    export default {
        name: 'PracticeVideoCard',
        props: {
            video: Object,
            sno: Number|String,
            subscription: {
                type: Boolean,
                default: false,
            }
        }
    }
</script>
