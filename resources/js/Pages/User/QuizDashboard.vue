<template>
    <app-layout>
        <template #header>
            <h1 class="app-heading">{{ __('Quizzes') }}</h1>
        </template>

        <div class="py-6">
            <div class="flex flex-col items-center">
                <!-- <div class="w-full mb-6">
                    <div class="flex items-center justify-between">
                        <section-header :title="'Browse'"></section-header>
                        <div class="flex ltr:flex-row rtl:flex-row-reverse items-center">
                            <div @click="prev" class="hw-prev text-secondary hover:text-primary cursor-pointer">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path></svg>
                            </div>
                            <div @click="next" class="hw-next text-secondary hover:text-primary cursor-pointer">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3"></path></svg>
                            </div>
                        </div>
                    </div>
                    <swiper class="swiper" ref="mySwiper" :options="swiperOptions">
                        <swiper-slide v-for="quizType in quizTypes" :key="quizType.code">
                            <quiz-type-card :quiz-type="quizType"></quiz-type-card>
                        </swiper-slide>
                    </swiper>
                </div> -->
                <div class="w-full">
                    <section-header :title="'Live Quizzes'">
                        <template #icon>
                            <span class="flex absolute h-3 w-3 top-4 ltr:-right-4 rtl:-left-4">
                                <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-secondary opacity-75"></span>
                                <span class="relative inline-flex rounded-full h-3 w-3 bg-secondary"></span>
                              </span>
                        </template>
                        <template #action>
                            <inertia-link :href="route('live_quizzes')">
                                <span class="text-sm font-semibold text-secondary underline">{{ __('View All') }}</span>
                            </inertia-link>
                        </template>
                    </section-header>
                    <div v-if="quizSchedules.length > 0" class="grid grid-cols-1 sm:grid-cols-2 gap-4 mb-6">
                        <template v-for="(quiz, index) in quizSchedules">
                            <quiz-schedule-card :quiz="quiz" :subscription="subscription">
                                <template #action>
                                    <inertia-link v-if="quiz.paid && (!subscription && quiz.redeem)" :href="route('quiz_schedule_instructions', {quiz: quiz.slug, schedule: quiz.code})">
                                        <span class="qt-btn qt-btn-sm qt-btn-primary">{{ __('Redeem with') }} {{ quiz.redeem }}</span>
                                    </inertia-link>
                                    <button @click="showSubscribeModal" v-else-if="quiz.paid && !subscription" class="qt-btn qt-btn-sm bg-gray-300 inline-flex items-center">
                                        <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 11V7a4 4 0 118 0m-4 8v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2z"></path></svg>
                                        <span>{{ __('Unlock') }}</span>
                                    </button>
                                    <inertia-link v-else :href="route('quiz_schedule_instructions', {quiz: quiz.slug, schedule: quiz.code})">
                                        <span class="qt-btn qt-btn-sm qt-btn-primary">{{ __('Start Quiz') }}</span>
                                    </inertia-link>
                                </template>
                            </quiz-schedule-card>
                        </template>
                    </div>
                    <div class="mb-6" v-else>
                        <empty-student-card :title="'No Schedules Found'"></empty-student-card>
                    </div>
                </div>
            </div>
        </div>
    </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    import QuizCard from "@/Components/Cards/QuizCard";
    import QuizScheduleCard from "@/Components/Cards/QuizScheduleCard";
    import EmptyStudentCard from "@/Components/Cards/EmptyStudentCard";
    import SectionHeader from "@/Components/SectionHeader";
    import QuizTypeCard from "@/Components/Cards/QuizTypeCard";
    import { Swiper, SwiperSlide } from 'vue-awesome-swiper';

    export default {
        components: {
            QuizScheduleCard,
            EmptyStudentCard,
            AppLayout,
            QuizCard,
            SectionHeader,
            QuizTypeCard,
            Swiper,
            SwiperSlide
        },
        props: {
            quizTypes: Array,
            quizSchedules: Array,
            subscription: {
                type: Boolean,
                default: false,
            }
        },

        data() {
            return {
                swiperOptions: {
                    slidesPerView: 4,
                    spaceBetween: 10,
                    breakpoints: {
                        1024: {
                            slidesPerView: 4,
                            spaceBetween: 10
                        },
                        768: {
                            slidesPerView: 3,
                            spaceBetween: 10
                        },
                        640: {
                            slidesPerView: 2,
                            spaceBetween: 5
                        },
                        320: {
                            slidesPerView: 2,
                            spaceBetween: 5
                        }
                    }
                }
            }
        },
        methods: {
            next() {
                this.swiper.slideNext();
            },
            prev() {
                this.swiper.slidePrev();
            },
            showSubscribeModal() {
                this.$swal({
                    title: '<strong>'+this.__('Subscribe to Access')+'</strong>',
                    icon: 'warning',
                    html: this.__('You don\'t have an active plan to see this content. Please subscribe.'),
                    showCloseButton: true,
                    showCancelButton: false,
                    focusConfirm: true,
                    confirmButtonText: this.__('See Pricing'),
                    confirmButtonAriaLabel: this.__('See Pricing'),
                }).then((result) => {
                    if (result.isConfirmed) {
                        this.goToPricing();
                    }
                });
            },
            goToPricing() {
                window.location.assign(route('pricing'));
            }
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        computed: {
            title() {
                return this.__('Quiz Dashboard')+' - ' + this.$page.props.general.app_name;
            },
            swiper() {
                return this.$refs.mySwiper.$swiper;
            }
        },
    }
</script>
