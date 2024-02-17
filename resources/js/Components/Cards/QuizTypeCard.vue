<template>
    <div class="bg-white group cursor-pointer shadow-md rounded-md overflow-hidden mx-1">
        <div :style="{'background': getGradient(quizType.color)}" class="relative rounded-md flex flex-col justify-center p-4">
            <inertia-link class="absolute inset-0 quiz-type-card" :href="route('quizzes_by_type', { type: quizType.slug })"></inertia-link>
            <div :style="{'background-color': quizType.color}" class="w-16 h-16 rounded-md p-2 mb-4">
                <img :src="quizType.image" alt="thumb">
            </div>
            <h5 class="text-base md:text-lg font-bold leading-tight text-white">{{ quizType.name }}</h5>
            <div class="absolute top-4 ltr:right-3 rtl:left-3 rtl:flip text-white opacity-50 group-hover:opacity-70">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 9l3 3m0 0l-3 3m3-3H8m13 0a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
            </div>
        </div>
    </div>
</template>
<script>
    export default {
        name: "QuizTypeCard",
        props: {
            quizType: Object
        },
        methods: {
            getGradient(hex) {
                return 'linear-gradient(180deg, '+this.hex2rgba(hex, 0.8)+' 0%, '+this.hex2rgba(hex)+' 100%)';
            },
        },
    }
</script>
