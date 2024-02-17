<template>
    <app-layout>
        <template #header>
            <h1 class="app-heading">{{ __('My Progress') }}</h1>
        </template>
        <div class="w-full my-6">
            <progress-navigator :steps="steps"></progress-navigator>
        </div>
        <div class="flex flex-col items-center">
            <div class="w-full">
                <div v-if="quizSessions.length > 0" class="grid grid-cols-1 sm:grid-cols-2 gap-4 mb-6">
                    <template v-for="(quizSession, index) in quizSessions">
                        <quiz-session-card :quiz-session="quizSession" :key="quizSession.code">
                            <template #action>
                                <inertia-link v-if="quizSession.quizSchedule === null" :href="route('init_quiz', {slug: quizSession.slug})">
                                    <span class="qt-btn qt-btn-sm qt-btn-success">{{ __('Resume Quiz') }}</span>
                                </inertia-link>
                                <inertia-link v-else :href="route('init_quiz_schedule', {quiz: quizSession.slug, schedule: quizSession.quizSchedule})">
                                    <span class="qt-btn qt-btn-sm qt-btn-success">{{ __('Resume Quiz') }}</span>
                                </inertia-link>
                            </template>
                        </quiz-session-card>
                    </template>
                </div>
                <div class="mb-6" v-else>
                    <empty-student-card :title="__('No Sessions Found')">
                    </empty-student-card>
                </div>
            </div>
        </div>
    </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    import NoDataTable from "@/Components/NoDataTable";
    import ProgressNavigator from "@/Components/Stepper/ProgressNavigator";
    import QuizSessionCard from "@/Components/Cards/QuizSessionCard";
    import EmptyStudentCard from "@/Components/Cards/EmptyStudentCard";

    export default {
        components: {
            AppLayout,
            NoDataTable,
            ProgressNavigator,
            QuizSessionCard,
            EmptyStudentCard
        },
        props: {
            quizSessions: Array,
            steps: Array
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        computed: {
            title() {
                return this.__('My Progress')+' - ' + this.$page.props.general.app_name;
            }
        },
    }
</script>
