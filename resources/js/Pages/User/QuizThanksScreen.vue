<template>
    <app-layout>
        <template #header>
            <h1 class="app-heading">{{ quiz.title }}</h1>
        </template>

        <div class="py-8">
            <div class="flex flex-col items-center">
                <div class="w-full">
                    <div class="w-full rounded shadow-lg p-8 bg-gradient-to-tl from-green-600 to-green-700">
                        <h1 class="text-2xl font-semibold leading-relaxed text-white">{{ __('quiz_thanks') }} {{ quiz.title
                        }}</h1>
                        <div class="flex flex-col sm:flex-row mt-7 gap-4">
                            <div>
                                <p class="focus:outline-none text-sm text-gray-300">{{ __('Answered') }}</p>
                                <p
                                    class="focus:outline-none mt-2 text-base sm:text-lg md:text-xl 2xl:text-2xl text-gray-50">
                                    {{ session.results.answered_questions }}/{{ session.results.total_questions }}
                                </p>
                            </div>
                            <div class="sm:ml-11">
                                <p class="focus:outline-none text-sm text-gray-300">{{ __('Percentage') }}</p>
                                <p
                                    class="focus:outline-none mt-2 text-base sm:text-lg md:text-xl 2xl:text-2xl text-gray-50">
                                    {{ session.results.percentage < 0 ? 0 : session.results.percentage }}% </p>
                            </div>
                            <div class="sm:ml-11">
                                <p class="focus:outline-none text-sm text-gray-300">{{ __('Score') }}</p>
                                <p
                                    class="focus:outline-none mt-2 text-base sm:text-lg md:text-xl 2xl:text-2xl text-gray-50">
                                    {{ session.results.score < 0 ? 0 : session.results.score }}/{{ quiz.total_marks }} </p>
                            </div>
                            <div class="sm:ml-11">
                                <p class="focus:outline-none text-sm text-gray-300">{{ __('Rank') }}</p>
                                <p
                                    class="focus:outline-none mt-2 text-base sm:text-lg md:text-xl 2xl:text-2xl text-gray-50">
                                    {{ rank }}</p>
                            </div>
                        </div>
                        <div class="pt-7 flex items-center justify-between">
                            <p class="focus:outline-none text-sm text-white">{{ __('Pass Percentage') }} {{
                                session.results.cutoff }}%</p>
                            <inertia-link :href="route('quiz_results', { quiz: quiz.slug, session: session.code })"
                                class="h-9 flex items-center text-green-700 rounded-sm bg-gray-50 focus:outline-none hover:opacity-90 px-4 py-2 text-sm font-medium leading-3">
                                {{ __('View Results') }}
                            </inertia-link>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </app-layout>
</template>

<script>
import AppLayout from '@/Layouts/AppLayout'
import QuizCard from "@/Components/Cards/QuizCard";

export default {
    components: {
        AppLayout,
        QuizCard
    },
    props: {
        quiz: Object,
        session: Object,
        rank: Number,
    },
    metaInfo() {
        return {
            title: this.title
        }
    },
    computed: {
        title() {
            return this.quiz.title + ' ' + this.__('Thank You') + ' - ' + this.$page.props.general.app_name;
        }
    },
}
</script>
