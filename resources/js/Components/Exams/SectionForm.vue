<template>
    <div class="h-screen overflow-y-auto">
        <div class="bg-gray-100 py-4 lg:py-4 rounded">
            <div class="container px-6 mx-auto flex flex-col md:flex-row items-start md:items-center justify-between">
                <div>
                    <h4 class="text-base font-semibold leading-tight text-gray-800">
                        {{ title }}
                    </h4>
                </div>
            </div>
        </div>
        <div v-if="loading" class="my-6 w-11/12 mx-auto xl:w-full xl:mx-0">
            <form-input-shimmer></form-input-shimmer>
            <form-input-shimmer></form-input-shimmer>
            <form-input-shimmer></form-input-shimmer>
            <form-switch-shimmer></form-switch-shimmer>
        </div>
        <form v-else class="my-6 w-11/12 mx-auto xl:w-full xl:mx-0" @submit.prevent="submitForm">
            <div class="w-full flex flex-col mb-6">
                <label for="name" class="pb-2 text-sm font-semibold text-gray-800">{{ __('Display Name') }}<span class="ml-1 text-red-400">*</span></label>
                <InputText id="name" v-model="form.name" placeholder="Enter Name" aria-describedby="name-help"/>
                <small id="name-help" v-if="errors.name" class="p-invalid">{{ errors.name }}</small>
                <div class="form-control-errors">
                    <p v-if="form.name.$error && form.name.required" role="alert" class="text-xs text-red-500 pt-2">{{ __('Display Name') }} {{ __('is required') }}</p>
                </div>
            </div>

            <div class="w-full flex flex-col mb-6">
                <label for="skill_id" class="pb-2 text-sm font-semibold text-gray-800">{{ __('Section') }}</label>
                <v-select id="skill_id" v-model="$v.form.section_id.$model" :options="sections" @search="searchSections"
                          :reduce="s => s.id" label="name" :dir="$page.props.rtl ? 'rtl' : 'ltr'">
                    <template v-slot:no-options="{ search, searching }">
                        <template v-if="searching">{{ __('No results were found for this search') }}.</template>
                        <em v-else class="opacity-50">{{ __('Start typing to search') }}.</em>
                    </template>
                </v-select>
                <div class="form-control-errors">
                    <p v-if="$v.form.section_id.$error && !$v.form.section_id.required" role="alert" class="text-xs text-red-500 pt-2">{{ __('Section') }} {{ __('is required') }}</p>
                </div>
            </div>

            <div v-if="!exam.settings.auto_duration" class="w-full flex flex-col mb-6">
                <label for="total_duration" class="pb-2 text-sm font-semibold text-gray-800">{{ __('Duration') }} ({{ __('Minutes') }})<span class="ml-1 text-red-400">*</span></label>
                <InputNumber id="total_duration" v-model="$v.form.total_duration.$model" placeholder="Enter Duration (in Minutes)"
                             aria-describedby="total_duration-help" :disabled="form.enable_section_timer"/>
                <div class="form-control-errors">
                    <p v-if="$v.form.total_duration.$error && !$v.form.total_duration.required" role="alert" class="text-xs text-red-500 pt-2">
                        {{ __('Duration') }} {{ __('is required') }}
                    </p>
                </div>
            </div>

            <div v-if="!exam.settings.auto_grading" class="w-full flex flex-col mb-6">
                <label for="correct_marks" class="pb-2 text-sm font-semibold text-gray-800">{{ __('Marks for Correct Answer') }}<span class="ml-1 text-red-400">*</span></label>
                <InputNumber id="correct_marks" v-model="$v.form.correct_marks.$model" placeholder="Enter Marks" mode="decimal"
                             :minFractionDigits="2" :maxFracionDigits="2" aria-describedby="correct_marks-help"/>
                <div class="form-control-errors">
                    <p v-if="$v.form.correct_marks.$error && !$v.form.correct_marks.required" role="alert" class="text-xs text-red-500 pt-2">{{ __('Marks for Correct Answer') }} {{ __('is required') }}</p>
                </div>
            </div>

            <div v-if="exam.settings.enable_negative_marking" class="w-full flex justify-between items-center mb-6">
                <div class="flex gap-2">
                    <label for="negative_marking_type" class="font-semibold text-sm text-gray-800 pb-1">{{ __('Negative Marking Type') }}</label>
                    <pop-info>
                        <template #message>
                            <ul>
                                <li class="text-sm text-gray-500">
                                    <span class="text-green-400 font-semibold">Fixed</span> - Fixed amount will be deduct from question marks
                                </li>
                                <li class="text-sm text-gray-500">
                                    <span class="text-green-400 font-semibold">Percentage</span> - Percentage will be deduct from question marks
                                </li>
                            </ul>
                        </template>
                    </pop-info>
                </div>
                <SelectButton id="negative_marking_type" v-model="form.negative_marking_type" :options="amountTypes"
                              dataKey="code" optionValue="code" optionLabel="name" />
            </div>

            <div v-if="exam.settings.enable_negative_marking" class="w-full flex flex-col mb-6">
                <label for="negative_marks" class="pb-2 text-sm font-semibold text-gray-800">{{ __('Negative Marks') }}<span class="ml-1 text-red-400">*</span></label>
                <InputNumber id="negative_marks" v-model="$v.form.negative_marks.$model" aria-describedby="negative_marks-help"
                             :placeholder="form.negative_marking_type === 'percentage' ? 'Enter Percentage' : 'Enter Number'"
                             :suffix="form.negative_marking_type === 'percentage' ? ' %' : ''" :max="100"
                             mode="decimal" :minFractionDigits="form.negative_marking_type === 'fixed' ? 2 : null"
                             :maxFracionDigits="form.negative_marking_type === 'fixed' ? 2 : null" />
                <div class="form-control-errors">
                    <p v-if="$v.form.negative_marks.$error && !$v.form.negative_marks.required" role="alert" class="text-xs text-red-500 pt-2">
                        {{ __('Negative Marks') }} {{ __('are required') }}
                    </p>
                </div>
            </div>

            <div v-if="exam.settings.enable_section_cutoff" class="w-full flex flex-col mb-6">
                <label for="section_cutoff" class="pb-2 text-sm font-semibold text-gray-800">{{ __('Pass Percentage') }}<span class="ml-1 text-red-400">*</span></label>
                <InputNumber id="section_cutoff" v-model="$v.form.section_cutoff.$model" placeholder="Enter Percentage" aria-describedby="section_cutoff-help"
                             suffix=" %" :max="100" />
                <div class="form-control-errors">
                    <p v-if="$v.form.section_cutoff.$error && !$v.form.section_cutoff.required" role="alert" class="text-xs text-red-500 pt-2">
                        {{ __('Pass Percentage') }} {{ __('is required') }}
                    </p>
                </div>
            </div>

            <div class="w-full flex flex-col mb-6">
                <label for="section_order" class="pb-2 text-sm font-semibold text-gray-800">{{ __('Section Order') }}<span class="ml-1 text-red-400">*</span></label>
                <InputNumber id="section_order" v-model="$v.form.section_order.$model" placeholder="Enter Order" aria-describedby="section_order-help" />
                <div class="form-control-errors">
                    <p v-if="$v.form.section_order.$error && !$v.form.section_order.required" role="alert" class="text-xs text-red-500 pt-2">
                        {{ __('Section Order') }} {{ __('is required') }}
                    </p>
                </div>
            </div>

            <div class="w-full flex">
                <Button type="submit" :label="editFlag ? __('Update') : __('Add')" />
            </div>
        </form>
    </div>
