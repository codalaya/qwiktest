<template>
    <admin-layout>
        <div class="container mx-auto pt-4 px-4 sm:px-6 lg:px-8">
            <div class="w-full bg-white dark:bg-gray-800 py-5 flex flex-col xl:flex-row items-start xl:items-center justify-between px-5 xl:px-10 shadow rounded-t">
                <div class="mb-4 sm:mb-0 md:mb-0 lg:mb-0 xl:mb-0 lg:w-1/2">
                    <h2 class="text-gray-800 dark:text-gray-100 text-lg font-bold">{{ __('Exam') }} {{ __('Settings') }}</h2>
                    <p class="font-normal text-sm text-gray-600 dark:text-gray-100 mt-1" v-html="editFlag ? exam.title : __('New')+' '+ __('Exam')"></p>
                </div>
                <horizontal-stepper :steps="steps" :edit-flag="editFlag"></horizontal-stepper>
            </div>
        </div>
        <div class="container mx-auto py-8 px-4 sm:px-6 lg:px-8">
            <div class="card">
                <div class="card-body">
                    <div class="flex justify-center flex-wrap">
                        <div class="w-full py-6 md:pb-0 md:px-6">
                            <form @submit.prevent="submitForm">
                                <div class="flex flex-wrap">
                                    <div class="md:w-6/12 w-full py-8 md:pb-0 md:px-8 border-r border-gray-200">
                                        <div class="w-full flex justify-between items-center mb-6">
                                            <div class="flex gap-2">
                                                <label for="auto_duration" class="font-semibold text-sm text-gray-800 pb-1">{{ __('Duration Mode') }}</label>
                                                <pop-info>
                                                    <template #message>
                                                        <ul>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">Auto</span> - Duration will be calculated based on questions' default time
                                                            </li>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">Manual</span> - Duration will be considered as specified
                                                            </li>
                                                        </ul>
                                                    </template>
                                                </pop-info>
                                            </div>
                                            <SelectButton id="auto_duration" v-model="form.auto_duration" :options="autoModes"
                                                          dataKey="code" optionValue="code" optionLabel="name" />
                                        </div>
                                        <div class="w-full flex justify-between items-center mb-6">
                                            <div class="flex gap-2">
                                                <label for="auto_grading" class="font-semibold text-sm text-gray-800 pb-1">{{ __('Marks/Points Mode') }}</label>
                                                <pop-info>
                                                    <template #message>
                                                        <ul>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">Auto</span> - Marks/Points will be calculated based on questions' default marks
                                                            </li>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">Manual</span> - Marks/Points will be assigned to each question as specified
                                                            </li>
                                                        </ul>
                                                    </template>
                                                </pop-info>
                                            </div>
                                            <SelectButton id="auto_grading" v-model="form.auto_grading" :options="autoModes"
                                                          dataKey="code" optionValue="code" optionLabel="name" />
                                        </div>
                                        <div class="w-full flex justify-between items-center mb-6">
                                            <div class="flex gap-2">
                                                <label for="enable_negative_marking" class="font-semibold text-sm text-gray-800 pb-1">{{ __('Negative Marking') }}</label>
                                                <pop-info>
                                                    <template #message>
                                                        <ul>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">Yes</span> - Negative marking will be considered as specified
                                                            </li>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">No</span> - No Negative marking
                                                            </li>
                                                        </ul>
                                                    </template>
                                                </pop-info>
                                            </div>
                                            <SelectButton id="enable_negative_marking" v-model="form.enable_negative_marking" :options="choices"
                                                          dataKey="code" optionValue="code" optionLabel="name" />
                                        </div>
                                        <div class="w-full flex flex-col mb-6">
                                            <label for="cutoff" class="pb-2 text-sm font-semibold text-gray-800">{{ __('Overall Pass Percentage') }}<span class="ml-1 text-red-400">*</span></label>
                                            <InputNumber id="cutoff" v-model="$v.form.cutoff.$model" placeholder="Enter Percentage" aria-describedby="cutoff-help"
                                                         suffix=" %" :max="100" />
                                            <div class="form-control-errors">
                                                <p v-if="$v.form.cutoff.$error && !$v.form.cutoff.required" role="alert" class="text-xs text-red-500 pt-2">
                                                    {{ __('Pass Percentage') }} {{ __('is required') }}
                                                </p>
                                            </div>
                                        </div>
                                        <div class="w-full flex justify-between items-center mb-6">
                                            <div class="flex gap-2">
                                                <label for="enable_section_cutoff" class="font-semibold text-sm text-gray-800 pb-1">{{ __('Enable Section Cutoff/Percentage') }}</label>
                                                <pop-info>
                                                    <template #message>
                                                        <ul>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">Yes</span> - Test taker must obtain minimum percentage in section
                                                            </li>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">No</span> - No minimum percentage required in section
                                                            </li>
                                                        </ul>
                                                    </template>
                                                </pop-info>
                                            </div>
                                            <SelectButton id="enable_section_cutoff" v-model="form.enable_section_cutoff" :options="choices"
                                                          dataKey="code" optionValue="code" optionLabel="name" />
                                        </div>
                                    </div>
                                    <div class="md:w-6/12 w-full py-8 md:pb-0 md:px-8">
                                        <div class="w-full flex justify-between items-center mb-6">
                                            <div class="flex gap-2">
                                                <label for="restrict_attempts" class="font-semibold text-sm text-gray-800 pb-1">{{ __('Shuffle Questions') }}</label>
                                                <pop-info>
                                                    <template #message>
                                                        <ul>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">Yes</span> - Questions will be shuffled for each attempt
                                                            </li>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">No</span> - Questions will not be shuffled
                                                            </li>
                                                        </ul>
                                                    </template>
                                                </pop-info>
                                            </div>
                                            <SelectButton id="shuffle_questions" v-model="form.shuffle_questions" :options="choices"
                                                          dataKey="code" optionValue="code" optionLabel="name" />
                                        </div>
                                        <div class="w-full flex justify-between items-center mb-6">
                                            <div class="flex gap-2">
                                                <label for="restrict_attempts" class="font-semibold text-sm text-gray-800 pb-1">{{ __('Restrict Attempts') }}</label>
                                                <pop-info>
                                                    <template #message>
                                                        <ul>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">Yes</span> - Attempts will be restricted as specified
                                                            </li>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">No</span> - Unlimited attempts
                                                            </li>
                                                        </ul>
                                                    </template>
                                                </pop-info>
                                            </div>
                                            <SelectButton id="restrict_attempts" v-model="form.restrict_attempts" :options="choices"
                                                          dataKey="code" optionValue="code" optionLabel="name" />
                                        </div>
                                        <div v-if="form.restrict_attempts" class="w-full flex flex-col mb-6">
                                            <label for="no_of_attempts" class="pb-2 text-sm font-semibold text-gray-800">{{ __('Number of Attempts') }}<span class="ml-1 text-red-400">*</span></label>
                                            <InputNumber id="no_of_attempts" v-model="$v.form.no_of_attempts.$model" placeholder="Enter Number" aria-describedby="no_of_attempts-help" />
                                            <div class="form-control-errors">
                                                <p v-if="$v.form.no_of_attempts.$error && !$v.form.no_of_attempts.required" role="alert" class="text-xs text-red-500 pt-2">
                                                    {{ __('Number of Attempts') }} {{ __('is required') }}
                                                </p>
                                            </div>
                                        </div>
                                        <div class="w-full flex justify-between items-center mb-6">
                                            <div class="flex gap-2">
                                                <label for="disable_section_navigation" class="font-semibold text-sm text-gray-800 pb-1">{{ __('Disable Section Navigation') }}</label>
                                                <pop-info>
                                                    <template #message>
                                                        <ul>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">Yes</span> - Section navigation will be disabled during exam
                                                            </li>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">No</span> - Test takers can navigate sections during exam
                                                            </li>
                                                        </ul>
                                                    </template>
                                                </pop-info>
                                            </div>
                                            <SelectButton id="disable_section_navigation" v-model="form.disable_section_navigation"
                                                          :options="choices" dataKey="code" optionValue="code" optionLabel="name" />
                                        </div>
                                        <div class="w-full flex justify-between items-center mb-6">
                                            <div class="flex gap-2">
                                                <label for="disable_finish_button" class="font-semibold text-sm text-gray-800 pb-1">{{ __('Disable Finish Button') }}</label>
                                                <pop-info>
                                                    <template #message>
                                                        <ul>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">Yes</span> - Test Finish button will be disabled
                                                            </li>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">No</span> - Test Finish button will be displayed
                                                            </li>
                                                        </ul>
                                                    </template>
                                                </pop-info>
                                            </div>
                                            <SelectButton id="disable_finish_button" v-model="form.disable_finish_button"
                                                          :options="choices" dataKey="code" optionValue="code" optionLabel="name" />
                                        </div>
                                        <div class="w-full flex justify-between items-center mb-6">
                                            <div class="flex gap-2">
                                                <label for="list_questions" class="font-semibold text-sm text-gray-800 pb-1">{{ __('Enable Question List View') }}</label>
                                                <pop-info>
                                                    <template #message>
                                                        <ul>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">Yes</span> - User can be able to see all questions as list
                                                            </li>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">No</span> - User cannot be able to see all questions as list
                                                            </li>
                                                        </ul>
                                                    </template>
                                                </pop-info>
                                            </div>
                                            <SelectButton id="list_questions" v-model="form.list_questions" :options="choices"
                                                          dataKey="code" optionValue="code" optionLabel="name" />
                                        </div>
                                        <div class="w-full flex justify-between items-center mb-6">
                                            <div class="flex gap-2">
                                                <label for="hide_solutions" class="font-semibold text-sm text-gray-800 pb-1">{{ __('Hide Solutions') }}</label>
                                                <pop-info>
                                                    <template #message>
                                                        <ul>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">Yes</span> - Solutions will not be shown in results
                                                            </li>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">No</span> - Solutions will be shown in results
                                                            </li>
                                                        </ul>
                                                    </template>
                                                </pop-info>
                                            </div>
                                            <SelectButton id="hide_solutions" v-model="form.hide_solutions"
                                                          :options="choices" dataKey="code" optionValue="code" optionLabel="name" />
                                        </div>
                                        <div class="w-full flex justify-between items-center mb-6">
                                            <div class="flex gap-2">
                                                <label for="show_leaderboard" class="font-semibold text-sm text-gray-800 pb-1">{{ __('Show Leaderboard') }}</label>
                                                <pop-info>
                                                    <template #message>
                                                        <ul>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">Yes</span> - Leaderboard will be shown to test takers
                                                            </li>
                                                            <li class="text-sm text-gray-500">
                                                                <span class="text-green-400 font-semibold">No</span> - Leaderboard will not be shown to test takers
                                                            </li>
                                                        </ul>
                                                    </template>
                                                </pop-info>
                                            </div>
                                            <SelectButton id="show_leaderboard" v-model="form.show_leaderboard"
                                                          :options="choices" dataKey="code" optionValue="code" optionLabel="name" />
                                        </div>
                                    </div>
                                </div>
                                <div class="w-full flex justify-end my-8">
                                    <button type="submit" class="qt-btn qt-btn-success" v-html="editFlag ? __('Update') : __('Save')"></button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </admin-layout>
