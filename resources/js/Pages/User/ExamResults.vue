<template>
    <app-layout>
        <template #header>
            <div class="flex items-center">
                <back-button />
                <h1 class="app-heading">{{ exam.title }} {{ __('Results') }}</h1>
            </div>
        </template>
        <template #actions>
            <a :href="route('download_exam_report', {exam: exam.slug, session: session.code})" target="_blank" class="qt-btn qt-btn-sm qt-btn-success">
                {{ __('Download Score Report') }}
            </a>
        </template>

        <div class="w-full mt-8">
            <progress-navigator :steps="steps"></progress-navigator>
        </div>

        <div class="py-8">
            <div class="grid sm:grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
                <div class="bg-white dark:bg-gray-800 rounded flex items-center justify-between px-6 py-4 relative shadow">
                    <div class="absolute w-2 h-4 bg-green-700 ltr:left-0 rtl:right-0"></div>
                    <h3 class="focus:outline-none py-6 leading-4 text-gray-800 dark:text-gray-100 font-normal text-base">{{ __(session.results.pass_or_fail) }}</h3>
                    <div class="flex flex-col items-end">
                        <h2 class="focus:outline-none text-green-700 dark:text-gray-100 text-xl leading-normal font-bold">{{ session.results.percentage < 0 ? 0 : session.results.percentage }}%</h2>
                        <p tabindex="0" class="focus:outline-none ltr:ml-2 rtl:mr-2 mb-1 text-sm text-gray-600 dark:text-gray-400">{{ __('Min.') }} {{ session.results.cutoff }}%</p>
                    </div>
                </div>
                <div class="bg-white dark:bg-gray-800 rounded flex items-center justify-between px-6 py-4 relative shadow">
                    <div class="absolute w-2 h-4 bg-green-700 ltr:left-0 rtl:right-0"></div>
                    <h3 class="focus:outline-none py-6 leading-4 text-gray-800 dark:text-gray-100 font-normal text-base">{{ __('Score') }}</h3>
                    <div class="flex flex-col items-end">
                        <h2 class="focus:outline-none text-green-700 dark:text-gray-100 text-xl leading-normal font-bold">{{ session.results.score < 0 ? 0 : session.results.score }}</h2>
                        <p tabindex="0" class="focus:outline-none ltr:ml-2 rtl:mr-2 mb-1 text-sm text-gray-600 dark:text-gray-400">{{ __('Marks') }} {{ session.results.total_marks }}</p>
                    </div>
                </div>
                <div class="bg-white dark:bg-gray-800 rounded flex items-center justify-between px-6 py-4 relative shadow">
                    <div class="absolute w-2 h-4 bg-green-700 ltr:left-0 rtl:right-0"></div>
                    <h3 class="focus:outline-none py-6 leading-4 text-gray-800 dark:text-gray-100 font-normal text-base">{{ __('Accuracy') }}</h3>
                    <div class="flex flex-col items-end">
                        <h2 class="focus:outline-none text-green-700 dark:text-gray-100 text-xl leading-normal font-bold">{{ session.results.accuracy }}%</h2>
                        <p tabindex="0" class="focus:outline-none ltr:ml-2 rtl:mr-2 mb-1 text-sm text-gray-600 dark:text-gray-400"></p>
                    </div>
                </div>
                <div class="bg-white dark:bg-gray-800 rounded flex items-center justify-between px-6 py-4 relative shadow">
                    <div class="absolute w-2 h-4 bg-green-700 ltr:left-0 rtl:right-0"></div>
                    <h3 class="focus:outline-none py-6 leading-4 text-gray-800 dark:text-gray-100 font-normal text-base">{{ __('Speed') }}</h3>
                    <div class="flex flex-col items-end">
                        <h2 class="focus:outline-none text-green-700 dark:text-gray-100 text-xl leading-normal font-bold">{{ session.results.speed }}</h2>
                        <p tabindex="0" class="focus:outline-none ltr:ml-2 rtl:mr-2 mb-1 text-sm text-gray-600 dark:text-gray-400">Que/Hour</p>
                    </div>
                </div>
            </div>
            <div class="grid sm:grid-cols-1 md:grid-cols-3 gap-4 py-8">
                <div class="bg-white dark:bg-gray-800 rounded flex flex-col items-center justify-center p-5 relative shadow">
                    <h2 class="focus:outline-none text-gray-800 text-base leading-normal font-semibold mb-6">
                        {{ __('Total') }} {{ session.results.total_questions }} {{ __('Questions') }}
                    </h2>
                    <div class="flex gap-4 sm:justify-center items-center">
                        <div class="w-28">
                            <doughnut-chart id="status" :key="'status'" :chart-data="statusChartData" :element-text="totalAnswered"/>
                        </div>
                        <div class="flex flex-col gap-2 justify-center">
                            <div class="flex gap-2 items-center text-xs">
                                <svg class="w-5 h-5 text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                                {{ session.results.correct_answered_questions }} {{ __('Correct') }}
                            </div>
                            <div class="flex gap-2 items-center text-xs">
                                <svg class="w-5 h-5 text-red-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                                {{ session.results.wrong_answered_questions }} {{ __('Wrong') }}
                            </div>
                            <div class="flex gap-2 items-center text-xs">
                                <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                                {{ session.results.unanswered_questions }} {{ __('Unanswered') }}
                            </div>
                        </div>
                    </div>
                </div>
                <div class="bg-white dark:bg-gray-800 rounded flex flex-col items-center justify-center p-5 relative shadow">
                    <h2 class="focus:outline-none text-gray-800 text-base leading-normal font-semibold mb-6">
                        {{ __('Total') }} {{ session.results.total_duration }} {{ __('Minutes') }}
                    </h2>
                    <div class="flex gap-4 sm:justify-center items-center">
                        <div class="w-28">
                            <doughnut-chart id="time_spent" :key="'time_spent'" :chart-data="timeSpentChartData" :element-text="totalTimeSpent"/>
                        </div>
                        <div class="flex flex-col gap-2 justify-center">
                            <div class="flex gap-2 items-center text-xs">
                                <svg class="w-5 h-5 text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                                {{ session.results.time_taken_for_correct_answered.detailed_readable }} {{ __('Correct') }}
                            </div>
                            <div class="flex gap-2 items-center text-xs">
                                <svg class="w-5 h-5 text-red-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                                {{ session.results.time_taken_for_wrong_answered.detailed_readable }} {{ __('Wrong') }}
                            </div>
                            <div class="flex gap-2 items-center text-xs">
                                <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                                {{ session.results.time_taken_for_other.detailed_readable }} {{ __('Other') }}
                            </div>
                        </div>
                    </div>
                </div>
                <div class="bg-white dark:bg-gray-800 rounded flex flex-col items-center justify-center p-5 relative shadow">
                    <h2 class="focus:outline-none text-gray-800 text-base leading-normal font-semibold mb-6">
                        {{ __('Total Scored Marks') }}
                    </h2>
                    <div class="w-full flex gap-4 sm:justify-center items-center">
                        <table class="w-full table-auto">
                            <tbody>
                            <tr>
                                <td class="border border-emerald-500 px-4 py-2 text-emerald-600 text-sm">{{ __('Marks Earned') }}</td>
                                <td class="border border-emerald-500 px-4 py-2 text-emerald-600 font-medium text-sm text-right">{{ session.results.marks_earned }}</td>
                            </tr>
                            <tr class="bg-emerald-200">
                                <td class="border border-emerald-500 px-4 py-2 text-emerald-600 text-sm">{{ __('Negative Marks') }}</td>
                                <td class="border border-emerald-500 px-4 py-2 text-emerald-600 font-medium text-sm text-right">-{{ session.results.marks_deducted }}</td>
                            </tr>
                            <tr>
                                <td class="border border-emerald-500 px-4 py-2 text-emerald-600 text-sm">{{ __('Total Marks') }}</td>
                                <td class="border border-emerald-500 px-4 py-2 text-emerald-600 font-medium text-sm text-right">{{ session.results.score }}</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div>
                <h2 class="text-lg font-semibold leading-tight text-gray-800 mb-6">{{ __('Sectional Summary') }}</h2>
                <div class="w-full bg-white dark:bg-gray-800 rounded shadow overflow-scroll">
                    <table class="w-full table-auto">
                        <tr>
                            <th class="border ltr:text-left rtl:text-right text-sm px-8 py-4">{{ __('#') }}</th>
                            <th class="border ltr:text-left rtl:text-right text-sm px-8 py-4">{{ __('Name') }}</th>
                            <th class="border ltr:text-left rtl:text-right text-sm px-8 py-4">{{ __('Score') }}</th>
                            <th class="border ltr:text-left rtl:text-right text-sm px-8 py-4">{{ __('Attempted') }}</th>
                            <th class="border ltr:text-left rtl:text-right text-sm px-8 py-4">{{ __('Accuracy') }}</th>
                            <th class="border ltr:text-left rtl:text-right text-sm px-8 py-4">{{ __('Time Spent') }}</th>
                        </tr>
                        <tr v-for="section in sections" :key="'section_'+section.sno">
                            <td class="border px-8 py-2">
                                <span class="text-sm">{{ section.sno }}</span>
                            </td>
                            <td class="border px-8 py-2">
                                <span class="text-sm">{{ section.name }}</span>
                            </td>
                            <td class="border px-8 py-2">
                                <span class="text-sm">{{ section.results.score }}/{{ section.results.total_marks }}</span>
                            </td>
                            <td class="border px-8 py-2">
                                <span class="text-sm">{{ section.results.answered_questions }}/{{ section.results.total_questions }}</span>
                            </td>
                            <td class="border px-8 py-2">
                                <span class="text-sm">{{ section.results.accuracy }}%</span>
                            </td>
                            <td class="border px-8 py-2">
                                <span class="text-sm">{{ section.results.total_time_taken.detailed_readable }}</span>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    import DoughnutChart from "@/Charts/DoughnutChart";
    import RewardsBadge from "@/Components/RewardsBadge";
    import BackButton from "@/Components/BackButton";
    import ProgressNavigator from "@/Components/Stepper/ProgressNavigator";

    export default {
        components: {
            AppLayout,
            DoughnutChart,
            RewardsBadge,
            BackButton,
            ProgressNavigator
        },
        props: {
            exam: Object,
            session: Object,
            steps: Array,
            sections: Array,
        },
        data() {
            return {
                loading: false,
                current_section: null,
                statusChartData: {
                    labels: ['Correct', 'Wrong', 'Unanswered'],
                    datasets: [{
                        label: 'Status',
                        data: [
                            this.session.results.correct_answered_questions,
                            this.session.results.wrong_answered_questions,
                            this.session.results.unanswered_questions
                        ],
                        backgroundColor: [
                            'rgb(52, 211, 153)',
                            'rgb(248, 113, 113)',
                            'rgb(156, 163, 175)'
                        ],
                        hoverOffset: 4
                    }]
                },
                timeSpentChartData: {
                    labels: ['Correct', 'Wrong', 'Other'],
                    datasets: [{
                        label: 'Time Spent',
                        data: [
                            this.session.results.time_taken_for_correct_answered.seconds,
                            this.session.results.time_taken_for_wrong_answered.seconds,
                            this.session.results.time_taken_for_other.seconds],
                        backgroundColor: [
                            'rgb(52, 211, 153)',
                            'rgb(248, 113, 113)',
                            'rgb(156, 163, 175)'
                        ],
                        hoverOffset: 4
                    }]
                },
            }
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        methods: {
            jumpToSection(sectionId) {
                this.current_section = sectionId;
            },
        },
        computed: {
            title() {
                return this.exam.title + ' '+this.__('Results')+' - ' + this.$page.props.general.app_name;
            },
            totalAnswered() {
                return this.session.results.answered_questions+'/'+this.session.results.total_questions+' '+this.__('Answered');
            },
            totalTimeSpent() {
                return this.session.results.total_time_taken.detailed_readable +' '+this.__('Spent');
            }
        }
    }
</script>
