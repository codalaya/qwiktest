<template>
    <practice-layout>
        <!-- Side Title -->
        <template #title>
            <h4 class="font-semibold text-white">{{ skill.name }} {{ __('Videos') }} <br><span class="text-xs font-normal">{{ category.name }} {{ section.name }}</span></h4>
        </template>

        <template #questions v-slot:default="slotProps">
            <ul v-if="loading">
                <li>
                    <NavigationQuestionCardShimmer></NavigationQuestionCardShimmer>
                </li>
                <li>
                    <NavigationQuestionCardShimmer></NavigationQuestionCardShimmer>
                </li>
                <li>
                    <NavigationQuestionCardShimmer></NavigationQuestionCardShimmer>
                </li>
                <li>
                    <NavigationQuestionCardShimmer></NavigationQuestionCardShimmer>
                </li>
            </ul>
            <ul v-else class="my-4">
                <li v-for="(video, index) in videos" :key="video.code" @click="jumpToVideo(index)">
                    <dark-video-card :video="video" :sno="getVideoNo(index)" :active="current_video === index"></dark-video-card>
                </li>
            </ul>
        </template>

        <template #footer>
            <ul v-if="!loading" class="w-full h-16 flex items-center justify-between bg-gray-800">
                <li class="text-gray-400 hover:text-white cursor-pointer" @click="prevPage">
                    <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                         xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M11 15l-3-3m0 0l3-3m-3 3h8M3 12a9 9 0 1118 0 9 9 0 01-18 0z"></path>
                    </svg>
                </li>
                <li>
                    <span class="text-white">{{ __('Page') }} {{ pagination.current_page }}/{{ pagination.total_pages }}</span>
                </li>
                <li class="text-gray-400 hover:text-white cursor-pointer" @click="nextPage">
                    <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                         xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M13 9l3 3m0 0l-3 3m3-3H8m13 0a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                </li>
            </ul>
        </template>

        <div class="w-full border-b border-gray-200 h-16 fixed sm:absolute z-30 top-0 right-0 mx-auto bg-white">
            <div class="w-full sm:max-w-7xl h-full mx-auto px-4 sm:px-6 lg:px-8">
                <div v-if="!loading" class="h-full flex flex-col justify-center items-center">
                    <div class="w-full sm:w-2/3 flex ltr:flex-row rtl:flex-row-reverse items-center ltr:justify-end rtl:justify-start gap-4 sm:gap-0 sm:ltr:justify-between sm:rtl:justify-between">
                        <h4 class="page-heading ml-8 sm:ml-0">{{ videoTitle }}</h4>
                        <button @click="exitVideos" class="focus:outline-none">
                            <exit-button :name="__('Exit')"></exit-button>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <perfect-scrollbar class="bg-gray-100 h-screen max-h-screen pt-16 pb-16" ref="videoScroll" :options="scrollbarOptions">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex flex-col justify-center items-center">
                    <div class="w-full py-4 sm:w-2/3" v-if="loading">
                        <div class="card card-body">
                            <PracticeQuestionShimmer class="w-full"></PracticeQuestionShimmer>
                        </div>
                    </div>
                    <div v-else class="w-full py-4 sm:w-2/3">
                        <div v-for="(video, index) in videos" :key="video.code">
                            <video-player-card v-show="current_video === index" :ref="'player_'+video.code" :reference="'player'"
                                               :video="video" :subscription="subscription"></video-player-card>
                        </div>
                    </div>
                </div>
            </div>
        </perfect-scrollbar>
        <div class="w-full border-t border-gray-200 h-16 fixed sm:absolute z-30 bottom-0 right-0 mx-auto bg-white">
            <div class="w-full sm:max-w-7xl h-full mx-auto px-4 sm:px-6 lg:px-8">
                <div v-if="!loading" class="h-full flex flex-col justify-center items-center">
                    <div class="w-full sm:w-2/3 flex items-center justify-between">
                        <button class="focus:outline-none" @click="prevVideo">
                            <prev-button :name="__('Previous')"></prev-button>
                        </button>
                        <button class="focus:outline-none" @click="nextVideo">
                            <next-button :name="__('Next')"></next-button>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <ConfirmDialog></ConfirmDialog>
    </practice-layout>
</template>