</template>
<script>
    import AdminLayout from "@/Layouts/AdminLayout";
    import InputText from "primevue/inputtext";
    import InputNumber from "primevue/inputnumber";
    import SelectButton from "primevue/selectbutton";
    import RadioButton from "primevue/radiobutton";
    import Button from "primevue/button";
    import PopInfo from "@/Components/PopInfo";
    import {required} from "vuelidate/lib/validators";
    import HorizontalStepper from "@/Components/Stepper/HorizontalStepper";
    export default {
        name: "Settings",
        components: {
            AdminLayout,
            InputText,
            InputNumber,
            SelectButton,
            RadioButton,
            PopInfo,
            Button,
            HorizontalStepper
        },
        props: {
            errors: Object,
            exam: Object,
            steps: Array,
            editFlag: false,
            settings: Object,
        },
        data () {
            return {
                form: {
                    auto_duration: this.settings.auto_duration,
                    auto_grading: this.settings.auto_grading,
                    cutoff: this.settings.cutoff,
                    enable_section_cutoff: this.settings.enable_section_cutoff,
                    enable_negative_marking: this.settings.enable_negative_marking,
                    restrict_attempts: this.settings.restrict_attempts,
                    no_of_attempts: this.settings.no_of_attempts,
                    disable_section_navigation: this.settings.disable_section_navigation,
                    disable_question_navigation: this.settings.disable_question_navigation,
                    disable_finish_button: this.settings.disable_finish_button,
                    hide_solutions: this.settings.hide_solutions,
                    list_questions: this.settings.list_questions,
                    shuffle_questions: this.settings.shuffle_questions,
                    show_leaderboard: this.settings.show_leaderboard,
                },
                autoModes: [{name: 'Auto', code: true},{name: 'Manual', code: false}],
                choices: [{name: 'Yes', code: true},{name: 'No', code: false}],
                amountTypes: [{name: 'Fixed', code: 'fixed'},{name: 'Percentage', code: 'percentage'}],
                submitStatus: null,
            };
        },
        validations() {
            return {
                form: {
                    cutoff: {
                        required
                    },
                    no_of_attempts: {},
                    ...this.form.restrict_attempts && {
                        no_of_attempts: {
                            required
                        }
                    },
                }
            }
        },
        metaInfo() {
            return {
                title: this.title
            }
        },

        computed: {
            title() {
                return this.exam.title+ ' '+this.__('Settings')+' - ' + this.$page.props.general.app_name;
            }
        },
        methods: {
            submitForm() {
                this.$v.$touch()
                if (this.$v.$invalid) {
                    this.submitStatus = 'ERROR';
                } else {
                    this.submitStatus = 'PENDING';
                    setTimeout(() => {
                        this.submitStatus = 'OK';
                        this.update();
                    }, 100)
                }
            },
            update() {
                this.formValidated = true;
                this.$inertia.post(route('exams.settings.update', { exam: this.exam.id }), this.form, {
                    onSuccess: () => {
                        if (Object.keys(this.errors).length === 0) {
                            this.$emit('close', true);
                        }
                    },
                });
            },
        }
    }
</script>
