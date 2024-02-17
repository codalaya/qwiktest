<template>
    <app-layout>
        <template #header>
            <div class="flex items-center">
                <back-button />
                <h1 class="app-heading">{{ __('Exam') }} {{ __('Instructions') }}</h1>
            </div>
        </template>

        <div class="py-8">
            <div class="flex flex-col items-center">
                <div class="w-full">
                    <div class="card">
                        <div class="card-body">
                            <div class="w-full lg:flex lg:ltr:flex-row lg:rtl:flex-row-reverse flex-wrap px-2 py-2">
                                <div class="py-4 lg:w-2/3 w-full md:pr-6 sm:border-r border-gray-200">
                                    <div class="inline-block bg-green-100 rounded mb-1">
                                        <p class="font-mono text-xs leading-loose text-center text-green-700 px-2">{{ exam.category }}</p>
                                    </div>
                                    <h1 class="text-2xl font-semibold text-gray-800 leading-5 py-2">{{ exam.title }}</h1>
                                    <div class="flex items-center mt-1">
                                        <div class="w-2 h-2 bg-yellow-600 rounded-full"></div>
                                        <p class="font-mono text-sm leading-3 text-yellow-600 ltr:ml-1 rtl:mr-2">{{ exam.type }}</p>
                                    </div>
                                    <hr class="my-8 border-t border-gray-200">
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
                                    <!--if exam has uncompleted session-->
                                    <div v-if="exam.uncompleted_sessions > 0" class="w-full flex flex-col">
                                        <p class="font-mono text-sm leading-normal mb-4 text-gray-600">
                                            Note: You have {{ exam.uncompleted_sessions }} uncompleted session(s)
                                        </p>
                                        <inertia-link :href="route('init_exam', {exam: exam.slug})" class="w-full block py-3 px-8 text-center font-semibold leading-4 bg-green-700 rounded focus:outline-none hover:bg-green-600 text-white cursor-pointer">
                                            {{ __('Resume Test') }}
                                        </inertia-link>
                                    </div>
                                    <!--if exam is paid and has subscription-->
                                    <div v-else-if="(exam.paid && subscription) || !exam.paid" class="w-full flex flex-col">
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
    </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    import ExamCard from "@/Components/Cards/ExamCard";
    import BackButton from "@/Components/BackButton";
    import ContentLocked from "@/Components/Cards/ContentLocked";

    export default {
        components: {
            AppLayout,
            BackButton,
            ExamCard,
            ContentLocked
        },
        props: {
            exam: Object,
            instructions: Object,
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
        metaInfo() {
            return {
                title: this.title
            }
        },

        computed: {
            title() {
                return this.exam.title + ' '+this.__('Instructions')+' - ' + this.$page.props.general.app_name;
            }
        },
    }
</script>
