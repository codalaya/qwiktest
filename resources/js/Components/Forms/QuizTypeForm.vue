<template>
    <div class="overflow-y-auto h-screen px-2">
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
                <label for="name" class="pb-2 font-semibold text-gray-800">{{ __('Quiz Type') }} {{ __('Name') }}</label>
                <InputText type="text"
                           id="name"
                           v-model="form.name" aria-describedby="name-help"
                           :class="[errors.name ? 'p-invalid' : '']"

                />
                <small id="name-help" v-if="errors.name" class="p-invalid">{{ errors.name }}</small>
            </div>
            <div class="w-full flex flex-col mb-6">
                <label for="color" class="pb-2 font-semibold text-gray-800">{{ __('Color') }}</label>
                <div class="flex items-center">
                    <ColorPicker v-model="form.color" :format="'hex'" />
                    <InputText id="color" type="text" class="mt-1 block w-full" v-model="form.color" />
                </div>
                <small id="color-help" v-if="errors.color" class="p-invalid">{{ errors.color }}</small>
            </div>
            <div class="w-full flex flex-col mb-6">
                <label for="image_path" class="pb-2 font-semibold text-gray-800">{{ __('Image URL') }}</label>
                <InputText type="text"
                           id="image_path"
                           v-model="form.image_path" aria-describedby="image_path-help"
                           :class="[errors.image_path ? 'p-invalid' : '']"

                />
                <small id="image_path-help" v-if="errors.image_path" class="p-invalid">{{ errors.image_path }}</small>
            </div>
            <div class="w-full flex flex-col mb-6">
                <label for="description" class="pb-2 font-semibold text-gray-800">{{ __('Description') }}</label>
                <Textarea id="description" v-model="form.description" :class="[errors.description ? 'p-invalid' : '']"></Textarea>
                <small id="description-help" v-if="errors.description" class="p-invalid">{{ errors.description }}</small>
            </div>
            <div class="w-full">
                <div class="flex justify-between items-center mb-8">
                    <div class="w-9/12">
                        <label for="is_active" class="font-semibold text-gray-800 pb-1" v-html="form.is_active ? __('Active') : __('In-active')"></label>
                        <p class="text-sm text-gray-500">{{ __('Active') }} ({{ __('Shown Everywhere') }}). {{ __('In-active') }} ({{ __('Hidden Everywhere') }}).</p>
                    </div>
                    <div class="cursor-pointer rounded-full relative shadow-sm">
                        <InputSwitch id="is_active" v-model="form.is_active" />
                    </div>
                </div>
            </div>
            <div class="w-full flex">
                <Button type="submit" :label="editFlag ? __('Update') : __('Create')" />
            </div>
        </form>
    </div>
</template>
<script>
    import InputText from 'primevue/inputtext';
    import Button from 'primevue/button';
    import InputSwitch from 'primevue/inputswitch';
    import Textarea from 'primevue/textarea';
    import TextEditor from "@/Components/TextEditor";
    import FormInputShimmer from "@/Components/Shimmers/FormInputShimmer";
    import FormSwitchShimmer from "@/Components/Shimmers/FormSwitchShimmer";
    import ColorPicker from "primevue/colorpicker";
    export default {
        name: 'QuizTypeForm',
        components: {
            InputText,
            Button,
            InputSwitch,
            Textarea,
            TextEditor,
            FormInputShimmer,
            FormSwitchShimmer,
            ColorPicker
        },
        props: {
            editFlag: Boolean,
            quizTypeId: Number,
            formErrors: Object,
            title: ''
        },
        data() {
            return {
                errors: {},
                form: {
                    name: '',
                    description: '',
                    color: '',
                    image_path: '',
                    is_active: true,
                },
                formValidated: false,
                loading: false,
            }
        },
        watch: {
            formErrors(val) {
                this.errors = val;
            },
        },
        methods: {
            submitForm() {
                this.editFlag ? this.update() : this.create();
            },
            create() {
                this.formValidated = true;
                this.$inertia.post(route('quiz-types.store'), this.form, {
                    onSuccess: () => {
                        if (Object.keys(this.errors).length === 0) {
                            this.$emit('close', true);
                        }
                    },
                });
            },
            update() {
                this.formValidated = true;
                this.$inertia.patch(route('quiz-types.update', { id: this.quizTypeId }), this.form, {
                    onSuccess: () => {
                        if (Object.keys(this.errors).length === 0) {
                            this.$emit('close', true);
                        }
                    },
                });
            },
            fetch() {
                if(this.editFlag) {
                    let _this = this;
                    _this.loading = true;
                    axios.get(route('quiz-types.edit', { id: this.quizTypeId }))
                        .then(function (response) {
                            let data = response.data;
                            _this.form.name = data.name;
                            _this.form.color = data.color;
                            _this.form.image_path = data.image_path;
                            _this.form.description = data.description;
                            _this.form.is_active = data.is_active;
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