<script>
    import PracticeLayout from '@/Layouts/PracticeLayout'
    import NavigationQuestionCardShimmer from "@/Components/Shimmers/NavigationQuestionCardShimmer";
    import PracticeQuestionShimmer from "@/Components/Shimmers/PracticeQuestionShimmer";
    import PrevButton from "@/Components/Buttons/PrevButton";
    import NextButton from "@/Components/Buttons/NextButton";
    import SubmitButton from "@/Components/Buttons/SubmitButton";
    import ExitButton from "@/Components/Buttons/ExitButton";
    import PracticeSolutionCard from "@/Components/Cards/PracticeSolutionCard";
    import RewardsBadge from "@/Components/RewardsBadge";
    import {PerfectScrollbar} from "vue2-perfect-scrollbar";
    import ConfirmDialog from "primevue/confirmdialog";
    import VideoPlayerCard from "@/Components/Cards/VideoPlayerCard";
    import DarkVideoCard from "@/Components/Cards/DarkVideoCard";
    import ContentLocked from "@/Components/Cards/ContentLocked";

    export default {
        components: {
            PracticeLayout,
            ContentLocked,
            NavigationQuestionCardShimmer,
            PracticeQuestionShimmer,
            PrevButton,
            NextButton,
            SubmitButton,
            ExitButton,
            PracticeSolutionCard,
            PerfectScrollbar,
            RewardsBadge,
            ConfirmDialog,
            VideoPlayerCard,
            DarkVideoCard
        },
        props: {
            category: Object,
            section: Object,
            skill: Object,
            currentPage: Number,
            videoIndex: Number,
            subscription: {
                type: Boolean,
                default: false,
            }
        },
        data() {
            return {
                videos: [],
                pagination: null,
                read: 0,
                loading: true,
                submitting: false,
                current_video: this.videoIndex,
                scrollbarOptions: {
                    suppressScrollX: true
                },
            }
        },
        methods: {
            exitVideos() {
                window.history.back();
            },
            prevVideo() {
                this.stopPlayer();
                if (this.current_video !== 0) {
                    this.current_video--;
                } else {
                    this.prevPage();
                }
            },
            nextVideo() {
                this.stopPlayer();
                if (this.current_video < this.videos.length - 1) {
                    this.current_video++;
                } else {
                    if (this.current_video < this.video.total_videos - 1) {
                        this.nextPage();
                    }
                }
            },
            jumpToVideo(videoID) {
                this.stopPlayer();
                this.current_video = videoID;
            },
            prevPage() {
                if (this.pagination.current_page !== 1) {
                    this.current_video = 0;
                    this.fetchVideos(this.pagination.current_page - 1);
                }
            },
            nextPage() {
                if (this.pagination.current_page < this.pagination.total_pages) {
                    this.current_video = 0;
                    this.fetchVideos(this.pagination.current_page + 1);
                }
            },
            fetchVideos(page) {
                let _this = this;
                _this.loading = true;
                axios.get(route('fetch_practice_videos', {
                    category: this.category.slug,
                    section: this.section.slug,
                    skill: this.skill.slug,
                    page: page,
                    withBody: true
                }))
                    .then(function (response) {
                        let data = response.data;
                        _this.videos = data.videos;
                        _this.pagination = data.pagination;
                    })
                    .catch(function (error) {
                        _this.loading = false;
                    })
                    .then(function () {
                        _this.loading = false;
                    });
            },
            getVideoNo(index) {
                return (index + 1) + (this.pagination.per_page * (this.pagination.current_page - 1));
            },
            stopPlayer() {
                let id = 'player_'+this.videos[this.current_video].code;
                if(this.$refs[id][0].$refs.player) {
                    this.$refs[id][0].$refs.player.player.stop();
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
                return this.skill.name + ' '+ this.__('Videos') +' - ' + this.$page.props.general.app_name;
            },
            appUrl() {
                return this.$page.props.appUrl;
            },
            videoTitle() {
                return this.videos.length > 0 ? this.__('Video')+' '+this.getVideoNo(this.current_video) + ': ' + this.videos[this.current_video].title : '';
            }
        },
        mounted() {
            document.addEventListener('contextmenu', event => event.preventDefault());
            this.fetchVideos(this.currentPage);
        }
    }
</script>
