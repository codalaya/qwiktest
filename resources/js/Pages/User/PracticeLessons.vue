<template>
    <app-layout>
        <template #header>
            <div class="flex items-center">
                <back-button />
                <h1 class="app-heading">{{ skill.name }} {{ __('Lessons') }}</h1>
            </div>
        </template>

        <template #actions>
            <div class="uppercase font-semibold text-secondary">{{ pagination.total }} {{ __('Lessons') }}</div>
        </template>

        <div class="py-8">
            <div class="flex flex-col justify-center items-center">
                <div class="w-full card overflow-hidden">
                    <ul v-if="loading" role="list" class="divide-y divide-gray-200">
                        <li><practice-set-card-shimmer></practice-set-card-shimmer></li>
                        <li><practice-set-card-shimmer></practice-set-card-shimmer></li>
                        <li><practice-set-card-shimmer></practice-set-card-shimmer></li>
                        <li><practice-set-card-shimmer></practice-set-card-shimmer></li>
                    </ul>
                    <ul v-else role="list" class="divide-y divide-gray-200">
                        <li v-for="(lesson, index) in lessons">
                            <button @click="showSubscribeModal" v-if="lesson.paid && !subscription" class="w-full focus:outline-none">
                                <practice-lesson-card :lesson="lesson" :sno="getLessonNo(index)" :subscription="subscription"></practice-lesson-card>
                            </button>
                            <inertia-link v-else :href="route('read_lessons', {category: category.slug, section: section.slug, skill: skill.slug, start: index})" class="block hover:bg-gray-50">
                                <practice-lesson-card :lesson="lesson" :sno="getLessonNo(index)" :subscription="subscription"></practice-lesson-card>
                            </inertia-link>
                        </li>
                    </ul>
                    <div class="my-6" v-if="!loading && lessons.length === 0" >
                        <empty-student-card :title="'No lessons found in this skill'"></empty-student-card>
                    </div>
                </div>
                <div v-if="!loading && pagination && !(lessons.length === pagination.total)" class="flex justify-center items-center my-4">
                    <button @click="loadMoreLessons" class="qt-btn qt-btn-success flex items-center justify-center">
                        <span v-if="paginationLoading" class="text-sm"><i class="pi pi-spin pi-spinner mr-2"></i> {{ __('Fetching') }}</span>
                        <span v-else>{{ __('Load More') }}</span>
                    </button>
                </div>
            </div>
        </div>
    </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    import PracticeLessonCard from "@/Components/Cards/PracticeLessonCard";
    import EmptyStudentCard from "@/Components/Cards/EmptyStudentCard";
    import PracticeSetCardShimmer from "@/Components/Shimmers/PracticeSetCardShimmer";
    import BackButton from "@/Components/BackButton";
    export default {
        components: {
            AppLayout,
            PracticeLessonCard,
            EmptyStudentCard,
            PracticeSetCardShimmer,
            BackButton
        },
        props: {
            category: Object,
            section: Object,
            skill: Object,
            subscription: {
                type: Boolean,
                default: false,
            },
        },
        data() {
            return {
                lessons: [],
                pagination: {},
                debounce: null,
                loading: false,
                paginationLoading: false,
            }
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        methods: {
            fetchLessons() {
                let _this = this;
                _this.loading = true;
                axios.get(route('fetch_practice_lessons', {
                    category: _this.category.slug,
                    section: _this.section.slug,
                    skill: _this.skill.slug
                })).then(function (response) {
                        _this.lessons = response.data.lessons;
                        _this.pagination = response.data.pagination;
                        _this.loading = false;
                    })
                    .catch(function (error) {
                        _this.loading = false;
                    })
                    .then(function () {
                        _this.loading = false;
                    });
            },
            loadMoreLessons() {
                let _this = this;
                _this.paginationLoading = true;
                axios.get(this.pagination.links.next)
                    .then(function (response) {
                        let data = response.data.lessons;
                        _this.pagination = response.data.pagination;
                        data.forEach((item) => _this.lessons.push(item));
                        _this.paginationLoading = false;
                    })
                    .catch(function (error) {
                        _this.paginationLoading = false;
                    });
            },
            getLessonNo(index) {
                return (index + 1) + (this.pagination.per_page * (this.pagination.current_page - 1));
            },
            showSubscribeModal() {
                this.$swal({
                    title: '<strong>'+this.__('Subscribe to Access')+'</strong>',
                    icon: 'info',
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

        computed: {
            title() {
                return this.skill.name + ' '+this.__('Lessons')+' - ' + this.$page.props.general.app_name;
            },
            subTitle() {
                return this.lessons.length > 0 ? this.lessons.length + ' Lessons in this Skill.' : 'No Lessons in this Skill.'
            }
        },

        created() {
            this.fetchLessons();
        }
    }
</script>
