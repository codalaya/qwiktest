<template>
    <admin-layout>
        <div class="container mx-auto pt-4 px-4 sm:px-6 lg:px-8">
            <div class="w-full bg-white dark:bg-gray-800 py-5 flex flex-col xl:flex-row items-start xl:items-center justify-between px-5 xl:px-10 shadow rounded-t">
                <div class="mb-4 sm:mb-0 md:mb-0 lg:mb-0 xl:mb-0 lg:w-1/2">
                    <h2 class="text-gray-800 dark:text-gray-100 text-lg font-bold">{{ __('Practice Set') }} {{ __('Details') }}</h2>
                    <p class="font-normal text-sm text-gray-600 dark:text-gray-100 mt-1" v-html="editFlag ? practiceSet.title : __('New')+' '+ __('Practice Set')"></p>
                </div>
                <horizontal-stepper :steps="steps" :edit-flag="editFlag"></horizontal-stepper>
            </div>
        </div>
        <div class="container mx-auto py-8 px-4 sm:px-6 lg:px-8">
            <div class="card">
                <div class="card-body">
                    <div class="flex justify-center flex-wrap">
                        <div class="md:w-8/12 w-full py-6 md:pb-0 md:px-6">
                            <form class="my-6 w-11/12 mx-auto xl:w-full xl:mx-0" @submit.prevent="submitForm">
                                <div class="w-full flex flex-col mb-6">
                                    <label for="title" class="pb-2 text-sm font-semibold text-gray-800">{{ __('Title') }}</label>
                                    <InputText type="title" id="title" v-model="$v.form.title.$model" :placeholder="__('Title')" aria-describedby="title-help"
                                               :class="[errors.title ? 'p-invalid' : '']" />
                                    <div class="form-control-errors">
                                        <p v-if="$v.form.title.$error && !$v.form.title.required" role="alert"
                                           class="text-xs text-red-500 pt-2">{{ __('Title') }} {{ __('is required') }}</p>
                                    </div>
                                </div>
                                <div class="w-full flex flex-col mb-6">
                                    <label class="pb-2 text-sm font-semibold text-gray-800">{{ __('Sub Category') }}<span class="ml-1 text-red-400">*</span></label>
                                    <v-select id="sub_category" v-model="$v.form.sub_category_id.$model" :options="subCategories" @search="searchSubCategories"
                                              :reduce="sub => sub.id" label="name" :dir="$page.props.rtl ? 'rtl' : 'ltr'">
                                        <template v-slot:no-options="{ search, searching }">
                                            <template v-if="searching">{{ __('No results were found for this search') }}.</template>
                                            <em v-else class="opacity-50">{{ __('Start typing to search') }}.</em>
                                        </template>
                                    </v-select>
                                    <div class="form-control-errors">
                                        <p v-if="$v.form.sub_category_id.$error && !$v.form.sub_category_id.required" role="alert"
                                           class="text-xs text-red-500 pt-2">{{ __('Sub Category') }} {{ __('is required') }}</p>
                                    </div>
                                </div>
                                <div class="w-full flex flex-col mb-6">
                                    <label for="skill" class="pb-2 text-sm font-semibold text-gray-800">{{ __('Skill') }}</label>
                                    <v-select id="skill" v-model="$v.form.skill_id.$model" :options="skills" @search="searchSkills"
                                              :reduce="skill => skill.id" label="name" :disabled="editFlag" :dir="$page.props.rtl ? 'rtl' : 'ltr'">
                                        <template v-slot:no-options="{ search, searching }">
                                            <template v-if="searching">{{ __('No results were found for this search') }}.</template>
                                            <em v-else class="opacity-50">{{ __('Start typing to search') }}.</em>
                                        </template>
                                    </v-select>
                                    <div class="form-control-errors">
                                        <p v-if="$v.form.skill_id.$error && !$v.form.skill_id.required" role="alert"
                                           class="text-xs text-red-500 pt-2">{{ __('Skill') }} {{ __('is required') }}</p>
                                    </div>
                                </div>
                                <div class="w-full">
                                    <div class="flex justify-between items-center mb-8">
                                        <div class="w-9/12">
                                            <label for="is_paid" class="font-semibold text-gray-800 pb-1" v-html="form.is_paid ? __('Paid') : __('Free')"></label>
                                            <p class="text-gray-500">{{ __('Paid') }} ({{ __('Accessible to only paid users') }}). {{ __('Free') }} ({{ __('Anyone can access') }}).</p>
                                        </div>
                                        <div class="cursor-pointer rounded-full relative shadow-sm">
                                            <InputSwitch id="is_paid" v-model="form.is_paid" />
                                        </div>
                                    </div>
                                </div>
                                <!--<div v-if="form.is_paid" class="w-full flex flex-col mb-6">
                                    <label for="price" class="pb-2 font-semibold text-gray-800">{{ __('Price') }}<span
                                        class="ml-1 text-red-400">*</span></label>
                                    <InputNumber id="price" v-model="$v.form.price.$model"
                                               placeholder="Enter Price" aria-describedby="price-help"/>
                                    <div class="form-control-errors">
                                        <p v-if="$v.form.price.$error && !$v.form.price.required" role="alert"
                                           class="text-xs text-red-500 pt-2">{{ __('Price') }} {{ __('is required') }}</p>
                                    </div>
                                </div>-->
                                <div class="w-full flex flex-col mb-6">
                                    <label for="description" class="pb-2 text-sm font-semibold text-gray-800">{{ __('Description') }}</label>
                                    <ckeditor id="description" :config="editorConfig" :class="[$page.props.rtl ? 'cke_rtl' : 'cke_ltr', errors.description ? 'p-invalid' : '']"
                                              :editor-url="editorUrl" v-model="$v.form.description.$model"></ckeditor>
                                    <div class="form-control-errors">
                                        <p v-if="$v.form.description.$error && !$v.form.description.required" role="alert"
                                           class="text-xs text-red-500 pt-2">{{ __('Description') }} {{ __('is required') }}</p>
                                    </div>
                                </div>
                                <div class="w-full">
                                    <div class="flex justify-between items-center mb-8">
                                        <div class="w-9/12">
                                            <label for="is_active" class="font-semibold text-sm text-gray-800 pb-1" v-html="form.is_active ? __('Status')+' - '+ __('Published') : __('Status')+' - '+ __('Draft')"></label>
                                            <p class="text-sm text-gray-500">{{ __('Published') }} ({{ __('Shown Everywhere') }}). {{ __('Draft') }} ({{ __('Not Shown') }}).</p>
                                        </div>
                                        <div class="cursor-pointer rounded-full relative shadow-sm">
                                            <InputSwitch id="is_active" v-model="form.is_active" />
                                        </div>
                                    </div>
                                </div>
                                <div class="w-full flex justify-end my-8">
                                    <button type="submit" class="qt-btn qt-btn-success" v-html="editFlag ? __('Update Details') : __('Save & Proceed')"></button>
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
    import HorizontalStepper from "@/Components/Stepper/HorizontalStepper";
    import CKEditor from "ckeditor4-vue";
    import InputText from "primevue/inputtext";
    import Button from "primevue/button";
    import InputSwitch from "primevue/inputswitch";
    import Textarea from "primevue/textarea";
    import TextEditor from "@/Components/TextEditor";
    import vSelect from "vue-select";
    import InputNumber from "primevue/inputnumber";
    import PopInfo from "@/Components/PopInfo";
    import SelectButton from "primevue/selectbutton";
    import { required } from 'vuelidate/lib/validators';
    export default {
        name: 'Details',
        components: {
            AdminLayout,
            HorizontalStepper,
            ckeditor: CKEditor.component,
            InputText,
            Button,
            InputSwitch,
            Textarea,
            TextEditor,
            vSelect,
            InputNumber,
            PopInfo,
            SelectButton
        },
        props: {
            practiceSet: Object,
            steps: Array,
            editFlag: {
                type: Boolean,
                default: false
            },
            practiceSetId: Number,
            initialSubCategories: Array,
            initialSkills: Array,
            errors: Object
        },
        data () {
            return {
                form: {
                    title: this.editFlag ? this.practiceSet.title : '',
                    sub_category_id: this.editFlag ? this.practiceSet.sub_category_id : null,
                    skill_id: this.editFlag ? this.practiceSet.skill_id : null,
                    description: this.editFlag ? this.practiceSet.description : '',
                    is_paid: this.editFlag ? this.practiceSet.is_paid : false,
                    is_active: this.editFlag ? this.practiceSet.is_active : true,
                },
                subCategories: this.initialSubCategories,
                skills: this.initialSkills,
                autoModes: [{name: 'Auto', code: true},{name: 'Manual', code: false}],
                editorUrl: window.CKEditorURL,
                editorConfig: {
                    contentsLangDirection: this.$page.props.rtl ? 'rtl' : 'ltr',
                },
                debounce: null,
                submitStatus: null
            };
        },
        validations() {
            return {
                form: {
                    title: {
                        required,
                    },
                    sub_category_id: {
                        required
                    },
                    skill_id: {
                        required
                    },
                    description: {},
                    is_paid: {
                        required
                    },
                    is_active: {
                        required
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
                return this.__('Practice Set Details')+' - ' + this.$page.props.general.app_name;
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
                        this.editFlag ? this.update() : this.create();
                    }, 100)
                }
            },
            create() {
                this.formValidated = true;
                this.$inertia.post(route('practice-sets.store'), this.form, {
                    onSuccess: () => {
                        if (Object.keys(this.errors).length === 0) {
                            this.$emit('close', true);
                        }
                    },
                });
            },
            update() {
                this.formValidated = true;
                this.$inertia.patch(route('practice-sets.update', { id: this.practiceSet.id }), this.form, {
                    onSuccess: () => {
                        if (Object.keys(this.errors).length === 0) {
                            this.$emit('close', true);
                        }
                    },
                });
            },
            searchSubCategories(search, loading) {
                if(search !== '') {
                    let _this = this;
                    loading(true);
                    clearTimeout(this.debounce);
                    this.subCategories = [];
                    this.debounce = setTimeout(() => {
                        axios.get(route('search_sub_categories', {query: search}))
                            .then(function (response) {
                                _this.subCategories = response.data.subCategories;
                                loading(false);
                            })
                            .catch(function (error) {
                                loading(false);
                            });
                    }, 600)
                }
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
        }
    }
</script>
