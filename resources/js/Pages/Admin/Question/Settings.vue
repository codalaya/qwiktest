<template>
    <admin-layout>
        <div class="container mx-auto pt-4 px-4 sm:px-6 lg:px-8">
            <div class="w-full bg-white dark:bg-gray-800 py-5 flex flex-col xl:flex-row items-start xl:items-center justify-between px-5 xl:px-10 shadow rounded-t">
                <div class="mb-4 sm:mb-0 md:mb-0 lg:mb-0 xl:mb-0 lg:w-1/2">
                    <h2 class="text-gray-800 dark:text-gray-100 text-lg font-bold">{{ __('Question') }} {{ __('Settings') }}</h2>
                    <p class="font-normal text-sm text-gray-600 dark:text-gray-100 mt-1">{{ questionType.name }} {{ __('Question') }}</p>
                </div>
                <horizontal-stepper :steps="steps" :edit-flag="editFlag"></horizontal-stepper>
            </div>
        </div>
        <div class="container mx-auto py-8 px-4 sm:px-6 lg:px-8">
            <div class="card">
                <div class="card-body">
                    <div class="flex justify-center flex-wrap">
                        <div class="md:w-6/12 w-full py-6 md:pb-0 md:px-6">
                            <form @submit.prevent="submitForm">
                                <div class="w-full flex flex-col mb-6">
                                    <label for="skill_id" class="pb-2 text-sm font-semibold text-gray-800">{{ __('Skill') }}</label>
                                    <v-select id="skill_id" v-model="$v.form.skill_id.$model" :options="skills" @search="searchSkills"
                                              :reduce="skill => skill.id" label="name" :dir="$page.props.rtl ? 'rtl' : 'ltr'">
                                        <template v-slot:no-options="{ search, searching }">
                                            <template v-if="searching">{{ __('No results were found for this search') }}.</template>
                                            <em v-else class="opacity-50">{{ __('Start typing to search') }}.</em>
                                        </template>
                                    </v-select>
                                    <div class="form-control-errors">
                                        <p v-if="$v.form.skill_id.$error && !$v.form.skill_id.required" role="alert" class="text-xs text-red-500 pt-2">{{ __('Skill') }} {{ __('is required') }}</p>
                                    </div>
                                </div>
                                <div class="w-full flex flex-col mb-6">
                                    <label for="topic_id" class="pb-2 text-sm font-semibold text-gray-800">{{ __('Topic') }}</label>
                                    <v-select id="topic_id" v-model="form.topic_id" :options="topics" @search="searchTopics"
                                              :reduce="topic => topic.id" label="name" :dir="$page.props.rtl ? 'rtl' : 'ltr'">
                                        <template v-slot:no-options="{ search, searching }">
                                            <template v-if="searching">{{ __('No results were found for this search') }}.</template>
                                            <em v-else class="opacity-50">{{ __('Start typing to search') }}.</em>
                                        </template>
                                    </v-select>
                                </div>
                                <div class="w-full flex flex-col mb-6">
                                    <label for="tag" class="pb-2 text-sm font-semibold text-gray-800">{{ __('Tags') }}</label>
                                    <v-select taggable multiple id="tag" v-model="form.tags" :options="tags" :reduce="t => t.name" label="name"
                                               :dir="$page.props.rtl ? 'rtl' : 'ltr'">
                                        <template v-slot:no-options="{ search, searching }">
                                            <template v-if="searching">{{ __('No results were found for this search') }}.</template>
                                            <em v-else class="opacity-50">{{ __('Start typing to search') }}.</em>
                                        </template>
                                    </v-select>
                                    <small id="tag-help" v-if="errors.tags" class="p-invalid">{{ errors.tags }}</small>
                                </div>
                                <div class="w-full flex flex-col mb-6">
                                    <label class="pb-2 text-sm font-semibold text-gray-800">{{ __('Difficulty Level') }}</label>
                                    <v-select id="difficulty_level" v-model="form.difficulty_level_id" :options="difficultyLevels"
                                              :reduce="dl => dl.id" label="name" :dir="$page.props.rtl ? 'rtl' : 'ltr'">
                                        <template v-slot:no-options="{ search, searching }">
                                            <template v-if="searching">{{ __('No results were found for this search') }}.</template>
                                            <em v-else class="opacity-50">{{ __('Start typing to search') }}.</em>
                                        </template>
                                    </v-select>
                                    <div class="form-control-errors">
                                        <p v-if="$v.form.difficulty_level_id.$error && !$v.form.difficulty_level_id.required" role="alert" class="text-xs text-red-500 pt-2">{{ __('Difficulty Level') }} {{ __('is required') }}</p>
                                    </div>
                                </div>
                                <div class="w-full flex flex-col mb-6">
                                    <label for="default_marks" class="pb-2 text-sm font-semibold text-gray-800">{{ __('Default Marks') }}/{{ __('Grade Points') }}</label>
                                    <InputNumber
                                        id="default_marks"
                                        v-model="form.default_marks"
                                        placeholder="Enter Marks" aria-describedby="default_marks-help"
                                        :class="[errors.default_marks ? 'p-invalid' : '']"

                                    />
                                    <div class="form-control-errors">
                                        <p v-if="$v.form.default_marks.$error && !$v.form.default_marks.required" role="alert" class="text-xs text-red-500 pt-2">{{ __('Default Marks') }}/{{ __('Grade Points') }} {{ __('is required') }}</p>
                                    </div>
                                </div>
                                <div class="w-full flex flex-col mb-6">
                                    <label for="default_time" class="pb-2 text-sm font-semibold text-gray-800">{{ __('Default Time To Solve') }} (Seconds)</label>
                                    <InputNumber
                                        id="default_time"
                                        v-model="form.default_time"
                                        placeholder="Enter Time" aria-describedby="default_time-help"
                                        :class="[errors.default_time ? 'p-invalid' : '']"

                                    />
                                    <div class="form-control-errors">
                                        <p v-if="$v.form.default_time.$error && !$v.form.default_time.required" role="alert" class="text-xs text-red-500 pt-2">{{ __('Default Time To Solve') }} {{ __('is required') }}</p>
                                    </div>
                                </div>
                                <div class="w-full">
                                    <div class="flex justify-between items-center mb-8">
                                        <div class="w-9/12">
                                            <label for="is_active" class="font-semibold text-sm text-gray-800 pb-1" v-html="form.is_active ? __('Active') : __('In-active')"></label>
                                            <p class="text-sm text-gray-500">{{ __('Active') }} ({{ __('Shown Everywhere') }}). {{ __('In-active') }} ({{ __('Hidden Everywhere') }}).</p>
                                        </div>
                                        <div class="cursor-pointer rounded-full relative shadow-sm">
                                            <InputSwitch id="is_active" v-model="form.is_active" />
                                        </div>
                                    </div>
                                </div>
                                <!-- Submit Button -->
                                <div class="w-full flex justify-end my-8">
                                    <Button type="submit" :label="editFlag ? __('Update Settings') : __('Save Settings')" />
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
    import HorizontalStepper from "@/Components/Stepper/HorizontalStepper";
    import AdminLayout from "@/Layouts/AdminLayout";
    import {numeric, required} from "vuelidate/lib/validators";
    import InputText from "primevue/inputtext";
    import Button from "primevue/button";
    import InputSwitch from "primevue/inputswitch";
    import InputNumber from "primevue/inputnumber";
    import SelectButton from "primevue/selectbutton";

    export default {
        components: {
            AdminLayout,
            HorizontalStepper,
            InputText,
            Button,
            InputSwitch,
            InputNumber,
            SelectButton,
        },
        props: {
            question: Object,
            steps: Array,
            questionType: Object,
            editFlag: false,
            questionId: Number,
            errors: Object,
            initialSkills: Array,
            initialTopics: Array,
            initialTags: Array,
            difficultyLevels: Array,
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        data() {
            return {
                form: {
                    skill_id: this.editFlag ? this.question.skill_id : null,
                    topic_id: this.editFlag ? this.question.topic_id : null,
                    difficulty_level_id: this.editFlag ? this.question.difficulty_level_id : null,
                    default_marks: this.editFlag ? this.question.default_marks : 1,
                    default_time: this.editFlag ? this.question.default_time : 10,
                    is_active: this.editFlag ? this.question.is_active : true,
                    tags: this.editFlag ? _.map(this.question.tags, 'name') : [],
                },
                skills: this.initialSkills,
                topics: this.initialTopics,
                tags: this.initialTags,
                debounce: null,
                editorUrl: window.CKEditorURL,
                submitStatus: null,
            }
        },
        validations() {
            return {
                form: {
                    skill_id: {
                        required,
                    },
                    difficulty_level_id: {
                        required
                    },
                    default_marks: {
                        required,
                        numeric
                    },
                    default_time: {
                        required,
                        numeric
                    },
                }
            }
        },
        methods: {
            submitForm() {
                this.$v.$touch();
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
                this.$inertia.post(route('update_question_settings', { id: this.questionId }), this.form, {
                    onSuccess: () => {
                        if (Object.keys(this.errors).length === 0) {
                            this.$emit('close', true);
                        }
                    },
                });
            },
            searchSkills(search, loading) {
                if(search !== '') {
                    let _this = this;
                    loading(true);
                    clearTimeout(this.debounce);
                    this.skills = [];
                    this.debounce = setTimeout(() => {
                        axios.get(route('search_skills', {query: search}))
                            .then(function (response) {
                                _this.skills = response.data.skills;
                                loading(false);
                            })
                            .catch(function (error) {
                                loading(false);
                            });
                    }, 600)
                }
            },
            searchTopics(search, loading) {
                if(search !== '') {
                    let _this = this;
                    loading(true);
                    clearTimeout(this.debounce);
                    _this.topics = [];
                    this.debounce = setTimeout(() => {
                        axios.get(route('search_topics', {query: search, skill_id: _this.form.skill_id}))
                            .then(function (response) {
                                _this.topics = response.data.topics;
                            })
                            .catch(function (error) {
                                loading(false);
                            })
                            .then(function () {
                                loading(false);
                            });
                    }, 600)
                }
            },
        },
        computed: {
            title() {
                return this.__('Question Settings')+' - ' + this.$page.props.general.app_name;
            }
        },
    }
</script>
