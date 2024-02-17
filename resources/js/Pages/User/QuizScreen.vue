<template>
    <quiz-layout>
        <!-- Title -->
        <template #title>
            <h4 class="font-semibold text-white">{{ quiz.title }}</h4>
        </template>

        <!-- Timer -->
        <template #timer>
            <span class="ltr:ml-2 rtl:mr-2 hidden">
                <vue-countdown :time="remainingTime * 1000" @end="finishTest" :transform="transformSlotProps"
                    v-slot="{ days, hours, minutes, seconds }">
                    {{ hours !== '00' ? hours + ':' : '' }}{{ minutes }}:{{ seconds }}
                </vue-countdown>
            </span>
            <span class="ltr:ml-2 rtl:mr-2">
                <vue-countdown :time="perQuestionRemainingTime * 1000" @end="goToNextQuestion"
                    @progress="setRemainingTimeForCurrentQuestion" :key="`question-${current_question}`"
                    :transform="transformSlotProps" v-slot="{ days, hours, minutes, seconds }">
                    {{ hours !== '00' ? hours + ':' : '' }}{{ minutes }}:{{ seconds }}
                </vue-countdown>
            </span>
        </template>

        <!-- Actions -->
        <template #actions>
            <div v-tooltip.bottom="touchedQuestions === 0 ? 'Progress Saved' : 'Some Responses Need to Save'"
                class="flex ltr:flex-row rtl:flex-row-reverse items-center">
                <div :class="[touchedQuestions === 0 ? 'bg-green-600' : 'bg-yellow-600']"
                    class="w-2 h-2 rounded-full ltr:mr-2 rtl:mr-2"></div>
                <h5 v-if="submitting" class="text-sm text-gray-800">{{ __('Saving Progress...') }}</h5>
                <h5 v-else class="text-sm text-gray-800">{{ answered }}/{{ quiz.total_questions }} {{ __('Answered') }}</h5>
            </div>
            <button v-if="quiz.settings.list_questions" class="text-gray-400 hover:text-gray-800 focus:outline-none"
                @click="chipView = !chipView">
                <svg v-if="!chipView" class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                        d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z">
                    </path>
                </svg>
                <svg v-if="chipView" class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                        d="M4 6h16M4 10h16M4 14h16M4 18h16"></path>
                </svg>
            </button>
        </template>

        <!-- Sections -->
        <template #sections>
            <button
                class="focus:outline-none flex items-center gap-2 text-white text-sm bg-green-800 hover:bg-green-600 rounded-sm py-2 px-4">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                        d="M8 11V7a4 4 0 118 0m-4 8v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2z">
                    </path>
                </svg>
                <span>{{ __('All Questions') }}</span>
            </button>
        </template>

        <!-- Questions -->
        <template #questions>
            <div>
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
                <ul v-else class="my-6" :class="{ 'flex flex-wrap justify-center items-center gap-2': chipView }">
                    <li v-for="(question, index) in questions" :key="question.code">
                        <light-question-card v-if="!chipView" :question="question" :sno="index + 1"
                            :is_correct="question.is_correct" :status="question.status"
                            :active="current_question === index"></light-question-card>
                        <exam-question-chip v-if="chipView" :sno="index + 1" :is_correct="question.is_correct"
                            :status="question.status" :active="current_question === index"></exam-question-chip>
                    </li>
                </ul>

            </div>
        </template>

        <!-- Statistics -->
        <template #stats>
            <div class="w-full h-auto">
                <div class="py-3 ps-0 text-xl">Current Rank: <span class="font-semibold text-red-500">{{ current_ranking
                }}</span></div>
                <div class="py-3 ps-0 text-xl">Current Score: <span class="font-semibold text-green-500">{{ current_score
                }}</span></div>
            </div>

            <div class="w-full h-56 grid grid-cols-2 bg-white py-4">
                <div class="flex items-center gap-2">
                    <question-chip :sno="answered" :status="'success'"></question-chip>
                    <span class="text-xs">{{ __('Answered') }}</span>
                </div>
                <div class="flex items-center gap-2">
                    <question-chip :sno="notAnsweredQuestions" :status="'danger'"></question-chip>
                    <span class="text-xs">{{ __('Not Answered') }}</span>
                </div>
                <div class="flex items-center gap-2">
                    <question-chip :sno="markForReviewQuestions" :status="'warning'"></question-chip>
                    <span class="text-xs">{{ __('Marked for Review') }}</span>
                </div>
                <div class="flex items-center gap-2">
                    <question-chip :sno="answeredMarkForReviewQuestions" :status="'caution'"></question-chip>
                    <span class="text-xs">{{ __('Answered & Marked for Review') }}</span>
                </div>
                <div class="flex items-center gap-2">
                    <question-chip :sno="notVisitedQuestions" :status="'default'"></question-chip>
                    <span class="text-xs">{{ __('Not Visited') }}</span>
                </div>
            </div>
        </template>

        <!-- Footer -->
        <template #footer>
            <div class="w-full h-16 flex items-center justify-center bg-white">
                <button v-if="!quiz.settings.disable_finish_button" @click="finishAlert" class="w-full focus:outline-none">
                    <finish-button :name="__('Finish Test')"></finish-button>
                </button>
            </div>
        </template>

        <!-- Question & Options -->
        <perfect-scrollbar class="h-screen max-h-screen pt-32 pb-16" ref="scroll2" :options="scrollbarOptions">
            <div class="mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex flex-col justify-center">
                    <div class="w-full mt-4 py-4 sm:w-2/3" v-if="loading">
                        <PracticeQuestionShimmer class="w-full"></PracticeQuestionShimmer>
                    </div>
                    <div v-else class="w-full mt-4 py-4">
                        <div class="w-full" v-for="(question, index) in questions" :key="question.id">
                            <div class="flex flex-col sm:flex-row gap-4" :id="question.code"
                                v-show="current_question === index">

                                <div v-if="question.attachment_type != null"
                                    class="w-full sm:w-1/3 sm:ltr:border-r sm:rtl:border-l sm:border-gray-300 ltr:pr-4 rtl:pl-4">
                                    <div v-if="question.attachment_type === 'audio'">
                                        <audio-attachment :reference="'player_' + question.code"
                                            :options="question.attachment"></audio-attachment>
                                    </div>
                                    <div v-if="question.attachment_type === 'video'">
                                        <video-attachment :reference="'player_' + question.code"
                                            :options="question.attachment"></video-attachment>
                                    </div>
                                    <div v-if="question.attachment_type === 'comprehension'">
                                        <comprehension-attachment :passage="question.attachment"></comprehension-attachment>
                                    </div>
                                </div>

                                <div class="w-full sm:w-2/3">
                                    <div>
                                        <quiz-question-card :key="question.card" :question="question" :sno="index + 1"
                                            :total-questions="quiz.total_questions"></quiz-question-card>
                                        <div class="mt-4"
                                            v-if="question.questionType === 'MSA' || question.questionType === 'TOF'">
                                            <MSAInteractiveOptions :key="question.code" :parent-qid="question.code"
                                                :status="question.status" :parent-options="question.options"
                                                :parent-answer="question.user_answer" v-on:modifyAnswer="updateAnswer">
                                            </MSAInteractiveOptions>
                                        </div>
                                        <div class="mt-4" v-if="question.questionType === 'MMA'">
                                            <MMAInteractiveOptions :key="question.code" :parent-qid="question.code"
                                                :status="question.status" :parent-options="question.options"
                                                :parent-answer="question.user_answer" v-on:modifyAnswer="updateAnswer">
                                            </MMAInteractiveOptions>
                                        </div>
                                        <div class="mt-4" v-if="question.questionType === 'MTF'">
                                            <MTFInteractiveOptions :key="question.code" :parentQid="question.code"
                                                :status="question.status" :parent-options="question.options"
                                                :parent-answer="question.user_answer" v-on:modifyAnswer="updateAnswer">
                                            </MTFInteractiveOptions>
                                        </div>
                                        <div class="mt-4" v-if="question.questionType === 'ORD'">
                                            <ORDInteractiveOptions :key="question.code" :parentQid="question.code"
                                                :status="question.status" :parent-options="question.options"
                                                :parent-answer="question.user_answer" v-on:modifyAnswer="updateAnswer">
                                            </ORDInteractiveOptions>
                                        </div>
                                        <div class="mt-4" v-if="question.questionType === 'FIB'">
                                            <FIBInteractiveOptions :key="question.code" :parentQid="question.code"
                                                :status="question.status" :parent-options="question.options"
                                                :parent-answer="question.user_answer" v-on:modifyAnswer="updateAnswer">
                                            </FIBInteractiveOptions>
                                        </div>
                                        <div class="mt-4" v-if="question.questionType === 'SAQ'">
                                            <SAQInteractiveOptions :key="question.code" :parentQid="question.code"
                                                :status="question.status" :parent-options="question.options"
                                                :parent-answer="question.user_answer" v-on:modifyAnswer="updateAnswer">
                                            </SAQInteractiveOptions>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </perfect-scrollbar>

        <!-- Footer -->
        <div class="w-full h-16 absolute z-30 bottom-0 right-0 border-t border-gray-200 mx-auto bg-white">
            <div class="w-full h-full mx-auto px-4 sm:px-6 lg:px-8">
                <div v-if="!loading" class="h-full flex flex-col justify-center items-center">
                    <div class="w-full flex items-center gap-2 justify-between">
                        <div class="flex items-center gap-2">
                            <button @click="clearAnswer" class="focus:outline-none">
                                <clear-button :name="__('Clear Answer')"></clear-button>
                            </button>
                            <button @click="markForReview" class="focus:outline-none">
                                <review-button :name="__('Mark for Review')"></review-button>
                            </button>
                        </div>
                        <div class="flex items-center gap-2">
                            <button @click="nextQuestion" class="focus:outline-none">
                                <next-button :name="nextBtnText"></next-button>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Finish Dialog -->
        <Dialog header="Confirmation" :visible.sync="displayConfirmation" :style="{ width: '350px' }" :modal="true">
            <div class="w-full flex gap-2 items-center mb-2">
                <i class="pi pi-exclamation-triangle p-mr-3 text-xl text-red-500" />
                <span class="text-base">{{ __('Are you sure you want to finish?') }}</span>
            </div>
            <div class="w-full flex gap-4 sm:justify-center items-center">
                <table class="w-full table-auto">
                    <tbody>
                        <tr>
                            <td class="border border-emerald-500 px-4 py-2 text-emerald-600 text-sm">{{ __('Answered') }}
                            </td>
                            <td class="border border-emerald-500 px-4 py-2 text-emerald-600 font-medium text-sm text-right">
                                {{ answered }}
                            </td>
                        </tr>
                        <tr class="bg-emerald-200">
                            <td class="border border-emerald-500 px-4 py-2 text-emerald-600 text-sm">{{ __('Not Answered')
                            }}</td>
                            <td class="border border-emerald-500 px-4 py-2 text-emerald-600 font-medium text-sm text-right">
                                {{ notAnsweredQuestions }}
                            </td>
                        </tr>
                        <tr>
                            <td class="border border-emerald-500 px-4 py-2 text-emerald-600 text-sm">{{ __('Not Visited') }}
                            </td>
                            <td class="border border-emerald-500 px-4 py-2 text-emerald-600 font-medium text-sm text-right">
                                {{ notVisitedQuestions }}
                            </td>
                        </tr>
                        <tr>
                            <td class="border border-emerald-500 px-4 py-2 text-emerald-600 text-sm">
                                {{ __('Marked for Review') }}</td>
                            <td class="border border-emerald-500 px-4 py-2 text-emerald-600 font-medium text-sm text-right">
                                {{ markForReviewQuestions }}
                            </td>
                        </tr>
                        <tr>
                            <td class="border border-emerald-500 px-4 py-2 text-emerald-600 text-sm">
                                {{ __('Answered & Marked for Review') }}
                            </td>
                            <td class="border border-emerald-500 px-4 py-2 text-emerald-600 font-medium text-sm text-right">
                                {{ answeredMarkForReviewQuestions }}
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <template #footer>
                <Button label="No" icon="pi pi-times" @click="closeConfirmation" class="p-button-text" />
                <Button label="Yes" icon="pi pi-check" @click="finishTest" class="p-button-text" autofocus />
            </template>
        </Dialog>
    </quiz-layout>
