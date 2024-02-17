<template>
    <app-layout>
        <template #header>
            <div class="flex items-center">
                <back-button />
                <h1 class="app-heading">{{ quiz.title }} {{ __('Solutions') }}</h1>
            </div>
        </template>

        <div class="w-full mt-8">
            <progress-navigator :steps="steps"></progress-navigator>
        </div>

        <div class="py-8">
            <div v-if="quiz.settings.hide_solutions" class="mb-6" v-else>
                <empty-student-card :title="__('No Solutions Found or Solutions Hidden')"></empty-student-card>
            </div>
            <div v-else>
                <div class="w-full card">
                    <div class="w-full card-body lg:flex flex-wrap">
                        <div class="py-4 lg:w-1/3 w-full md:ltr:pr-6 md:rtl:pl-6">
                            <ul v-if="loading">
                                <li>
                                    <NavigationQuestionCardShimmer></NavigationQuestionCardShimmer>
                                </li>
                                <li>
                                    <NavigationQuestionCardShimmer></NavigationQuestionCardShimmer>
                                </li>
                                <li>
                                    <NavigationQuestionCardShimmer></NavigationQuestionCardShimmer>
                                </li>
                                <li>
                                    <NavigationQuestionCardShimmer></NavigationQuestionCardShimmer>
                                </li>
                            </ul>
                            <ul v-else class="my-6 flex flex-wrap justify-center items-center gap-2">
                                <li v-for="(question, index) in questions" :key="question.code" @click="jumpToQuestion(index)">
                                    <exam-result-question-chip :sno="index+1"
                                                            :is_correct="question.is_correct" :status="question.status"
                                                            :active="current_question === index"></exam-result-question-chip>
                                </li>
                            </ul>
                        </div>
                        <div class="py-4 lg:w-2/3 w-full md:ltr:pl-6 md:rtl:pr-6 sm:ltr:border-l sm:rtl:border-r border-gray-200">
                            <div class="w-full sm:w-2/3" v-if="loading">
                                <div class="card card-body">
                                    <PracticeQuestionShimmer class="w-full"></PracticeQuestionShimmer>
                                </div>
                            </div>
                            <div v-else>
                                <div v-for="(question, index) in questions" :key="question.id">
                                    <div :id="question.code" v-show="current_question === index">
                                        <div class="flex justify-between items-center mb-6">
                                            <div class="font-mono px-2 py-1 inline-block bg-qt-option text-white rounded text-sm mb-2">
                                                {{ __('Time Spent') }}: {{ question.time_taken.detailed_readable }}
                                            </div>
                                            <div v-if="question.status === 'answered' || question.status === 'answered_mark_for_review'" :class="question.is_correct ? 'bg-green-400' : 'bg-red-400'"
                                                 class="font-mono px-2 py-1 inline-block text-white rounded text-sm mb-2">
                                                <span v-if="question.is_correct">+{{ question.marks_earned }} {{ __('Marks Earned') }}</span>
                                                <span v-if="!question.is_correct">-{{ question.marks_deducted }} {{ __('Marks Deducted') }}</span>
                                            </div>
                                            <div v-else class="font-mono px-2 py-1 inline-block bg-gray-100 text-gray-600 rounded text-sm mb-2">
                                                {{ __('Not Answered') }}
                                            </div>
                                        </div>
                                        <practice-question-card :key="question.card" :question="question"
                                                                :sno="index+1"
                                                                :total-questions="quiz.total_questions"></practice-question-card>
                                        <div class="mt-4"
                                             v-if="question.questionType === 'MSA' || question.questionType === 'TOF'">
                                            <MSASolution :key="question.code" :parent-qid="question.code"
                                                         :is-correct="question.is_correct"
                                                         :status="question.status"
                                                         :parent-options="question.options"
                                                         :parent-answer="question.user_answer"
                                                         :correct-answer="question.ca">
                                            </MSASolution>
                                        </div>
                                        <div class="mt-4"
                                             v-if="question.questionType === 'MMA'">
                                            <MMASolution :key="question.code" :parent-qid="question.code"
                                                         :is-correct="question.is_correct"
                                                         :status="question.status"
                                                         :parent-options="question.options"
                                                         :parent-answer="question.user_answer"
                                                         :correct-answer="question.ca">
                                            </MMASolution>
                                        </div>
                                        <div class="mt-4" v-if="question.questionType === 'MTF'">
                                            <MTFSolution :key="question.code" :parentQid="question.code"
                                                         :is-correct="question.is_correct"
                                                         :status="question.status"
                                                         :parent-options="question.options"
                                                         :parent-answer="question.user_answer"
                                                         :correct-answer="question.ca">
                                            </MTFSolution>
                                        </div>
                                        <div class="mt-4" v-if="question.questionType === 'ORD'">
                                            <ORDSolution :key="question.code" :parentQid="question.code"
                                                         :is-correct="question.is_correct"
                                                         :status="question.status"
                                                         :parent-options="question.options"
                                                         :parent-answer="question.user_answer"
                                                         :correct-answer="question.ca">
                                            </ORDSolution>
                                        </div>
                                        <div class="mt-4" v-if="question.questionType === 'FIB'">
                                            <FIBSolution :key="question.code" :parentQid="question.code"
                                                         :is-correct="question.is_correct"
                                                         :status="question.status"
                                                         :parent-options="question.options"
                                                         :parent-answer="question.user_answer"
                                                         :correct-answer="question.ca">
                                            </FIBSolution>
                                        </div>
                                        <div class="mt-4" v-if="question.questionType === 'SAQ'">
                                            <SAQSolution :key="question.code" :parentQid="question.code"
                                                         :is-correct="question.is_correct"
                                                         :status="question.status"
                                                         :parent-options="question.options"
                                                         :parent-answer="question.user_answer"
                                                         :correct-answer="question.ca">
                                            </SAQSolution>
                                        </div>
                                        <div class="mt-4">
                                            <practice-solution-card :question="question"></practice-solution-card>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    import RewardsBadge from "@/Components/RewardsBadge";
    import MSASolution from "@/Components/Questions/Solutions/MSASolution";
    import PracticeQuestionCard from "@/Components/Cards/PracticeQuestionCard";
    import ExamResultQuestionChip from "@/Components/Cards/ExamResultQuestionChip";
    import NavigationQuestionCardShimmer from "@/Components/Shimmers/NavigationQuestionCardShimmer";
    import PracticeQuestionShimmer from "@/Components/Shimmers/PracticeQuestionShimmer";
    import PracticeSolutionCard from "@/Components/Cards/PracticeSolutionCard";
    import MMASolution from "@/Components/Questions/Solutions/MMASolution";
    import MTFSolution from "@/Components/Questions/Solutions/MTFSolution";
    import ORDSolution from "@/Components/Questions/Solutions/ORDSolution";
    import FIBSolution from "@/Components/Questions/Solutions/FIBSolution";
    import SAQSolution from "@/Components/Questions/Solutions/SAQSolution";
    import BackButton from "@/Components/BackButton";
    import ProgressNavigator from "@/Components/Stepper/ProgressNavigator";
    import EmptyStudentCard from "@/Components/Cards/EmptyStudentCard";

    export default {
        components: {
            SAQSolution,
            FIBSolution,
            ORDSolution,
            MTFSolution,
            MSASolution,
            MMASolution,
            AppLayout,
            RewardsBadge,
            PracticeQuestionCard,
            ExamResultQuestionChip,
            NavigationQuestionCardShimmer,
            PracticeQuestionShimmer,
            PracticeSolutionCard,
            BackButton,
            ProgressNavigator,
            EmptyStudentCard
        },
        props: {
            quiz: Object,
            session: Object,
            steps: Array
        },
        data() {
            return {
                loading: false,
                questions: [],
                current_question: 0,
            }
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        methods: {
            jumpToQuestion(questionID) {
                this.current_question = questionID;
            },
            fetchQuestions() {
                let _this = this;
                _this.loading = true;
                axios.get(route('fetch_quiz_solutions', {
                    quiz: this.quiz.slug,
                    session: this.session.code
                }))
                    .then(function (response) {
                        let data = response.data;
                        _this.questions = data.questions;
                    })
                    .catch(function (error) {
                        _this.loading = false;
                    })
                    .then(function () {
                        _this.loading = false;
                    });
            },
        },
        computed: {
            title() {
                return this.quiz.title + ' '+this.__('Solutions')+' - ' + this.$page.props.general.app_name;
            },
        },
        mounted() {
            if(!this.quiz.settings.hide_solutions) {
                this.fetchQuestions();
            }
        }
    }
</script>
