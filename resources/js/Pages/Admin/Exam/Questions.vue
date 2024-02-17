<template>
    <admin-layout>
        <div class="container mx-auto pt-4 px-4 sm:px-6 lg:px-8">
            <div class="w-full bg-white dark:bg-gray-800 py-5 flex flex-col xl:flex-row items-start xl:items-center justify-between px-5 xl:px-10 shadow rounded-t">
                <div class="mb-4 sm:mb-0 md:mb-0 lg:mb-0 xl:mb-0 lg:w-1/2">
                    <h2 class="text-gray-800 dark:text-gray-100 text-lg font-bold">{{ __('Exam') }} {{ __('Questions') }}</h2>
                    <p class="font-normal text-sm text-gray-600 dark:text-gray-100 mt-1" v-html="editFlag ? exam.title : 'New Exam'"></p>
                </div>
                <horizontal-stepper :steps="steps" :edit-flag="editFlag"></horizontal-stepper>
            </div>
        </div>
        <div class="container mx-auto py-8 px-4 sm:px-6 lg:px-8">
            <div class="card">
                <div class="card-body">
                    <div class="flex justify-center flex-wrap">
                        <div class="sm:w-4/12 w-full p-4">
                            <div>
                                <h4 class="py-2 font-semibold flex items-center gap-2 text-gray-800 border-b">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" /></svg>
                                    {{ __('Sections') }}
                                </h4>
                                <ul class="w-full mt-4">
                                    <li class="my-2 p-2 border border-green-100 shadow-sm rounded-sm" v-for="section in sections" :key="'section_'+section.id"
                                        :class="[section.id === currentSectionId ? 'bg-green-50' : 'bg-white']">
                                        <div class="font-semibold">{{ section.section_order }}. {{ section.name }}</div>
                                        <div class="flex flex-col sm:flex-row gap-2">
                                            <div><a href="#" class="qt-link-success" @click="editQuestions(section)">{{ __('Add') }} {{ __('Questions') }}</a></div>
                                            <div><a href="#" class="qt-link-success" @click="viewQuestions(section)">{{ __('View') }} {{ __('Questions') }}</a></div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <div v-if="currentSection">
                                <h4 class="py-2 font-semibold flex items-center gap-2 text-gray-800 border-b mt-6">
                                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2.586a1 1 0 01-.293.707l-6.414 6.414a1 1 0 00-.293.707V17l-4 4v-6.586a1 1 0 00-.293-.707L3.293 7.293A1 1 0 013 6.586V4z"></path></svg>
                                    {{ __('Filters') }}
                                </h4>
                                <div class="w-full flex flex-col mt-6">
                                    <label for="code" class="pb-2 text-sm font-semibold text-gray-800">{{ __('Code') }}</label>
                                    <InputText type="text" id="code" v-model="codeFilter"
                                               placeholder="Enter Code" aria-describedby="code-help"/>
                                </div>
                                <div class="w-full flex flex-col mt-6">
                                    <label class="mb-3 text-sm font-semibold text-gray-800">{{ __('Type') }}</label>
                                    <div class="flex flex-col gap-2">
                                        <div class="p-field-radiobutton items-center" v-for="questionType in questionTypes">
                                            <Checkbox :id="'q_type'+questionType.id" name="q_type" :value="questionType.id" v-model="typeFilter" />
                                            <label class="text-sm text-gray-800" :for="'q_type'+questionType.id">{{ questionType.name }}</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="w-full flex flex-col mt-6">
                                    <label for="skill" class="mb-3 text-sm font-semibold text-gray-800">{{ __('Skill') }}</label>
                                    <InputText type="text" id="skill" v-model="skillFilter"
                                               placeholder="Enter Skill" aria-describedby="skill-help"/>
                                </div>
                                <div class="w-full flex flex-col mt-6">
                                    <label for="topic" class="mb-3 text-sm font-semibold text-gray-800">{{ __('Topic') }}</label>
                                    <InputText type="text" id="topic" v-model="topicFilter"
                                               placeholder="Enter Topic" aria-describedby="topic-help"/>
                                </div>
                                <div class="w-full flex flex-col mt-6">
                                    <label for="tag" class="pb-2 text-sm font-semibold text-gray-800">By Tag</label>
                                    <v-select multiple id="tag" v-model="tagArray" :options="tags" label="name"
                                              @search="searchTags" :dir="$page.props.rtl ? 'rtl' : 'ltr'">
                                        <template v-slot:no-options="{ search, searching }">
                                            <template v-if="searching">{{ __('No results were found for this search') }}.</template>
                                            <em v-else class="opacity-50">{{ __('Start typing to search') }}.</em>
                                        </template>
                                    </v-select>
                                </div>
                                <div class="w-full flex flex-col mt-6">
                                    <label class="mb-3 text-sm font-semibold text-gray-800">{{ __('Difficulty Level') }}</label>
                                    <div class="flex flex-col gap-2">
                                        <div class="p-field-radiobutton" v-for="difficulty in difficultyLevels">
                                            <Checkbox :id="'difficulty'+difficulty.id" name="difficulty" :value="difficulty.id" v-model="difficultyFilter" />
                                            <label class="text-sm text-gray-800" :for="'difficulty'+difficulty.id">{{ difficulty.name }}</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="w-full flex items-center gap-2 my-8">
                                    <button type="button" @click="resetFilters" class="w-full qt-btn qt-btn-primary">{{ __('Reset') }}</button>
                                    <button type="button" @click="filterQuestions" class="w-full qt-btn qt-btn-success">{{ __('Search') }}</button>
                                </div>
                            </div>
                        </div>
                        <div v-if="currentSection" class="sm:w-8/12 w-full my-4">
                            <div class="my-2 p-4 border border-green-100 shadow-sm rounded-sm bg-green-50">
                                <div class="font-semibold">{{ __('Currently') }} {{ qEditFlag ? __('Adding') : __('Viewing') }} {{ currentSection.name }} {{ __('Questions') }}</div>
                            </div>
                            <div class="bg-gray-100 rounded p-6">
                                <div v-if="loading" class="grid grid-cols-1 gap-4 flex-wrap">
                                    <admin-question-shimmer></admin-question-shimmer>
                                    <admin-question-shimmer></admin-question-shimmer>
                                    <admin-question-shimmer></admin-question-shimmer>
                                    <admin-question-shimmer></admin-question-shimmer>
                                </div>
                                <div v-else>
                                    <div class="text-sm mb-4">
                                        <span class="text-gray-500 font-normal">{{ pagination.total }} {{ __('items_found_message') }}.</span>
                                    </div>
                                    <div class="grid grid-cols-1 gap-4 flex-wrap">
                                        <template v-for="(question, index) in questions">
                                            <template v-if="question.question_type === 'MSA'">
                                                <MSAPreview :question="question">
                                                    <template #action>
                                                        <button class="qt-btn-sm" @click="qEditFlag ? addQuestion(question.id, index) : removeQuestion(question.id, index)" v-html="qEditFlag ? __('Add') : __('Remove')"
                                                                :class="[qEditFlag ? 'qt-btn-success' : 'qt-btn-danger', question.disabled || processing ? 'opacity-25': '']"
                                                                :disabled="question.disabled"></button>
                                                    </template>
                                                </MSAPreview>
                                            </template>
                                            <template v-if="question.question_type === 'MMA'">
                                                <MMAPreview :question="question">
                                                    <template #action>
                                                        <button class="qt-btn-sm" @click="qEditFlag ? addQuestion(question.id, index) : removeQuestion(question.id, index)" v-html="qEditFlag ? __('Add') : __('Remove')"
                                                                :class="[qEditFlag ? 'qt-btn-success' : 'qt-btn-danger', question.disabled || processing ? 'opacity-25': '']"
                                                                :disabled="question.disabled"></button>
                                                    </template>
                                                </MMAPreview>
                                            </template>
                                            <template v-if="question.question_type === 'TOF'">
                                                <TOFPreview :question="question">
                                                    <template #action>
                                                        <button class="qt-btn-sm" @click="qEditFlag ? addQuestion(question.id, index) : removeQuestion(question.id, index)" v-html="qEditFlag ? __('Add') : __('Remove')"
                                                                :class="[qEditFlag ? 'qt-btn-success' : 'qt-btn-danger', question.disabled || processing ? 'opacity-25': '']"
                                                                :disabled="question.disabled"></button>
                                                    </template>
                                                </TOFPreview>
                                            </template>
                                            <template v-if="question.question_type === 'FIB'">
                                                <FIBPreview :question="question">
                                                    <template #action>
                                                        <button class="qt-btn-sm" @click="qEditFlag ? addQuestion(question.id, index) : removeQuestion(question.id, index)" v-html="qEditFlag ? __('Add') : __('Remove')"
                                                                :class="[qEditFlag ? 'qt-btn-success' : 'qt-btn-danger', question.disabled || processing ? 'opacity-25': '']"
                                                                :disabled="question.disabled"></button>
                                                    </template>
                                                </FIBPreview>
                                            </template>
                                            <template v-if="question.question_type === 'MTF'">
                                                <MTFPreview :question="question">
                                                    <template #action>
                                                        <button class="qt-btn-sm" @click="qEditFlag ? addQuestion(question.id, index) : removeQuestion(question.id, index)" v-html="qEditFlag ? __('Add') : __('Remove')"
                                                                :class="[qEditFlag ? 'qt-btn-success' : 'qt-btn-danger', question.disabled || processing ? 'opacity-25': '']"
                                                                :disabled="question.disabled"></button>
                                                    </template>
                                                </MTFPreview>
                                            </template>
                                            <template v-if="question.question_type === 'ORD'">
                                                <ORDPreview :question="question">
                                                    <template #action>
                                                        <button class="qt-btn-sm" @click="qEditFlag ? addQuestion(question.id, index) : removeQuestion(question.id, index)" v-html="qEditFlag ? __('Add') : __('Remove')"
                                                                :class="[qEditFlag ? 'qt-btn-success' : 'qt-btn-danger', question.disabled || processing ? 'opacity-25': '']"
                                                                :disabled="question.disabled"></button>
                                                    </template>
                                                </ORDPreview>
                                            </template>
                                            <template v-if="question.question_type === 'SAQ'">
                                                <SAQPreview :question="question">
                                                    <template #action>
                                                        <button class="qt-btn-sm" @click="qEditFlag ? addQuestion(question.id, index) : removeQuestion(question.id, index)" v-html="qEditFlag ? __('Add') : __('Remove')"
                                                                :class="[qEditFlag ? 'qt-btn-success' : 'qt-btn-danger', question.disabled || processing ? 'opacity-25': '']"
                                                                :disabled="question.disabled"></button>
                                                    </template>
                                                </SAQPreview>
                                            </template>
                                        </template>
                                        <div v-if="questions.length === 0" class="flex justify-center items-center">
                                            <h4 class=" p-4 font-semibold">{{ __('No Questions') }}</h4>
                                        </div>
                                        <div v-else-if="pagination && !(questions.length === pagination.total)" class="flex justify-center items-center">
                                            <button @click="loadMoreQuestions" class="qt-btn qt-btn-success">{{ __('Load More') }}</button>
                                        </div>
                                        <div v-else class="flex text-sm justify-center items-center py-4">
                                            {{ __('no_more_data_message') }}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div v-else class="sm:w-8/12 w-full my-4">
                            <div v-if="!currentSection" class="bg-gray-100 rounded p-6">
                                <div class="flex justify-center items-center">
                                    <h4 class=" p-4 font-semibold">{{ __('Please choose a section to add/remove questions') }}</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </admin-layout>
