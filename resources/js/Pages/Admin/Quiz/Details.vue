<template>
    <admin-layout>
        <div class="container mx-auto pt-4 px-4 sm:px-6 lg:px-8">
            <div class="w-full bg-white dark:bg-gray-800 py-5 flex flex-col xl:flex-row items-start xl:items-center justify-between px-5 xl:px-10 shadow rounded-t">
                <div class="mb-4 sm:mb-0 md:mb-0 lg:mb-0 xl:mb-0 lg:w-1/2">
                    <h2 class="text-gray-800 dark:text-gray-100 text-lg font-bold">{{ __('Quiz') }} {{ __('Details') }}</h2>
                    <p class="font-normal text-sm text-gray-600 dark:text-gray-100 mt-1" v-html="editFlag ? quiz.title : __('New')+' '+ __('Quiz')"></p>
                </div>
                <horizontal-stepper :steps="steps" :edit-flag="editFlag"></horizontal-stepper>
            </div>
        </div>
        <div class="container mx-auto py-8 px-4 sm:px-6 lg:px-8">
            <div class="card">
                <div class="card-body">
                    <div class="flex justify-center flex-wrap">
                        <div class="md:w-8/12 w-full py-6 md:pb-0 md:px-6">
                            <form @submit.prevent="submitForm">
                                <div class="w-full flex flex-col mb-6">
                                    <label for="title" class="pb-2 text-sm font-semibold text-gray-800">{{ __('Title') }}<span
                                        class="ltr:ml-1 rtl:mr-1 text-red-400">*</span></label>
                                    <InputText id="title" type="text" v-model="$v.form.title.$model"
                                               :placeholder="__('Title')" aria-describedby="title-help"/>
                                    <div class="form-control-errors">
                                        <p v-if="$v.form.title.$error && !$v.form.title.required" role="alert"
                                           class="text-xs text-red-500 pt-2">{{ __('Title') }} {{ __('is required') }}</p>
                                    </div>
                                </div>
                                <div class="grid sm:grid-cols-2 sm:gap-4">
                                    <div class="w-full flex flex-col mb-6">
                                        <label class="pb-2 text-sm font-semibold text-gray-800">{{ __('Sub Category') }}<span
                                            class="ltr:ml-1 rtl:mr-1 text-red-400">*</span></label>
                                        <v-select id="sub_category_id" v-model="form.sub_category_id"
                                                  :options="subCategories" @search="searchSubCategories"
                                                  :reduce="sub => sub.id" label="name" :dir="$page.props.rtl ? 'rtl' : 'ltr'">
                                        <template v-slot:no-options="{ search, searching }">
                                            <template v-if="searching">{{ __('No results were found for this search') }}.</template>
                                            <em v-else class="opacity-50">{{ __('Start typing to search') }}.</em>
                                        </template>
                                        </v-select>
                                        <div class="form-control-errors">
                                            <p v-if="$v.form.sub_category_id.$error && !$v.form.sub_category_id.required"
                                               role="alert" class="text-xs text-red-500 pt-2">{{ __('Sub Category') }} {{ __('is required') }}</p>
                                        </div>
                                    </div>
                                    <div class="w-full flex flex-col mb-6">
                                        <label class="pb-2 text-sm font-semibold text-gray-800">{{ __('Quiz Type') }}</label>
                                        <v-select id="quiz_type_id" v-model="form.quiz_type_id" :options="quizTypes"
                                                  :reduce="pattern => pattern.id" label="name" :dir="$page.props.rtl ? 'rtl' : 'ltr'">
                                        <template v-slot:no-options="{ search, searching }">
                                            <template v-if="searching">{{ __('No results were found for this search') }}.</template>
                                            <em v-else class="opacity-50">{{ __('Start typing to search') }}.</em>
                                        </template>
                                        </v-select>
                                        <div class="form-control-errors">
                                            <p v-if="$v.form.quiz_type_id.$error && !$v.form.quiz_type_id.required"
                                               role="alert" class="text-xs text-red-500 pt-2">{{ __('Quiz Type') }} {{ __('is required') }}</p>
                                        </div>
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
                                <div v-if="form.is_paid" class="w-full">
                                    <div class="flex justify-between items-center mb-8">
                                        <div class="w-9/12">
                                            <label for="can_redeem" class="font-semibold text-sm text-gray-800 pb-1">{{ __('Can access with Points') }} ({{ form.can_redeem ? 'Yes' : 'No' }})</label>
                                            <p class="text-gray-500 text-sm">Yes ({{ __('User should redeem with points to access quiz') }}). No ({{ __('Anyone can access') }}).</p>
                                        </div>
                                        <div class="cursor-pointer rounded-full relative shadow-sm">
                                            <InputSwitch id="can_redeem" v-model="form.can_redeem" />
                                        </div>
                                    </div>
                                </div>
                                <div v-if="form.is_paid && form.can_redeem" class="w-full flex flex-col mb-6">
                                    <label for="points_required" class="pb-2 text-sm font-semibold text-gray-800">{{ __('Points Required to Redeem') }}<span
                                        class="ml-1 text-red-400">*</span></label>
                                    <InputNumber id="points_required" v-model="$v.form.points_required.$model"
                                                 placeholder="Enter Points Required" aria-describedby="points_required-help"/>
                                    <div class="form-control-errors">
                                        <p v-if="$v.form.points_required.$error && !$v.form.points_required.required" role="alert"
                                           class="text-xs text-red-500 pt-2">{{ __('Points') }} {{ __('is required') }}</p>
                                    </div>
                                </div>
                                <div class="w-full flex flex-col mb-6">
                                    <label for="description" class="pb-2 text-sm font-semibold text-gray-800">{{ __('Description') }}</label>
                                    <ckeditor :config="editorConfig" :class="[$page.props.rtl ? 'cke_rtl' : 'cke_ltr']" id="description" :editor-url="editorUrl" v-model="form.description"></ckeditor>
                                </div>
                                <div class="w-full">
                                    <div class="flex justify-between items-center mb-8">
                                        <div class="w-9/12">
                                            <label for="is_private" class="font-semibold text-sm text-gray-800 pb-1" v-html="form.is_private ? __('Visibility')+' - '+ __('Private') : __('Visibility')+' - '+ __('Public')"></label>
                                            <p class="text-gray-500 text-sm">{{ __('Private') }} ({{ __('Only scheduled user groups can access') }}). {{ __('Public') }} ({{ __('Anyone can access') }}).</p>
                                        </div>
                                        <div class="cursor-pointer rounded-full relative shadow-sm">
                                            <InputSwitch id="is_private" v-model="form.is_private" />
                                        </div>
                                    </div>
                                </div>
                                <div v-if="editFlag" class="w-full">
                                    <div class="flex justify-between items-center mb-8">
                                        <div class="w-9/12">
                                            <label for="is_active" class="font-semibold text-gray-800 text-sm pb-1" v-html="form.is_active ? __('Status')+' - '+ __('Published') : __('Status')+' - '+ __('Draft')"></label>
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
    import InputText from 'primevue/inputtext';
    import InputNumber from 'primevue/inputnumber';
    import Dropdown from 'primevue/dropdown';
    import RadioButton from 'primevue/radiobutton';
    import Button from 'primevue/button';
    import CKEditor from 'ckeditor4-vue';
    import { required } from 'vuelidate/lib/validators';
    import InputSwitch from 'primevue/inputswitch';
    import QuizNavigation from "@/Components/Quizzes/QuizNavigation";
    import HorizontalStepper from "@/Components/Stepper/HorizontalStepper";
    export default {
        name: 'Details',
        components: {
            AdminLayout,
            ckeditor: CKEditor.component,
            InputText,
            InputNumber,
            Dropdown,
            RadioButton,
            Button,
            InputSwitch,
            QuizNavigation,
            HorizontalStepper
        },
        props: {
            quiz: Object,
            steps: Array,
            editFlag: false,
            quizId: Number,
            initialSubCategories: Array,
            quizTypes: Array,
            errors: Object
        },
        data () {
            return {
                form: {
                    title: this.editFlag ? this.quiz.title : '',
                    description: this.editFlag ? this.quiz.description : '',
                    sub_category_id: this.editFlag ? this.quiz.sub_category_id : '',
                    quiz_type_id: this.editFlag ? this.quiz.quiz_type_id : '',
                    is_paid: this.editFlag ? this.quiz.is_paid : false,
                    price: this.editFlag ? this.quiz.price : 0,
                    can_redeem: this.editFlag ? this.quiz.can_redeem : false,
                    points_required: this.editFlag ? this.quiz.points_required : null,
                    is_active: this.editFlag ? this.quiz.is_active : false,
                    is_private: this.editFlag ? this.quiz.is_private : false,
                },
                subCategories: this.initialSubCategories,
                editorUrl: window.CKEditorURL,
                editorConfig: {
                    contentsLangDirection: this.$page.props.rtl ? 'rtl' : 'ltr',
                },
                debounce: null,
                submitStatus: null
            };
        },
        watch: {
            paid(value) {
                if(value === false) {
                    this.form.can_redeem = false;
                }
            }
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
                    quiz_type_id: {
                        required
                    },
                    price: {},
                    is_paid: {},
                    can_redeem: {},
                    ...this.form.can_redeem && {
                        points_required: {
                            required
                        }
                    }
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
                let str = this.editFlag ? this.quiz.title + ' ' + this.__('Details') : this.__('Create Quiz');
                return str + ' - '+ this.$page.props.general.app_name;
            },
            paid() {
                return this.form.is_paid;
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
                this.$inertia.post(route('quizzes.store'), this.form, {
                    onSuccess: () => {
                        if (Object.keys(this.errors).length === 0) {
                            this.$emit('close', true);
                        }
                    },
                });
            },
            update() {
                this.formValidated = true;
                this.$inertia.patch(route('quizzes.update', { id: this.quizId }), this.form, {
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
        }
    }
</script>
