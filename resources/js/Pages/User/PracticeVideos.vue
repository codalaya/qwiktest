<template>
    <app-layout>
        <template #header>
            <div class="flex items-center">
                <back-button />
                <h1 class="app-heading">{{ skill.name }} {{ __('Videos') }}</h1>
            </div>
        </template>

        <template #actions>
            <div class="uppercase font-semibold text-secondary">{{ pagination.total }} {{ __('Videos') }}</div>
        </template>

        <div class="py-8">
            <div class="flex flex-col justify-center items-center">
                <div class="w-full overflow-hidden">
                    <ul v-if="loading" role="list" class="grid grid-cols-1 gap-6 sm:grid-cols-2 md:grid-cols-3">
                        <li><practice-set-card-shimmer></practice-set-card-shimmer></li>
                        <li><practice-set-card-shimmer></practice-set-card-shimmer></li>
                        <li><practice-set-card-shimmer></practice-set-card-shimmer></li>
                    </ul>
                    <ul v-else role="list" class="grid grid-cols-1 gap-4 sm:grid-cols-2 md:grid-cols-3">
                        <li v-for="(video, index) in videos">
                            <button @click="showSubscribeModal" v-if="video.paid && !subscription" class="w-full focus:outline-none">
                                <practice-video-card :video="video" :sno="getVideoNo(index)" :subscription="subscription"></practice-video-card>
                            </button>
                            <inertia-link v-else :href="route('watch_videos', {category: category.slug, section: section.slug, skill: skill.slug, start: index})">
                                <practice-video-card :video="video" :sno="getVideoNo(index)" :subscription="subscription"></practice-video-card>
                            </inertia-link>
                        </li>
                    </ul>
                    <div class="my-6" v-if="!loading && videos.length === 0" >
                        <empty-student-card :title="'No videos found in this skill'"></empty-student-card>
                    </div>
                </div>
                <div v-if="!loading && pagination && !(videos.length === pagination.total)" class="flex justify-center items-center my-4">
                    <button @click="loadMoreVideos" class="qt-btn qt-btn-success flex items-center justify-center">
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
    import PracticeVideoCard from "@/Components/Cards/PracticeVideoCard";
    import EmptyStudentCard from "@/Components/Cards/EmptyStudentCard";
    import PracticeSetCardShimmer from "@/Components/Shimmers/PracticeSetCardShimmer";
    import BackButton from "@/Components/BackButton";
    export default {
        components: {
            AppLayout,
            PracticeVideoCard,
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
                videos: [],
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
            fetchVideos() {
                let _this = this;
                _this.loading = true;
                axios.get(route('fetch_practice_videos', {
                    category: _this.category.slug,
                    section: _this.section.slug,
                    skill: _this.skill.slug
                })).then(function (response) {
                        _this.videos = response.data.videos;
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
            loadMoreVideos() {
                let _this = this;
                _this.paginationLoading = true;
                axios.get(this.pagination.links.next)
                    .then(function (response) {
                        let data = response.data.videos;
                        _this.pagination = response.data.pagination;
                        data.forEach((item) => _this.videos.push(item));
                        _this.paginationLoading = false;
                    })
                    .catch(function (error) {
                        _this.paginationLoading = false;
                    });
            },
            getVideoNo(index) {
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
                return this.skill.name + ' '+this.__('Videos')+' - ' + this.$page.props.general.app_name;
            },
            subTitle() {
                return this.videos.length > 0 ? this.videos.length + ' Videos in this Skill.' : 'No Videos in this Skill.'
            }
        },

        created() {
            this.fetchVideos();
        }
    }
</script>
