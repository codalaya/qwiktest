<template>
    <app-layout>
        <template #header>
            <div class="flex items-center">
                <back-button />
                <h1 class="app-heading">{{ __('Quiz Schedule') }} {{ __('Instructions') }}</h1>
            </div>
        </template>

        <div class="py-8">
            <div class="flex flex-col items-center">
                <div class="w-full ">
                    <div v-if="notice"
                        :class="notice.type === 'success' ? 'border-green-200 bg-green-100 text-green-600' : 'border-red-200 bg-red-100 text-red-600'"
                        class="font-mono px-4 py-2 border rounded text-sm mb-4">
                        {{ notice.msg }}
                    </div>
                    <div class="card">
                        <div class="card-body">
                            <div class="w-full lg:flex lg:ltr:flex-row lg:rtl:flex-row-reverse flex-wrap px-2 py-2">
                                <div class="py-4 lg:w-2/3 w-full md:pr-6 sm:border-r border-gray-200">
                                    <div class="inline-block bg-green-100 rounded mb-1">
                                        <p class="font-mono text-xs leading-loose text-center text-green-700 px-2">{{
                                            quiz.category }}</p>
                                    </div>
                                    <h1 class="text-2xl font-semibold text-gray-800 leading-normal py-2">{{ quiz.title }}
                                    </h1>
                                    <div class="flex items-center mt-1">
                                        <div class="w-2 h-2 bg-yellow-600 rounded-full"></div>
                                        <p class="font-mono text-sm leading-3 text-yellow-600 ltr:ml-1 rtl:mr-1">{{
                                            quiz.type }}</p>
                                    </div>
                                    <div v-if="schedule.scheduleType === 'Fixed'"
                                        class="w-full my-8 p-4 rounded-sm bg-yellow-50 border border-yellow-100 flex flex-col gap-4">
                                        <p class="text-sm uppercase font-mono font-medium leading-3 text-yellow-600">{{
                                            __('Fixed Schedule Time') }}</p>
                                        <div class="flex items-center text-gray-600">
                                            <i class="pi pi-calendar text-green-500"></i>
                                            <p
                                                class="text-sm font-mono leading-none text-gray-700 dark:text-gray-100 ltr:ml-2 rtl:mr-2">
                                                {{ schedule.starts_at }}</p>
                                        </div>
                                        <div class="flex items-center text-gray-600">
                                            <i class="pi pi-clock text-red-500"></i>
                                            <p
                                                class="text-sm font-mono leading-none text-gray-700 dark:text-gray-100 ltr:ml-2 rtl:mr-2">
                                                {{ schedule.ends_at }}</p>
                                        </div>
                                        <div class="flex items-center text-gray-600">
                                            <i class="pi pi-globe text-green-500"></i>
                                            <p
                                                class="text-sm font-mono leading-none text-gray-700 dark:text-gray-100 ltr:ml-2 rtl:mr-2">
                                                Timezone - {{ schedule.timezone }}</p>
                                        </div>
                                    </div>
                                    <div v-else
                                        class="w-full my-8 p-4 rounded-sm bg-yellow-50 border border-yellow-100 flex flex-col gap-4">
                                        <p class="text-sm uppercase font-mono font-medium leading-3 text-yellow-600">{{
                                            __('Quiz Available Between') }}</p>
                                        <div class="flex items-center text-gray-600">
                                            <i class="pi pi-calendar text-green-500"></i>
                                            <p
                                                class="text-sm font-mono leading-none text-gray-700 dark:text-gray-100 ltr:ltr:ml-2 rtl:mr-2 rtl:mr-2">
                                                {{ schedule.starts_at }}</p>
                                        </div>
                                        <div class="flex items-center text-gray-600">
                                            <i class="pi pi-calendar text-red-500"></i>
                                            <p
                                                class="text-sm font-mono leading-none text-gray-700 dark:text-gray-100 ltr:ltr:ml-2 rtl:mr-2 rtl:mr-2">
                                                {{ schedule.ends_at }}</p>
                                        </div>
                                        <div class="flex items-center text-gray-600">
                                            <i class="pi pi-globe text-green-500"></i>
                                            <p
                                                class="text-sm font-mono leading-none text-gray-700 dark:text-gray-100 ltr:ltr:ml-2 rtl:mr-2 rtl:mr-2">
                                                {{ __('Timezone') }} - {{ schedule.timezone }}</p>
                                        </div>
                                    </div>
                                    <div
                                        class="flex ltr:flex-row rtl:flex-row-reverse items-center ltr:justify-start rtl:justify-end">
                                        <div>
                                            <p class="font-mono text-sm leading-3 mb-2 text-green-600">
                                                {{ __('Total Duration') }}
                                            </p>
                                            <p class="font-semibold leading-tight">{{ quiz.total_duration }}
                                                {{ __('Minutes') }}
                                            </p>
                                        </div>
                                        <div class="ml-11">
                                            <p class="font-mono text-sm leading-3 mb-2 text-green-600">
                                                {{ __('No. of Questions') }}</p>
                                            <p class="font-semibold leading-tight">{{ quiz.total_questions }}
                                                {{ __('Questions') }}</p>
                                        </div>
                                        <div class="ml-11">
                                            <p class="font-mono text-sm leading-3 mb-2 text-green-600">{{ __('Total Marks')
                                            }}</p>
                                            <p class="font-semibold leading-tight">{{ quiz.total_marks }} {{ __('Marks') }}
                                            </p>
                                        </div>
                                    </div>
                                    <hr class="my-8 border-t border-gray-200">
                                    <div class="text-gray-600 text-sm mb-2" v-html="quiz.description"></div>
                                    <hr class="my-8 border-t border-gray-200">

                                </div>
                                <div class="py-4 lg:w-1/3 w-full md:pl-6">
                                    <!--Show timer if schedule not yet started-->
                                    <div v-if="schedule.status === 'active' && startsIn > 0"
                                        class="w-full flex flex-col justify-center items-center shadow mb-6 p-2 rounded bg-primary text-white">
                                        <div class="mb-2 pb-2 w-full border-b border-white border-opacity-30 text-center">
                                            Starts in</div>
                                        <vue-countdown class="w-full" :time="startsIn * 1000" @end="reloadPage"
                                            :transform="transformSlotProps" v-slot="{ days, hours, minutes, seconds }">
                                            <div
                                                class="w-full grid grid-flow-col gap-4 justify-center items-center auto-cols-max">
                                                <div v-if="days !== '00'" class="flex items-center flex-col">
                                                    <span class="text-base">{{ days }}</span>
                                                    {{ __('days') }}
                                                </div>
                                                <div class="flex items-center flex-col">
                                                    <span class="text-base">{{ hours }}</span>
                                                    {{ __('hours') }}
                                                </div>
                                                <div class="flex items-center flex-col">
                                                    <span class="text-base">{{ minutes }}</span>
                                                    {{ __('min') }}
                                                </div>
                                                <div class="flex items-center flex-col">
                                                    <span class="text-base">{{ seconds }}</span>
                                                    {{ __('sec') }}
                                                </div>
                                            </div>
                                        </vue-countdown>
                                    </div>
                                    <!--if quiz has uncompleted session-->
                                    <div v-if="quiz.uncompleted_sessions > 0" class="w-full flex flex-col">
                                        <p class="font-mono text-sm leading-normal mb-4 text-gray-600">
                                            Note: You have {{ quiz.uncompleted_sessions }} uncompleted session(s)
                                        </p>
                                        <inertia-link
                                            :href="route('init_quiz_schedule', { quiz: quiz.slug, schedule: schedule.code })"
                                            class="w-full block py-3 px-8 text-center font-semibold leading-4 bg-green-700 rounded focus:outline-none hover:bg-green-600 text-white cursor-pointer">
                                            {{ __('Resume Test') }}
                                        </inertia-link>
                                    </div>
                                    <!--Show start button if user has access and allow access-->
                                    <div v-else-if="userHasAccess">
                                        <!--if quiz is paid and has subscription-->
                                        <div v-if="(quiz.paid && subscription && allowAccess) || (!quiz.paid && allowAccess)"
                                            class="w-full flex flex-col">
                                            <div class="pt-2">
                                                <input type="checkbox" id="agree_1" v-model="agree">
                                                <label for="agree_1"
                                                    class="ltr:ml-2 rtl:mr-2 text-sm leading-normal font-normal text-gray-800 cursor-pointer">
                                                    {{ __('instructions_consent') }}
                                                </label>
                                            </div>
                                            <inertia-link v-if="agree" :href="route('init_quiz', { quiz: quiz.slug })"
                                                class="w-full block mt-4 py-3 px-8 text-center font-semibold leading-4 bg-green-700 rounded focus:outline-none hover:bg-green-600 text-white cursor-pointer">
                                                {{ __('Start Test') }}
                                            </inertia-link>
                                            <div v-else
                                                class="w-full block mt-4 py-3 px-8 text-center font-semibold leading-4 rounded bg-green-600 opacity-75 text-white">
                                                {{ __('Start Test') }}
                                            </div>
                                        </div>
                                        <!--if quiz is paid and has no subscription-->
                                        <div v-else-if="quiz.paid && !subscription" class="w-full flex flex-col">
                                            <!--if quiz can redeem show redeem options-->
                                            <div v-if="quiz.redeem" class="w-full">
                                                <h1 class="text-2xl font-semibold text-gray-800 leading-5 pb-2">{{
                                                    __('Redeem with') }} {{ quiz.redeem }}</h1>
                                                <div v-if="quiz.redeem"
                                                    class="font-mono p-2 inline-block bg-yellow-50 text-yellow-500 rounded text-sm my-2">
                                                    <p>Note: You'll need {{ quiz.redeem }} for one attempt of this quiz. {{
                                                        quiz.redeem }} will be deducted from your wallet.</p>
                                                </div>
                                                <div v-if="allowAccess">
                                                    <div class="pt-2">
                                                        <input type="checkbox" id="agree" v-model="agree">
                                                        <label for="agree"
                                                            class="ltr:ml-2 rtl:mr-2 text-sm leading-normal font-normal text-gray-800 cursor-pointer">
                                                            {{ __('instructions_consent') }}
                                                        </label>
                                                    </div>
                                                    <inertia-link v-if="agree"
                                                        :href="route('init_quiz', { quiz: quiz.slug })"
                                                        class="w-full block mt-4 py-3 px-8 text-center font-semibold leading-4 bg-green-700 rounded focus:outline-none hover:bg-green-600 text-white cursor-pointer">
                                                        {{ __('Start Test') }}
                                                    </inertia-link>
                                                    <div v-else
                                                        class="w-full block mt-4 py-3 px-8 text-center font-semibold leading-4 rounded bg-green-600 opacity-75 text-white">
                                                        {{ __('Start Test') }}
                                                    </div>
                                                </div>
                                                <div class="my-6 flex items-center justify-between">
                                                    <span class="border-b dark:border-gray-600 w-1/5 md:w-1/4"></span>
                                                    <span class="text-xs text-gray-500 dark:text-gray-400 uppercase">{{
                                                        __('OR') }}</span>
                                                    <span class="border-b dark:border-gray-600 w-1/5 md:w-1/4"></span>
                                                </div>
                                            </div>
                                            <!--show subscription content-->
                                            <content-locked
                                                :message="'You don\'t have an active plan to access this quiz. Please subscribe.'"></content-locked>
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
import QuizCard from "@/Components/Cards/QuizCard";
import VueCountdown from "@chenfengyuan/vue-countdown";
import BackButton from "@/Components/BackButton";
import ContentLocked from "@/Components/Cards/ContentLocked";

