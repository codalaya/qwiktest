<template>
    <app-layout>
        <template #header>
            <div class="flex items-center">
                <back-button />
                <h1 class="app-heading">{{ __('Exam Schedule') }} {{ __('Instructions') }}</h1>
            </div>
        </template>

        <div class="py-8">
            <div class="flex flex-col items-center">
                <div class="w-full ">
                    <div v-if="notice" :class="notice.type === 'success' ? 'border-green-200 bg-green-100 text-green-600' : 'border-red-200 bg-red-100 text-red-600'"
                         class="font-mono px-4 py-2 border rounded text-sm mb-4">
                        {{ notice.msg }}
                    </div>
                    <div class="card">
                        <div class="card-body">
                            <div class="w-full lg:flex lg:ltr:flex-row lg:rtl:flex-row-reverse flex-wrap px-2 py-2">
                                <div class="py-4 lg:w-2/3 w-full md:pr-6 sm:border-r border-gray-200">
                                    <div class="inline-block bg-green-100 rounded mb-1">
                                        <p class="font-mono text-xs leading-loose text-center text-green-700 px-2">{{ exam.category }}</p>
                                    </div>
                                    <h1 class="text-2xl font-semibold text-gray-800 leading-normal py-2">{{ exam.title }}</h1>
                                    <div class="flex items-center mt-1">
                                        <div class="w-2 h-2 bg-yellow-600 rounded-full"></div>
                                        <p class="font-mono text-sm leading-3 text-yellow-600 ltr:ml-1 rtl:mr-1">{{ exam.type }}</p>
                                    </div>
                                    <div v-if="schedule.scheduleType === 'Fixed'" class="w-full my-8 p-4 rounded-sm bg-yellow-50 border border-yellow-100 flex flex-col gap-4">
                                        <p class="text-sm uppercase font-mono font-medium leading-3 text-yellow-600">{{ __('Fixed Schedule Time') }}</p>
                                        <div class="flex items-center text-gray-600">
                                            <i class="pi pi-calendar text-green-500"></i>
                                            <p class="text-sm font-mono leading-none text-gray-700 dark:text-gray-100 ltr:ml-2 rtl:mr-2">{{ schedule.starts_at }}</p>
                                        </div>
                                        <div class="flex items-center text-gray-600">
                                            <i class="pi pi-clock text-red-500"></i>
                                            <p class="text-sm font-mono leading-none text-gray-700 dark:text-gray-100 ltr:ml-2 rtl:mr-2">{{ schedule.ends_at }}</p>
                                        </div>
                                        <div class="flex items-center text-gray-600">
                                            <i class="pi pi-globe text-green-500"></i>
                                            <p class="text-sm font-mono leading-none text-gray-700 dark:text-gray-100 ltr:ml-2 rtl:mr-2">Timezone - {{ schedule.timezone }}</p>
                                        </div>
                                    </div>
                                    <div v-else class="w-full my-8 p-4 rounded-sm bg-yellow-50 border border-yellow-100 flex flex-col gap-4">
                                        <p class="text-sm uppercase font-mono font-medium leading-3 text-yellow-600">{{ __('Exam Available Between') }}</p>
                                        <div class="flex items-center text-gray-600">
                                            <i class="pi pi-calendar text-green-500"></i>
                                            <p class="text-sm font-mono leading-none text-gray-700 dark:text-gray-100 ltr:ml-2 rtl:mr-2">{{ schedule.starts_at }}</p>
                                        </div>
                                        <div class="flex items-center text-gray-600">
                                            <i class="pi pi-calendar text-red-500"></i>
                                            <p class="text-sm font-mono leading-none text-gray-700 dark:text-gray-100 ltr:ml-2 rtl:mr-2">{{ schedule.ends_at }}</p>
                                        </div>
                                        <div class="flex items-center text-gray-600">
                                            <i class="pi pi-globe text-green-500"></i>
                                            <p class="text-sm font-mono leading-none text-gray-700 dark:text-gray-100 ltr:ml-2 rtl:mr-2">{{ __('Timezone') }} - {{ schedule.timezone }}</p>
                                        </div>
                                    </div>
                                    <div class="flex ltr:flex-row rtl:flex-row-reverse items-center ltr:justify-start rtl:justify-end">
                                        <div>
                                            <p class="font-mono text-sm leading-3 mb-2 text-green-600">{{ __('Total Duration') }}</p>
                                            <p class="font-semibold leading-tight">{{ exam.total_duration }} {{ __('Minutes') }}</p>
                                        </div>
                                        <div class="ml-11">
                                            <p class="font-mono text-sm leading-3 mb-2 text-green-600">{{ __('No. of Questions') }}</p>
                                            <p class="font-semibold leading-tight">{{ exam.total_questions }} {{ __('Questions') }}</p>
                                        </div>
                                        <div class="ml-11">
                                            <p class="font-mono text-sm leading-3 mb-2 text-green-600">{{ __('Total Marks') }}</p>
                                            <p class="font-semibold leading-tight">{{ exam.total_marks }} {{ __('Marks') }}</p>
                                        </div>
                                    </div>
                                    <table class="w-full table-auto my-8">
                                        <tbody v-for="section in exam.sections">
                                        <tr>
                                            <td class="border border-emerald-500 text-gray-800 px-4 py-2 font-medium text-sm">{{ section.name}}</td>
                                            <td v-if="exam.section_lock" class="border border-emerald-500 text-gray-800 px-4 py-2 text-sm ">{{ Math.round(section.total_duration / 60)}} {{ __('Minutes') }}</td>
                                            <td class="border border-emerald-500 text-gray-800 px-4 py-2 text-sm ">{{ section.total_questions}} {{ __('Questions') }}</td>
                                            <td class="border border-emerald-500 text-gray-800 px-4 py-2 text-sm ">{{ section.total_marks ? section.total_marks : 0}} {{ __('Marks') }}</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <div class="text-gray-600 text-sm mb-2" v-html="exam.description"></div>
                                    <hr class="my-8 border-t border-gray-200">
                                    <h4 class="text-gray-900 font-semibold mb-4">
                                        {{ __('Exam') }} {{ __('Instructions') }}
                                    </h4>
                                    <div class="prose text-gray-800 mb-2">
                                        <ul>
                                            <li v-for="instruction in instructions.exam" v-html="instruction"></li>
                                        </ul>
                                    </div>
                                    <hr class="my-8 border-t border-gray-200">
                                    <h4 class="text-gray-900 font-semibold mb-4">
                                        {{ __('Standard Instructions') }}
                                    </h4>
                                    <div class="prose text-gray-800 mb-2">
                                        <ul>
                                            <li v-for="instruction in instructions.standard" v-html="instruction" ></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="py-4 lg:w-1/3 w-full md:pl-6">
                                    <!--Show timer if schedule not yet started-->
                                    <div v-if="schedule.status === 'active' && startsIn > 0" class="w-full flex flex-col justify-center items-center shadow mb-6 p-2 rounded bg-primary text-white">
                                        <div class="mb-2 pb-2 w-full border-b border-white border-opacity-30 text-center">Starts in</div>
                                        <vue-countdown class="w-full" :time="startsIn * 1000" @end="reloadPage" :transform="transformSlotProps" v-slot="{ days, hours, minutes, seconds }">
                                            <div class="w-full grid grid-flow-col gap-4 justify-center items-center auto-cols-max">
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
                                    <!--if exam has uncompleted session-->
                                    <div v-if="exam.uncompleted_sessions > 0" class="w-full flex flex-col">
                                        <p class="font-mono text-sm leading-normal mb-4 text-gray-600">
                                            Note: You have {{ exam.uncompleted_sessions }} uncompleted session(s)
                                        </p>
                                        <inertia-link :href="route('init_exam_schedule', {exam: exam.slug, schedule: schedule.code})" class="w-full block py-3 px-8 text-center font-semibold leading-4 bg-green-700 rounded focus:outline-none hover:bg-green-600 text-white cursor-pointer">
                                            {{ __('Resume Test') }}
                                        </inertia-link>
                                    </div>
                                    <!--Show start button if user has access and allow access-->
                                    <div v-else-if="userHasAccess">
                                        <!--if exam is paid and has subscription-->
                                        <div v-if="(exam.paid && subscription && allowAccess) || (!exam.paid && allowAccess)" class="w-full flex flex-col">
                                            <div class="pt-2">
                                                <input type="checkbox" id="agree_1" v-model="agree">
                                                <label for="agree_1" class="ltr:ml-2 rtl:mr-2 text-sm leading-normal font-normal text-gray-800 cursor-pointer">
                                                    {{ __('instructions_consent') }}
                                                </label>
                                            </div>
                                            <inertia-link v-if="agree" :href="route('init_exam', {exam: exam.slug})" class="w-full block mt-4 py-3 px-8 text-center font-semibold leading-4 bg-green-700 rounded focus:outline-none hover:bg-green-600 text-white cursor-pointer">
                                                {{ __('Start Test') }}
                                            </inertia-link>
                                            <div v-else class="w-full block mt-4 py-3 px-8 text-center font-semibold leading-4 rounded bg-green-600 opacity-75 text-white">
                                                {{ __('Start Test') }}
                                            </div>
                                        </div>
                                        <!--if exam is paid and has no subscription-->
                                        <div v-else-if="exam.paid && !subscription" class="w-full flex flex-col">
                                            <!--if exam can redeem show redeem options-->
                                            <div v-if="exam.redeem" class="w-full">
                                                <h1 class="text-2xl font-semibold text-gray-800 leading-5 pb-2">{{ __('Redeem with') }} {{ exam.redeem }}</h1>
                                                <div v-if="exam.redeem" class="font-mono p-2 inline-block bg-yellow-50 text-yellow-500 rounded text-sm my-2">
                                                    <p>Note: You'll need {{ exam.redeem }} for one attempt of this exam. {{ exam.redeem }} will be deducted from your wallet.</p>
                                                </div>
                                                <div v-if="allowAccess">
                                                    <div class="pt-2">
                                                        <input type="checkbox" id="agree" v-model="agree">
                                                        <label for="agree" class="ltr:ml-2 rtl:mr-2 text-sm leading-normal font-normal text-gray-800 cursor-pointer">
                                                            {{ __('instructions_consent') }}
                                                        </label>
                                                    </div>
                                                    <inertia-link v-if="agree" :href="route('init_exam', {exam: exam.slug})" class="w-full block mt-4 py-3 px-8 text-center font-semibold leading-4 bg-green-700 rounded focus:outline-none hover:bg-green-600 text-white cursor-pointer">
                                                        {{ __('Start Test') }}
                                                    </inertia-link>
                                                    <div v-else class="w-full block mt-4 py-3 px-8 text-center font-semibold leading-4 rounded bg-green-600 opacity-75 text-white">
                                                        {{ __('Start Test') }}
                                                    </div>
                                                </div>
                                                <div class="my-6 flex items-center justify-between">
                                                    <span class="border-b dark:border-gray-600 w-1/5 md:w-1/4"></span>
                                                    <span class="text-xs text-gray-500 dark:text-gray-400 uppercase">{{ __('OR') }}</span>
                                                    <span class="border-b dark:border-gray-600 w-1/5 md:w-1/4"></span>
                                                </div>
                                            </div>
                                            <!--show subscription content-->
                                            <content-locked :message="'You don\'t have an active plan to access this exam. Please subscribe.'"></content-locked>
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
    import ExamCard from "@/Components/Cards/ExamCard";
    import VueCountdown from "@chenfengyuan/vue-countdown";
    import BackButton from "@/Components/BackButton";
    import ContentLocked from "@/Components/Cards/ContentLocked";

    export default {
        components: {
            AppLayout,
            ExamCard,
            BackButton,
            VueCountdown,
            ContentLocked
        },
        props: {
            exam: Object,
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
                return this.exam.title + ' '+this.__('Instructions')+' - ' + this.$page.props.general.app_name;
            },
            notice() {
                if(this.schedule.status === 'expired') {
                    return {
                        type: 'warning',
                        msg: this.__('schedule_expire_note')
                    }
                }
                if(this.schedule.status === 'cancelled') {
                    return {
                        type: 'warning',
                        msg: this.__('schedule_cancelled_note')
                    }
                }
                if(!this.userHasAccess) {
                    return {
                        type: 'warning',
                        msg: this.__('exam_no_access_note')
                    }
                }
                if(this.startsIn > 0) {
                    return {
                        type: 'success',
                        msg: this.__('exam_access_note')
                    }
                }
                if(this.allowAccess) {
                    return {
                        type: 'success',
                        msg: this.__('schedule_live_note') + this.closesAt + '.'
                    }
                }
                if(!this.allowAccess && this.startsIn <= 0) {
                    return {
                        type: 'warning',
                        msg: this.__('schedule_close_note')
                    }
                }
                return null;
            }
        },
    }
</script>
