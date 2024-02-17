<template>
    <app-layout>
        <template #header>
            <div class="flex items-center">
                <back-button />
                <h1 class="app-heading">{{ type.plural_name }}</h1>
            </div>
        </template>
        <template #actions>
            <div class="uppercase font-semibold text-secondary">{{ pagination.total }} {{ __('Exams') }}</div>
        </template>

        <div class="py-8">
            <div class="flex flex-col items-center">
                <div class="w-full">
                    <div v-if="loading" class="grid grid-cols-1 sm:grid-cols-2 gap-4 auto-rows-auto justify-center">
                        <quiz-card-shimmer></quiz-card-shimmer>
                        <quiz-card-shimmer></quiz-card-shimmer>
                        <quiz-card-shimmer></quiz-card-shimmer>
                        <quiz-card-shimmer></quiz-card-shimmer>
                    </div>
                    <div v-else class="grid grid-cols-1 sm:grid-cols-2 gap-4 mb-6">
                        <template v-for="(exam, index) in exams">
                            <exam-card :exam="exam" :subscription="subscription">
                                <template #action>
                                    <inertia-link v-if="exam.paid && (!subscription && exam.redeem)" :href="route('exam_instructions', {slug: exam.slug})">
                                        <span class="qt-btn qt-btn-sm qt-btn-primary">{{ __('Redeem with') }} {{ exam.redeem }}</span>
                                    </inertia-link>
                                    <button @click="showSubscribeModal" v-else-if="exam.paid && !subscription" class="qt-btn qt-btn-sm bg-gray-300 inline-flex items-center">
                                        <svg class="w-4 h-4 ltr:mr-1 rtl:ml-1" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 11V7a4 4 0 118 0m-4 8v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2z"></path></svg>
                                        <span>{{ __('Unlock') }}</span>
                                    </button>
                                    <inertia-link v-else :href="route('exam_instructions', {slug: exam.slug})">
                                        <span class="qt-btn qt-btn-sm qt-btn-primary">{{ __('Start Exam') }}</span>
                                    </inertia-link>
                                </template>
                            </exam-card>
                        </template>
                    </div>
                    <div class="mb-6" v-if="!loading && exams.length === 0" >
                        <empty-student-card :title="'No Exams Found'"></empty-student-card>
                    </div>
                    <div v-if="!loading && pagination && !(exams.length === pagination.total)" class="flex justify-center items-center">
                        <button @click="loadMoreExams" class="qt-btn qt-btn-success flex items-center justify-center">
                            <span v-if="paginationLoading" class="text-sm"><i class="pi pi-spin pi-spinner mr-2"></i> {{ __('Fetching') }}</span>
                            <span v-else>{{ __('Load More') }}</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    import ExamCard from "@/Components/Cards/ExamCard";
    import EmptyStudentCard from "@/Components/Cards/EmptyStudentCard";
    import QuizCardShimmer from "@/Components/Shimmers/QuizCardShimmer";
    import BackButton from "@/Components/BackButton";

    export default {
        components: {
            EmptyStudentCard,
            AppLayout,
            ExamCard,
            BackButton,
            QuizCardShimmer
        },
        props: {
            type: Object,
            subscription: {
                type: Boolean,
                default: false,
            },
        },
        data() {
            return {
                exams: Object,
                pagination: Object,
                debounce: null,
                loading: false,
                paginationLoading: false,
            }
        },
        methods: {
            fetchExams() {
                let _this = this;
                _this.loading = true;
                axios.get(route('fetch_exams_by_type', {type:  _this.type.slug})).then(function (response) {
                    let data = response.data.exams;
                    _this.exams = data.data;
                    _this.pagination = data.meta.pagination;
                    _this.loading = false;
                })
                    .catch(function (error) {
                        _this.loading = false;
                    })
                    .then(function () {
                        _this.loading = false;
                    });
            },
            loadMoreExams() {
                let _this = this;
                _this.paginationLoading = true;
                axios.get(this.pagination.links.next)
                    .then(function (response) {
                        let data = response.data.exams.data;
                        _this.pagination = response.data.exams.meta.pagination;
                        data.forEach((item) => _this.exams.push(item));
                        _this.paginationLoading = false;
                    })
                    .catch(function (error) {
                        _this.paginationLoading = false;
                    });
            },
            showSubscribeModal() {
                this.$swal({
                    title: '<strong>'+this.__('Subscribe to Access')+'</strong>',
                    icon: 'warning',
                    html: this.__('You don\'t have an active plan to see this content. Please subscribe.'),
                    showCloseButton: true,
                    showCancelButton: false,
                    focusConfirm: true,
                    confirmButtonText: this.__('See Pricing'),
                    confirmButtonAriaLabel: this.__('See Pricing'),
                }).then((result) => {
                    if (result.isConfirmed) {
                        this.goToPricing();
                    }
                });
            },
            goToPricing() {
                window.location.assign(route('pricing'));
            }
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        computed: {
            title() {
                return this.type.name + ' - ' + this.$page.props.general.app_name;
            }
        },
        mounted() {
            this.fetchExams()
        }
    }
</script>
