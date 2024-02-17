<template>
    <app-layout>
        <template #header>
            <h1 class="app-heading">{{ __('Dashboard') }}</h1>
        </template>

        <div class="py-6">
            <div class="w-full gap-4 md:gap-6 flex flex-col flex-col-reverse md:flex-row">
                <div class="w-full md:w-2/3">
                    <section-header :title="'Continue Practice'"></section-header>
                    <div v-if="practiceSessions.length > 0" class="grid grid-cols-1 mb-6">
                        <template v-for="(practiceSession, index) in practiceSessions">
                            <practice-session-card :practice-session="practiceSession" :key="practiceSession.code">
                                <template #action>
                                    <inertia-link :href="route('init_practice_set', {slug: practiceSession.slug})">
                                        <span class="qt-btn qt-btn-sm qt-btn-primary">{{ __('Resume Practice') }}</span>
                                    </inertia-link>
                                </template>
                            </practice-session-card>
                        </template>
                    </div>
                    <div class="mb-6" v-else>
                        <empty-student-card :title="__('No Practice Sessions Found')">
                            <template #action>
                                <inertia-link :href="route('learn_practice')">
                                    <span class="qt-btn qt-btn-sm qt-btn-primary">{{ __('Start Practice') }}</span>
                                </inertia-link>
                            </template>
                        </empty-student-card>
                    </div>
                </div>
                <div class="w-full md:w-1/3">
                    <section-header :title="'Test Schedules'"></section-header>
                    <div class="card">
                        <v-calendar class="border-0" :attributes="attrs" :rows="calendarRows" :min-date="minDate" :maxDate="maxDate" title-position="left" is-expanded>
                            <template #day-popover="{ day, dayTitle, attributes }">
                                <div>
                                    <div class="text-xs text-gray-300 font-semibold text-center">
                                        {{ dayTitle }}
                                    </div>
                                    <popover-row v-for="attr in attributes" :key="attr.key" :attribute="attr">
                                        <inertia-link v-if="attr.customData.entity === 'quiz'" :href="route('quiz_schedule_instructions', {quiz: attr.customData.slug, schedule: attr.customData.code})">
                                            <span class="hover:underline">{{ attr.customData.title }} ({{ attr.customData.type }})</span>
                                        </inertia-link>
                                        <inertia-link v-else :href="route('exam_schedule_instructions', {exam: attr.customData.slug, schedule: attr.customData.code})">
                                            <span class="hover:underline">{{ attr.customData.title }} ({{ attr.customData.type }})</span>
                                        </inertia-link>
                                    </popover-row>
                                </div>
                            </template>
                        </v-calendar>
                    </div>
                </div>
            </div>
        </div>
    </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    import SubCategoryCard from "@/Components/Cards/SubCategoryCard";
    import PracticeSessionCard from "@/Components/Cards/PracticeSessionCard";
    import QuizScheduleCard from "@/Components/Cards/QuizScheduleCard";
    import EmptyStudentCard from "@/Components/Cards/EmptyStudentCard";
    import SectionHeader from "@/Components/SectionHeader";
    import PopoverRow from 'v-calendar/lib/components/popover-row.umd.min'

    export default {
        components: {
            AppLayout,
            SubCategoryCard,
            PracticeSessionCard,
            QuizScheduleCard,
            EmptyStudentCard,
            SectionHeader,
            PopoverRow
        },
        props: {
            practiceSessions: Array,
            quizSchedules: Array,
            minDate: String,
            maxDate: String,
            scheduleCalendar: Array,
        },
        data() {
            return {
                attrs: this.scheduleCalendar,
            }
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        computed: {
            title() {
                return this.__('User Dashboard')+' - ' + this.$page.props.general.app_name;
            },
            calendarRows() {
                return this.$page.props.isMobile ? 1 : 2;
            }
        },
    }
</script>
<style scoped>
    .vc-container {
        border: 0 !important;
    }
</style>
