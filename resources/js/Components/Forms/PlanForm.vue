<template>
    <div class="overflow-y-auto h-screen px-2">
        <div class="bg-gray-100 py-4 lg:py-4 rounded">
            <div class="container px-6 mx-auto flex ltr:flex-row rtl:flex-row-reverse">
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
            <!-- Category Dropdown -->
            <div class="w-full flex flex-col mb-6">
                <label for="category_id" class="pb-2 font-semibold text-gray-800">{{ __('Category') }}<span class="ml-1 text-red-400">*</span></label>
                <v-select id="category_id" v-model="form.category_id" :options="subCategories" :reduce="cat => cat.id" label="name" :placeholder="__('Choose Category')" :disabled="editFlag" :dir="$page.props.rtl ? 'rtl' : 'ltr'">
                    <template v-slot:no-options="{ search, searching }">
                        <template v-if="searching">{{ __('No results were found for this search') }}.</template>
                        <em v-else class="opacity-50">{{ __('Start typing to search') }}.</em>
                    </template>
                </v-select>
                <small id="userRole-help" v-if="errors.category_id" class="p-invalid">{{ errors.category_id }}</small>
            </div>

            <!-- Plan Name -->
            <div class="w-full flex flex-col mb-6">
                <label for="name" class="pb-2 font-semibold text-gray-800">{{ __('Plan Name') }}<span class="ml-1 text-red-400">*</span></label>
                <InputText type="text"
                           id="name"
                           v-model="form.name"
                           placeholder="Enter Name" aria-describedby="name-help"
                           :class="[errors.name ? 'p-invalid' : '']"

                />
                <small id="name-help" v-if="errors.name" class="p-invalid">{{ errors.name }}</small>
            </div>

            <!-- Duration -->
            <div class="w-full flex flex-col mb-6">
                <label for="duration" class="pb-2 font-semibold text-gray-800">{{ __('Duration (Months)') }}<span class="ml-1 text-red-400">*</span></label>
                <InputNumber id="duration" v-model="form.duration" aria-describedby="last_name-help" :class="[errors.duration ? 'p-invalid' : '']"/>
                <small id="duration-help" v-if="errors.duration" class="p-invalid">{{ errors.duration }}</small>
            </div>

            <!-- Price -->
            <div class="w-full flex flex-col mb-6">
                <label for="price" class="pb-2 font-semibold text-gray-800">{{ __('Monthly Price') }}<span class="ml-1 text-red-400">*</span></label>
                <InputNumber id="price" v-model="form.price" aria-describedby="price-help" :class="[errors.price ? 'p-invalid' : '']"/>
                <small id="price-help" v-if="errors.price" class="p-invalid">{{ errors.price }}</small>
            </div>

            <!-- Discount Switch -->
            <div class="w-full">
                <div class="flex justify-between items-center mb-8">
                    <div class="w-9/12">
                        <label for="has_discount" class="font-semibold text-gray-800 pb-1" v-html="form.has_discount ? __('Discount')+' - '+__('Yes') : __('Discount')+' - '+ __('No')"></label>
                        <p class="text-sm text-gray-500">{{ __('Provide direct discount to the plan.') }}</p>
                    </div>
                    <div class="cursor-pointer rounded-full relative shadow-sm">
                        <InputSwitch id="has_discount" v-model="form.has_discount" />
                    </div>
                </div>
            </div>

            <!-- Discounted Price -->
            <div v-if="form.has_discount" class="w-full flex flex-col mb-6">
                <label for="discount_percentage" class="pb-2 font-semibold text-gray-800">{{ __('Discount Percentage') }}<span class="ml-1 text-red-400">*</span></label>
                <InputNumber id="discount_percentage" v-model="form.discount_percentage" aria-describedby="discount_percentage-help" :class="[errors.discount_percentage ? 'p-invalid' : '']"/>
                <small id="discount_percentage-help" v-if="errors.discount_percentage" class="p-invalid">{{ errors.discount_percentage }}</small>
            </div>

            <!-- Features Switch -->
            <div class="w-full">
                <div class="flex justify-between items-center mb-8">
                    <div class="w-9/12">
                        <label for="feature_restrictions" class="font-semibold text-gray-800 pb-1" v-html="form.feature_restrictions ? __('Feature Access')+' - '+__('Restricted') : __('Feature Access')+' - '+ __('Unlimited')"></label>
                        <p class="text-sm text-gray-500">{{ __('Unlimited') }} ({{ __('Access to all features') }}). {{ __('Restricted') }} ({{ __('Access to selected features only') }}).</p>
                    </div>
                    <div class="cursor-pointer rounded-full relative shadow-sm">
                        <InputSwitch id="feature_restrictions" v-model="form.feature_restrictions" />
                    </div>
                </div>
            </div>

            <!-- Features Dropdown -->
            <div v-if="form.feature_restrictions" class="w-full flex flex-col mb-6">
                <label for="features" class="pb-2 font-semibold text-gray-800">{{ __('Features') }}<span class="ml-1 text-red-400">*</span></label>
                <v-select multiple id="features" v-model="form.features" :options="features" :reduce="feature => feature.id" label="name" :placeholder="__('Select Features')"
                          :dir="$page.props.rtl ? 'rtl' : 'ltr'">
                    <template v-slot:no-options="{ search, searching }">
                        <template v-if="searching">{{ __('No results were found for this search') }}.</template>
                        <em v-else class="opacity-50">{{ __('Start typing to search') }}.</em>
                    </template>
                </v-select>
                <small id="users-help" v-if="errors.features" class="p-invalid">{{ errors.features }}</small>
            </div>

            <!-- Description -->
            <div class="w-full flex flex-col mb-6">
                <label for="description" class="pb-2 font-semibold text-gray-800">{{ __('Short Description') }} (Max. 200 Characters)</label>
                <Textarea id="description" v-model="form.description" :class="[errors.description ? 'p-invalid' : '']"></Textarea>
                <small id="description-help" v-if="errors.description" class="p-invalid">{{ errors.description }}</small>
            </div>

            <!-- Sort Order -->
            <div class="w-full flex flex-col mb-6">
                <label for="sort_order" class="pb-2 font-semibold text-gray-800">{{ __('Sort Order') }}<span class="ml-1 text-red-400">*</span></label>
                <InputNumber id="sort_order" v-model="form.sort_order" aria-describedby="sort_order-help" :class="[errors.sort_order ? 'p-invalid' : '']"/>
                <small id="sort_order-help" v-if="errors.sort_order" class="p-invalid">{{ errors.sort_order }}</small>
            </div>

            <!-- Popular Switch -->
            <div class="w-full">
                <div class="flex justify-between items-center mb-8">
                    <div class="w-9/12">
                        <label for="is_popular" class="font-semibold text-gray-800 pb-1" v-html="form.is_active ? __('Popular')+' - '+__('Yes') : __('Popular')+' - '+ __('No')"></label>
                        <p class="text-sm text-gray-500">{{ __('Yes') }} ({{ __('Shown as Most Popular') }})</p>
                    </div>
                    <div class="cursor-pointer rounded-full relative shadow-sm">
                        <InputSwitch id="is_popular" v-model="form.is_popular" />
                    </div>
                </div>
            </div>

            <!-- Is Active Switch -->
            <div class="w-full">
                <div class="flex justify-between items-center mb-8">
                    <div class="w-9/12">
                        <label for="is_active" class="font-semibold text-gray-800 pb-1" v-html="form.is_active ? __('Status')+' - '+__('Active') : __('Status')+' - '+ __('In-active')"></label>
                        <p class="text-sm text-gray-500">{{ __('Active') }} ({{ __('Shown Everywhere') }}). {{ __('In-active') }} ({{ __('Hidden Everywhere') }}).</p>
                    </div>
                    <div class="cursor-pointer rounded-full relative shadow-sm">
                        <InputSwitch id="is_active" v-model="form.is_active" />
                    </div>
                </div>
            </div>

            <!-- Submit Button -->
            <div class="w-full flex">
                <Button type="submit" :label="editFlag ? __('Update') : __('Create')" />
            </div>
        </form>
    </div>
