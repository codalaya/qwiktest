<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">{{ quiz.title }} - {{ schedule !== null ? __('Schedule') : '' }} {{ __('Overall Report') }}</h4>
            <div v-if="schedule !== null" class="text-xs">{{ __('Schedule') }} ID: {{ schedule.code }}</div>
        </template>
        <template #actions>
            <inertia-link v-if="schedule !== null" :href="route('quizzes.detailed_report', { quiz: quiz.id, schedule: schedule.id })" class="qt-btn qt-btn-success">
                {{ __('Detailed Report') }}
            </inertia-link>
            <inertia-link v-else :href="route('quizzes.detailed_report', { quiz: quiz.id })" class="qt-btn qt-btn-success">
                {{ __('Detailed Report') }}
            </inertia-link>
        </template>

        <div class="py-8">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="bg-white shadow rounded-lg w-full overflow-hidden">
                    <div class="grid sm:grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
                        <admin-test-stat-card :title="__('Total Attempts')" :count="stats.total_attempts"></admin-test-stat-card>
                        <admin-test-stat-card :title="__('Pass Attempts')" :count="stats.pass_count"></admin-test-stat-card>
                        <admin-test-stat-card :title="__('Fail Attempts')" :count="stats.failed_count"></admin-test-stat-card>
                        <admin-test-stat-card :title="__('Unique Test Takers')" :count="stats.unique_test_takers"></admin-test-stat-card>
                        <admin-test-stat-card :title="__('Avg. Time Spent')" :count="stats.avg_time.detailed_readable"></admin-test-stat-card>
                        <admin-test-stat-card :title="__('Avg. Score')" :count="stats.avg_score"></admin-test-stat-card>
                        <admin-test-stat-card :title="__('High Score')" :count="stats.high_score"></admin-test-stat-card>
                        <admin-test-stat-card :title="__('Low Score')" :count="stats.low_score"></admin-test-stat-card>
                        <admin-test-stat-card :title="__('Avg. Percentage')" :count="stats.avg_percentage"></admin-test-stat-card>
                        <admin-test-stat-card :title="__('Avg. Accuracy')" :count="stats.avg_accuracy"></admin-test-stat-card>
                        <admin-test-stat-card :title="__('Avg. Speed')" :count="stats.avg_speed"></admin-test-stat-card>
                        <admin-test-stat-card :title="__('Avg. Questions Answered')" :count="stats.avg_questions_answered"></admin-test-stat-card>
                    </div>
                </div>
            </div>
        </div>
    </admin-layout>
</template>

<script>
    import AdminLayout from '@/Layouts/AdminLayout'
    import AdminTestStatCard from "@/Components/Cards/AdminTestStatCard";
    export default {
        components: {
            AdminLayout,
            AdminTestStatCard,
        },
        props: {
            quiz: Object,
            stats: Object,
            schedule: Object
        },
        data() {
            return {
                loading: false,
            }
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        computed: {
            title() {
                return this.quiz.title + ' '+this.__('Overall Report')+' - ' + this.$page.props.general.app_name;
            },
        }
    }
</script>