</template>
<script>
    import AdminLayout from "@/Layouts/AdminLayout";
    import MSAPreview from "@/Components/Questions/Previews/MSAPreview";
    import MMAPreview from "@/Components/Questions/Previews/MMAPreview";
    import FIBPreview from "@/Components/Questions/Previews/FIBPreview";
    import MTFPreview from "@/Components/Questions/Previews/MTFPreview";
    import ORDPreview from "@/Components/Questions/Previews/ORDPreview";
    import SAQPreview from "@/Components/Questions/Previews/SAQPreview";
    import LAQPreview from "@/Components/Questions/Previews/LAQPreview";
    import TOFPreview from "@/Components/Questions/Previews/TOFPreview";
    import AdminQuestionShimmer from "@/Components/Shimmers/AdminQuestionShimmer";
    import Toast from "primevue/toast";
    import Checkbox from "primevue/checkbox";
    import Button from "primevue/button";
    import vSelect from "vue-select";
    import InputText from "primevue/inputtext";
    import HorizontalStepper from "@/Components/Stepper/HorizontalStepper";
    export default {
        name: 'ExamQuestions',
        components: {
            TOFPreview,
            LAQPreview,
            SAQPreview,
            ORDPreview,
            MTFPreview,
            FIBPreview,
            MMAPreview,
            AdminLayout,
            MSAPreview,
            AdminQuestionShimmer,
            Toast,
            Button,
            Checkbox,
            vSelect,
            InputText,
            HorizontalStepper
        },
        props: {
            exam: Object,
            difficultyLevels: Array,
            questionTypes: Array,
            sections: Array,
            steps: Array,
            editFlag: false,
        },
        data() {
            return {
                qEditFlag: false,
                currentSection: null,
                currentSectionId: null,
                questions: [],
                pagination: {},
                difficultyFilter: [],
                typeFilter: [],
                skillFilter: null,
                topicFilter: null,
                tagArray: [],
                codeFilter: '',
                tags: [],
                debounce: null,
                loading: false,
                processing: false,
            }
        },
        metaInfo() {
            return {
                title: this.title
            }
        },

        computed: {
            title() {
                return this.exam.title+ ' '+this.__('Questions')+' - ' + this.$page.props.general.app_name;
            },
            tagFilter() {
                let arr = [];
                this.tagArray.forEach((item) => arr.push(item.id));
                return arr;
            }
        },
        methods: {
            viewQuestions(section) {
                this.qEditFlag = false;
                this.currentSection = section;
                this.currentSectionId = section.id;
                this.resetFilters();
            },
            editQuestions(section) {
                this.qEditFlag = true;
                this.currentSection = section;
                this.currentSectionId = section.id;
                this.resetFilters();
            },
            resetFilters() {
                this.codeFilter = '';
                this.skillFilter = '';
                this.topicFilter = '';
                this.difficultyFilter = [];
                this.typeFilter = [];
                this.tagArray = [];
                this.filterQuestions();
            },
            filterQuestions() {
                this.qEditFlag ? this.fetchAvailableQuestions() : this.fetchQuestions();
            },
            loadMoreQuestions() {
                let _this = this;
                axios.get(this.pagination.links.next, {
                    params: {
                        difficulty_levels: this.difficultyFilter,
                        question_types: this.typeFilter,
                        skill: this.skillFilter,
                        topic: this.topicFilter,
                        code: this.codeFilter,
                        tags: this.tagFilter
                    }
                })
                    .then(function (response) {
                        let data = response.data.questions.data;
                        _this.pagination = response.data.questions.meta.pagination;
                        data.forEach((item) => _this.questions.push(item));
                        _this.loading = false;
                    })
                    .catch(function (error) {
                        _this.loading = false;
                    });
            },
            fetchQuestions() {
                let _this = this;
                _this.loading = true;
                this.questions = [];
                axios.get(route('exams.fetch_questions', {
                    exam: this.exam.id,
                    section: this.currentSection.id,
                    difficulty_levels: this.difficultyFilter,
                    question_types: this.typeFilter,
                    skill: this.skillFilter,
                    topic: this.topicFilter,
                    code: this.codeFilter,
                    tags: this.tagFilter
                }))
                    .then(function (response) {
                        let data = response.data.questions.data;
                        _this.pagination = response.data.questions.meta.pagination;
                        data.forEach((item) => _this.questions.push(item));
                        _this.loading = false;
                    })
                    .catch(function (error) {
                        _this.loading = false;
                    });
            },
            fetchAvailableQuestions() {
                let _this = this;
                _this.loading = true;
                this.questions = [];
                axios.get(route('exams.fetch_available_questions', {
                    exam: this.exam.id,
                    section: this.currentSection.section_id,
                    difficulty_levels: this.difficultyFilter,
                    question_types: this.typeFilter,
                    skill: this.skillFilter,
                    topic: this.topicFilter,
                    code: this.codeFilter,
                    tags: this.tagFilter
                }))
                    .then(function (response) {
                        let data = response.data.questions.data;
                        _this.pagination = response.data.questions.meta.pagination;
                        data.forEach((item) => _this.questions.push(item));
                        _this.loading = false;
                    })
                    .catch(function (error) {
                        _this.loading = false;
                    });
            },
            addQuestion(questionId, index) {
                let _this = this;
                _this.processing = true;
                axios.post(route('exams.add_question', {exam: this.exam.id, section: this.currentSection.id}), { question_id: questionId })
                    .then(function (response) {
                        _this.questions[index].disabled = true;
                        _this.showToast('Added', 'Lesson added successfully');
                        _this.processing = false;
                    })
                    .catch(function (error) {
                        _this.processing = false;
                    });
            },
            removeQuestion(questionId, index) {
                let _this = this;
                this.$confirm.require({
                    header: this.__('Confirm'),
                    message: this.__('Do you want to remove this question?'),
                    icon: 'pi pi-info-circle',
                    acceptClass: 'p-button-danger',
                    rejectLabel: this.__('Cancel'),
                    acceptLabel: this.__('Remove'),
                    accept: () => {
                        _this.processing = true;
                        axios.post(route('exams.remove_question', {exam: this.exam.id, section: this.currentSection.id}), { question_id: questionId })
                            .then(function (response) {
                                _this.questions[index].disabled = true;
                                _this.showToast('Removed', 'Question removed successfully');
                                _this.processing = false;
                            })
                            .catch(function (error) {
                                _this.processing = false;
                            });
                    },
                    reject: () => {
                        _this.processing = false;
                    }
                });

            },
            searchTags(search, loading) {
                if(search !== '') {
                    let _this = this;
                    loading(true);
                    clearTimeout(this.debounce);
                    this.tags = [];
                    this.debounce = setTimeout(() => {
                        axios.get(route('search_tags', {query: search}))
                            .then(function (response) {
                                _this.tags = response.data.tags;
                                loading(false);
                            })
                            .catch(function (error) {
                                loading(false);
                            });
                    }, 600)
                }
            },
            showToast(summary, detail) {
                this.$toast.add({
                    severity: 'success',
                    summary: this.__(summary),
                    detail: this.__(detail),
                    life: 3000
                });
            }
        }
    }
</script>