</template>
<script>
    import InputText from 'primevue/inputtext';
    import InputNumber from 'primevue/inputnumber';
    import Button from 'primevue/button';
    import InputSwitch from 'primevue/inputswitch';
    import TextEditor from "@/Components/TextEditor";
    import Textarea from 'primevue/textarea';
    import FormInputShimmer from "@/Components/Shimmers/FormInputShimmer";
    import FormSwitchShimmer from "@/Components/Shimmers/FormSwitchShimmer";
    import vSelect from "vue-select";
    export default {
        name: 'PlanForm',
        components: {
            InputText,
            InputNumber,
            Button,
            InputSwitch,
            TextEditor,
            Textarea,
            FormInputShimmer,
            FormSwitchShimmer,
            vSelect
        },
        props: {
            editFlag: Boolean,
            planId: Number,
            formErrors: Object,
            features: Array,
            subCategories: Array,
            title: ''
        },
        data() {
            return {
                errors: {},
                editorUrl: window.CKEditorURL,
                form: {
                    name: '',
                    description: '',
                    category_type: "App\\Models\\SubCategory",
                    category_id: null,
                    duration: 1,
                    price: 0,
                    has_discount: false,
                    discount_percentage: 0,
                    sort_order: 1,
                    feature_restrictions: false,
                    is_popular: false,
                    is_active: true,
                    features: []
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
                this.$inertia.post(route('plans.store'), this.form, {
                    onSuccess: () => {
                        if (Object.keys(this.errors).length === 0) {
                            this.$emit('close', true);
                        }
                    },
                });
            },
            update() {
                this.formValidated = true;
                this.$inertia.patch(route('plans.update', { id: this.planId }), this.form, {
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
                    axios.get(route('plans.edit', { id: this.planId }))
                        .then(function (response) {
                            let data = response.data.plan;
                            _this.form.name = data.name;
                            _this.form.description = data.description;
                            _this.form.category_id = data.category_id;
                            _this.form.duration = data.duration;
                            _this.form.price = data.price;
                            _this.form.has_discount = data.has_discount;
                            _this.form.discount_percentage = data.discount_percentage;
                            _this.form.sort_order = data.sort_order;
                            _this.form.feature_restrictions = data.feature_restrictions;
                            _this.form.is_popular = data.is_popular;
                            _this.form.is_active = data.is_active;

                            _this.form.features = response.data.features;
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