</template>

<script>
import QuizLayout from '@/Layouts/QuizLayout'
import PrevButton from "@/Components/Buttons/PrevButton";
import NextButton from "@/Components/Buttons/NextButton";
import ClearButton from "@/Components/Buttons/ClearButton";
import ReviewButton from "@/Components/Buttons/ReviewButton";
import FinishButton from "@/Components/Buttons/FinishButton";
import MSAInteractiveOptions from "@/Components/Questions/ExamInteract/MSAInteractiveOptions";
import MMAInteractiveOptions from "@/Components/Questions/ExamInteract/MMAInteractiveOptions";
import MTFInteractiveOptions from "@/Components/Questions/ExamInteract/MTFInteractiveOptions";
import ORDInteractiveOptions from "@/Components/Questions/ExamInteract/ORDInteractiveOptions";
import FIBInteractiveOptions from "@/Components/Questions/ExamInteract/FIBInteractiveOptions";
import SAQInteractiveOptions from "@/Components/Questions/ExamInteract/SAQInteractiveOptions";
import LightQuestionCard from "@/Components/Cards/LightQuestionCard";
import ExamQuestionChip from "@/Components/Cards/ExamQuestionChip";
import QuizQuestionCard from "@/Components/Cards/QuizQuestionCard";
import NavigationQuestionCardShimmer from "@/Components/Shimmers/NavigationQuestionCardShimmer";
import PracticeQuestionShimmer from "@/Components/Shimmers/PracticeQuestionShimmer";
import VueCountdown from '@chenfengyuan/vue-countdown';
import { PerfectScrollbar } from "vue2-perfect-scrollbar";
import AudioAttachment from "@/Components/Questions/Attachments/AudioAttachment";
import VideoAttachment from "@/Components/Questions/Attachments/VideoAttachment";
import ComprehensionAttachment from "@/Components/Questions/Attachments/ComprehensionAttachment";
import Dialog from 'primevue/dialog';
import Button from 'primevue/button';
import Tooltip from "primevue/tooltip";
import QuestionChip from "@/Components/Buttons/QuestionChip";
export default {
    components: {
        SAQInteractiveOptions,
        FIBInteractiveOptions,
        ORDInteractiveOptions,
        MTFInteractiveOptions,
        MSAInteractiveOptions,
        MMAInteractiveOptions,
        QuizLayout,
        PrevButton,
        NextButton,
        ReviewButton,
        FinishButton,
        ClearButton,
        PerfectScrollbar,
        LightQuestionCard,
        ExamQuestionChip,
        NavigationQuestionCardShimmer,
        QuizQuestionCard,
        VueCountdown,
        PracticeQuestionShimmer,
        AudioAttachment,
        VideoAttachment,
        ComprehensionAttachment,
        Dialog,
        Button,
        QuestionChip
    },
    directives: {
        'tooltip': Tooltip
    },
    props: {
        quiz: Object,
        session: Object,
        remainingTime: Number,
        answeredQuestions: Number,
    },
    data() {
        return {
            questions: [],
            answered: this.answeredQuestions,
            total_time_taken: this.session.total_time_taken,
            current_question: this.session.current_question ?? 0,
            current_question_time_remained: Infinity,
            chipView: true,
            loading: true,
            submitting: false,
            scrollbarOptions: {
                maxScrollbarLength: 1,
                suppressScrollX: true
            },
            displayConfirmation: false,
            answered_count: 0,
            current_ranking: 0,
            current_score: 0,
        }
    },
    methods: {
        updateStatus() {
            if (this.questions[this.current_question].status === 'answered_mark_for_review' ||
                (this.questions[this.current_question].status === 'touched' && this.questions[this.current_question].status === 'mark_for_review')) {
                this.questions[this.current_question].status = 'answered_mark_for_review';
            } else if (this.questions[this.current_question].status === 'touched' || this.questions[this.current_question].status === 'answered') {
                this.questions[this.current_question].status = 'answered';
            } else if (this.questions[this.current_question].status === 'mark_for_review') {
                this.questions[this.current_question].status = 'mark_for_review';
            } else {
                this.questions[this.current_question].status = 'not_answered';
            }
        },
        getPayload() {
            return {
                'question_id': this.questions[this.current_question].code,
                'user_answer': this.questions[this.current_question].user_answer,
                'time_taken': this.questions[this.current_question].time_taken,
                'time_remained': this.current_question_time_remained,
                'total_time_taken': this.total_time_taken,
                'current_question': this.current_question,
                'status': this.questions[this.current_question].status
            };
        },
        submitAnswer(payload) {
            let _this = this;
            _this.submitting = true;
            axios.post(route('update_quiz_answer', {
                quiz: this.quiz.slug,
                session: this.session.code
            }), payload)
                .then((response) => {
                    let data = response.data;
                    _this.answered = data.answered;
                    _this.submitting = false;
                    _this.current_ranking = data.current_ranking;
                    _this.current_score = parseInt(data.current_score);
                })
                .catch(function (error) {
                    _this.submitting = false;
                })
                .then(function () {
                    _this.submitting = false;
                });
        },
        async finishAlert() {
            await this.updateStatus();
            this.submitAnswer(await this.getPayload());
            this.displayConfirmation = true;
        },
        closeConfirmation() {
            this.displayConfirmation = false;
        },
        finishTest() {
            this.$inertia.post(route('finish_quiz_session', {
                quiz: this.quiz.slug,
                session: this.session.code
            }), {
                'total_time_taken': this.total_time_taken,
                'questions': this.questions
            }, { replace: true });
        },
        updateAnswer(value) {
            this.questions[this.current_question].time_remained = this.current_question_time_remained
            this.questions[this.current_question].user_answer = value;
            this.questions[this.current_question].status = 'touched';
        },
        prevQuestion() {
            if (this.current_question !== 0) {
                this.current_question--;
            }
        },
        async nextQuestion() {
            await this.updateStatus();
            this.submitAnswer(await this.getPayload());
            if (this.current_question < this.questions.length - 1) {
                this.current_question++;
            }
        },
        async jumpToQuestion(questionID) {
            await this.updateStatus();
            this.submitAnswer(await this.getPayload());
            if (this.current_question > questionID) {
                this.currentTransition = 'prev';
            } else {
                this.currentTransition = 'next';
            }
            this.current_question = questionID;
        },
        async markForReview() {
            if (this.questions[this.current_question].status === 'touched' || this.questions[this.current_question].status === 'answered') {
                this.questions[this.current_question].status = 'answered_mark_for_review';
            } else if (this.questions[this.current_question].status === 'answered_mark_for_review') {
                this.questions[this.current_question].status = 'answered_mark_for_review';
            } else {
                this.questions[this.current_question].status = 'mark_for_review';
            }
            await this.updateStatus();
            this.submitAnswer(await this.getPayload());
        },
        async clearAnswer() {
            let qType = this.questions[this.current_question].questionType;
            this.questions[this.current_question].user_answer = this.getClearedAnswer(qType);
            this.questions[this.current_question].status = 'not_answered';
            await this.updateStatus();
            this.submitAnswer(await this.getPayload());
        },
        getClearedAnswer(qType) {
            switch (qType) {
                case "MTF":
                    return this.questions[this.current_question].options['pairs'];
                case "ORD":
                    return this.questions[this.current_question].options;
                case "MMA":
                case "FIB":
                    return [];
                case "SAQ":
                case "LAQ":
                default:
                    return '';
            }
        },
        fetchQuestions() {
            let _this = this;
            _this.loading = true;
            axios.get(route('fetch_quiz_questions', {
                quiz: this.quiz.slug,
                session: this.session.code
            }))
                .then(function (response) {
                    let data = response.data;
                    _this.questions = data.questions;
                    if (_this.session.status !== 'completed') {
                        _this.startTimer();
                    }
                })
                .catch(function (error) {
                    _this.loading = false;
                })
                .then(function () {
                    _this.loading = false;
                });
        },
        transformSlotProps(props) {
            const formattedProps = {};

            Object.entries(props).forEach(([key, value]) => {
                formattedProps[key] = value < 10 ? `0${value}` : String(value);
            });

            return formattedProps;
        },
        startTimer() {
            setInterval(this.incrementTime, 1000);
        },
        incrementTime() {
            this.total_time_taken = parseInt(this.total_time_taken) + 1;
            this.questions[this.current_question].time_taken = parseInt(this.questions[this.current_question].time_taken) + 1;
        },
        goToNextQuestion() {
            const totalQuestions = this.questions.length;

            if (this.current_question < totalQuestions - 1) {
                this.current_question++;
            } else {
                this.finishTest();
            }
        },
        setRemainingTimeForCurrentQuestion({ totalSeconds }) {
            this.current_question_time_remained = totalSeconds;
        }
    },
    metaInfo() {
        return {
            title: this.title
        }
    },
    computed: {
        title() {
            return this.quiz.title + ' - ' + this.$page.props.general.app_name;
        },
        appUrl() {
            return this.$page.props.appUrl;
        },
        nextBtnText() {
            return this.current_question < this.questions.length - 1 ? this.__('Save & Next') : this.__('Save')
        },
        notAnsweredQuestions() {
            return _.sumBy(
                this.questions,
                ({ status }) => Number(status === 'not_answered')
            );
        },
        notVisitedQuestions() {
            return _.sumBy(
                this.questions,
                ({ status }) => Number(status === 'not_visited')
            );
        },
        markForReviewQuestions() {
            return _.sumBy(
                this.questions,
                ({ status }) => Number(status === 'mark_for_review')
            );
        },
        answeredMarkForReviewQuestions() {
            return _.sumBy(
                this.questions,
                ({ status }) => Number(status === 'answered_mark_for_review')
            );
        },
        touchedQuestions() {
            return _.sumBy(
                this.questions,
                ({ status }) => Number(status === 'touched')
            );
        },
        perQuestionRemainingTime() {
            return (this.questions.length > 0) ?
                this.questions[this.current_question].default_time : 1000000;
        }
    },

    mounted() {
        document.addEventListener('contextmenu', event => event.preventDefault());
        this.fetchQuestions();
    }
}
</script>
<style scoped>
.confirmation-content {
    display: flex;
    align-items: center;
    justify-content: center;
}
</style>