</template>
<script>
    import InputText from 'primevue/inputtext';
    import Dropdown from 'primevue/dropdown';
    import Button from 'primevue/button';
    import InputSwitch from 'primevue/inputswitch';
    import {required} from "vuelidate/lib/validators";
    import InputNumber from "primevue/inputnumber";
    import SelectButton from "primevue/selectbutton";
    import RadioButton from "primevue/radiobutton";
    import PopInfo from "@/Components/PopInfo";
    import vSelect from "vue-select";
    import FormInputShimmer from "@/Components/Shimmers/FormInputShimmer";
    import FormSwitchShimmer from "@/Components/Shimmers/FormSwitchShimmer";
    export default {
        name: 'SectionForm',
        components: {
            InputText,
            Dropdown,
            Button,
            InputSwitch,
            InputNumber,
            SelectButton,
            RadioButton,
            FormInputShimmer,
            FormSwitchShimmer,
            PopInfo,
            vSelect
        },
        props: {
            editFlag: Boolean,
            exam: Object,
            sectionId: Number,
            errors: Object,
            title: '',
        },
        data() {
            return {
                sections: [],
                examId: this.exam.id,
                form: {
                    section_id: '',
                    name: '',
                    auto_duration: true,
                    total_duration: 0,
                    auto_grading: true,
                    correct_marks: null,
                    enable_section_cutoff: false,
                    section_cutoff: null,
                    enable_negative_marking: false,
                    negative_marking_type: 'fixed',
                    negative_marks: null,
                    section_order: null
                },
                autoModes: [{name: 'Auto', code: true},{name: 'Manual', code: false}],
                choices: [{name: 'Yes', code: true},{name: 'No', code: false}],
                amountTypes: [{name: 'Fixed', code: 'fixed'},{name: 'Percentage', code: 'percentage'}],
                debounce: null,
                loading: false,
                submitStatus: null,
                formValidated: false,
            }
        },
        validations() {
            return {
                form: {
                    section_id: {
                        required
                    },
                    correct_marks: {},
                    total_duration: {},
                    negative_marks: {},
                    section_cutoff: {},
                    section_order: {},
                    ...!this.form.auto_grading && {
                        correct_marks: {
                            required
                        }
                    },
                    ...!this.form.auto_duration && {
                        total_duration: {
                            required
                        }
                    },
                    ...this.form.enable_negative_marking && {
                        negative_marks: {
                            required
                        }
                    },
                    ...this.form.enable_section_cutoff && {
                        section_cutoff: {
                            required
                        }
                    }
                }
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
                this.$inertia.post(route('exams.sections.store', { exam: this.examId }), this.form, {
                    onSuccess: () => {
                        if (Object.keys(this.errors).length === 0) {
                            this.$emit('close', true);
                        }
                    },
                });
            },
            update() {
                this.formValidated = true;
                this.$inertia.patch(route('exams.sections.update', { exam: this.examId, section: this.sectionId }), this.form, {
                    onSuccess: () => {
                        if (Object.keys(this.errors).length === 0) {
                            this.$emit('close', true);
                        }
                    },
                });
            },
            searchSections(search, loading) {
                if(search !== '') {
                    let _this = this;
                    loading(true);
                    clearTimeout(this.debounce);
                    this.skills = [];
                    this.debounce = setTimeout(() => {
                        axios.get(route('search_sections', {query: search}))
                            .then(function (response) {
                                _this.sections = response.data.sections;
                                loading(false);
                            })
                            .catch(function (error) {
                                loading(false);
                            });
                    }, 600)
                }
            },
            fetch() {
                if(this.editFlag) {
                    let _this = this;
                    _this.loading = true;
                    axios.get(route('exams.sections.edit', { exam: this.examId, section: this.sectionId }))
                        .then(function (response) {
                            let data = response.data;
                            _this.sections.push(data.section);
                            _this.form.section_id = data.section_id;
                            _this.form.name = data.name;
                            _this.form.auto_duration = _this.exam.settings.auto_duration;
                            _this.form.total_duration = parseInt(data.total_duration)/60;
                            _this.form.auto_grading = _this.exam.settings.auto_grading;
                            _this.form.correct_marks = data.correct_marks;
                            _this.form.enable_section_cutoff = _this.exam.settings.enable_section_cutoff;
                            _this.form.section_cutoff = data.section_cutoff;
                            _this.form.enable_negative_marking = _this.exam.settings.enable_negative_marking;
                            _this.form.negative_marking_type = data.negative_marking_type;
                            _this.form.negative_marks = data.negative_marks;
                            _this.form.section_order = data.section_order;
                        })
                        .catch(function (error) {
                            _this.loading = false;
                        })
                        .then(function () {
                            _this.loading = false;
                        });
                }
            }
        },
        mounted() {
            if(this.editFlag === true) {
                this.fetch();
            }
        }
    }
</script>