export default {
    components: {
        AppLayout,
        QuizCard,
        BackButton,
        VueCountdown,
        ContentLocked
    },
    props: {
        quiz: Object,
        schedule: Object,
        instructions: Object,
        userHasAccess: Boolean,
        allowAccess: Boolean,
        startsIn: Number,
        closesAt: String,
        subscription: {
            type: Boolean,
            default: false,
        },
    },
    data() {
        return {
            agree: false,
        }
    },
    methods: {
        reloadPage() {
            this.$inertia.reload();
        },
        transformSlotProps(props) {
            const formattedProps = {};

            Object.entries(props).forEach(([key, value]) => {
                formattedProps[key] = value < 10 ? `0${value}` : String(value);
            });

            return formattedProps;
        },
    },
    metaInfo() {
        return {
            title: this.title
        }
    },

    computed: {
        title() {
            return this.quiz.title + ' ' + this.__('Instructions') + ' - ' + this.$page.props.general.app_name;
        },
        notice() {
            if (this.schedule.status === 'expired') {
                return {
                    type: 'warning',
                    msg: this.__('schedule_expire_note')
                }
            }
            if (this.schedule.status === 'cancelled') {
                return {
                    type: 'warning',
                    msg: this.__('schedule_cancelled_note')
                }
            }
            if (!this.userHasAccess) {
                return {
                    type: 'warning',
                    msg: this.__('quiz_no_access_note')
                }
            }
            if (this.startsIn > 0) {
                return {
                    type: 'success',
                    msg: this.__('quiz_access_note')
                }
            }
            if (this.allowAccess) {
                return {
                    type: 'success',
                    msg: this.__('schedule_live_note') + this.closesAt + '.'
                }
            }
            if (!this.allowAccess && this.startsIn <= 0) {
                return {
                    type: 'warning',
                    msg: this.__('schedule_close_note')
                }
            }
            return null;
        }
    },
    mounted() {
        console.log('this.props.schedule', this.schedule)
    }
}
</script>
