<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">{{ __('Edit') }} {{ __('Lesson') }}</h4>
        </template>

        <div class="container mx-auto py-8 px-4 sm:px-6 lg:px-8">
            <div class="card">
                <div class="card-body">
                    <div class="flex justify-center flex-wrap">
                        <div class="max-w-4xl w-full py-6 md:pb-0 md:px-6">
                            <form @submit.prevent="submitForm">
                                <div class="w-full flex flex-col mb-6">
                                    <label for="title" class="pb-2 font-semibold text-gray-800 text-sm">{{ __('Lesson') }} {{ __('Title') }}</label>
                                    <InputText type="text" id="title" v-model="form.title" aria-describedby="title-help"
                                               :class="[errors.title ? 'p-invalid' : '']"/>
                                    <div class="form-control-errors">
                                        <p v-if="$v.form.title.$error && !$v.form.title.required" role="alert" class="text-xs text-red-500 pt-2">{{ __('Title') }} {{ __('is required') }}</p>
                                    </div>
                                </div>
                                <div class="w-full flex flex-col mb-6">
                                    <label for="body" class="pb-2 font-semibold text-gray-800 text-sm">{{ __('Body') }}</label>
                                    <ckeditor id="body" :editor-url="editorUrl" v-model="form.body" :config="editorConfig" :class="[$page.props.rtl ? 'cke_rtl' : 'cke_ltr', errors.question ? 'p-invalid' : '']"></ckeditor>
                                    <div class="form-control-errors">
                                        <p v-if="$v.form.body.$error && !$v.form.body.required" role="alert" class="text-xs text-red-500 pt-2">{{ __('Body') }} {{ __('is required') }}</p>
                                    </div>
                                </div>
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
                                    <label for="duration" class="pb-2 text-sm font-semibold text-gray-800">{{ __('Read Time') }} ({{ __('Minutes') }})</label>
                                    <InputNumber
                                        id="duration"
                                        v-model="form.duration" aria-describedby="duration-help"
                                        :class="[errors.duration ? 'p-invalid' : '']"

                                    />
                                    <div class="form-control-errors">
                                        <p v-if="$v.form.duration.$error && !$v.form.duration.required" role="alert" class="text-xs text-red-500 pt-2">{{ __('Read Time') }} {{ __('is required') }}</p>
                                    </div>
                                </div>
                                <div class="w-full">
                                    <div class="flex justify-between items-center mb-8">
                                        <div class="w-9/12">
                                            <label for="is_paid" class="font-semibold text-sm text-gray-800 pb-1" v-html="form.is_paid ? __('Paid') : __('Free')"></label>
                                            <p class="text-gray-500 text-sm">{{ __('Paid') }} ({{ __('Accessible to only paid users') }}). {{ __('Free') }} ({{ __('Anyone can access') }}).</p>
                                        </div>
                                        <div class="cursor-pointer rounded-full relative shadow-sm">
                                            <InputSwitch id="is_paid" v-model="form.is_paid" />
                                        </div>
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
                                    <Button type="submit" :label="editFlag ? __('Update Lesson') : __('Save Lesson')" />
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
    import {numeric, required} from "vuelidate/lib/validators";
    import InputText from "primevue/inputtext";
    import Button from "primevue/button";
    import InputSwitch from "primevue/inputswitch";
    import InputNumber from "primevue/inputnumber";
    import SelectButton from "primevue/selectbutton";
    import CKEditor from "ckeditor4-vue";

    export default {
        components: {
            AdminLayout,
            InputText,
            Button,
            InputSwitch,
            InputNumber,
            SelectButton,
            ckeditor: CKEditor.component,
        },
        props: {
            lesson: Object,
            editFlag: false,
            lessonId: Number,
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
                    title: this.editFlag ? this.lesson.title : '',
                    body: this.editFlag ? this.lesson.body : '',
                    skill_id: this.editFlag ? this.lesson.skill_id : null,
                    topic_id: this.editFlag ? this.lesson.topic_id : null,
                    difficulty_level_id: this.editFlag ? this.lesson.difficulty_level_id : null,
                    duration: this.editFlag ? this.lesson.duration : 1,
                    is_paid: this.editFlag ? this.lesson.is_paid : true,
                    is_active: this.editFlag ? this.lesson.is_active : true,
                    tags: this.editFlag ? _.map(this.lesson.tags, 'name') : [],
                },
                skills: this.initialSkills,
                topics: this.initialTopics,
                tags: this.initialTags,
                debounce: null,
                editorUrl: window.CKEditorURL,
                editorConfig: {
                    contentsLangDirection: this.$page.props.rtl ? 'rtl' : 'ltr',
                    toolbar: [
                        ['Format'],
                        ['Bold','Italic','Strike'],
                        ['Underline','Subscript','Superscript'],
                        ['NumberedList','BulletedList', 'Table', 'Blockquote'],
                        ['Image', 'Html5audio'],
                        ['Cut','Copy','Paste'],
                        ['Katex', 'CodeSnippet'],
                        ['Maximize']
                    ]
                },
                submitStatus: null,
            }
        },
        validations() {
            return {
                form: {
                    title: {
                        required,
                    },
                    body: {
                        required,
                    },
                    skill_id: {
                        required,
                    },
                    difficulty_level_id: {
                        required
                    },
                    duration: {
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
                        this.editFlag ? this.update() :this.create();
                    }, 100)
                }
            },
            create() {
                this.formValidated = true;
                this.$inertia.post(route('lessons.store'), this.form, {
                    onSuccess: () => {
                        if (Object.keys(this.errors).length === 0) {
                            this.$emit('close', true);
                        }
                    },
                });
            },
            update() {
                this.formValidated = true;
                this.$inertia.patch(route('lessons.update', { id: this.lessonId }), this.form, {
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
                return this.__('Lesson Editor')+' - ' + this.$page.props.general.app_name;
            }
        },
    }
</script>
