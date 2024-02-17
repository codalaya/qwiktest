<template>
    <app-layout>
        <template #header>
            <div class="flex items-center">
                <back-button />
                <h1 class="app-heading">{{ __('Practice') }} {{ skill.name }}</h1>
            </div>
        </template>

        <template #actions>
            <div class="uppercase font-semibold text-secondary">{{ pagination.total }} {{ __('Practice Sets') }}</div>
        </template>

        <div class="py-8">
            <div class="flex flex-col justify-center items-center">
                <div class="w-full">
                    <div v-if="loading" class="grid grid-cols-1 sm:grid-cols-2 gap-4 auto-rows-auto justify-center">
                        <practice-set-card-shimmer></practice-set-card-shimmer>
                        <practice-set-card-shimmer></practice-set-card-shimmer>
                        <practice-set-card-shimmer></practice-set-card-shimmer>
                        <practice-set-card-shimmer></practice-set-card-shimmer>
                    </div>
                    <div v-else class="grid grid-cols-1 sm:grid-cols-2 gap-4 auto-rows-auto justify-center mb-6">
                        <template v-for="(practiceSet, index) in practiceSets">
                            <practice-set-card :practice-set="practiceSet">
                                <template #action>
                                    <button @click="showSubscribeModal" v-if="practiceSet.paid && !subscription" class="qt-btn qt-btn-sm bg-gray-300 inline-flex items-center">
                                        <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 11V7a4 4 0 118 0m-4 8v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2z"></path></svg>
                                        <span>{{ __('Unlock') }}</span>
                                    </button>
                                    <inertia-link v-else :href="route('init_practice_set', {slug: practiceSet.slug})">
                                        <div class="qt-btn qt-btn-sm qt-btn-primary">{{ __('Start Practice') }}</div>
                                    </inertia-link>
                                </template>
                            </practice-set-card>
                        </template>
                    </div>
                    <div class="mb-6" v-if="!loading && practiceSets.length === 0" >
                        <empty-student-card :title="'No practice tests found in this Skill'"></empty-student-card>
                    </div>
                    <div v-if="!loading && pagination && !(practiceSets.length === pagination.total)" class="flex justify-center items-center">
                        <button @click="loadMoreSets" class="qt-btn qt-btn-success flex items-center justify-center">
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
    import PracticeSetCard from "@/Components/Cards/PracticeSetCard";
    import EmptyStudentCard from "@/Components/Cards/EmptyStudentCard";
    import PracticeSetCardShimmer from "@/Components/Shimmers/PracticeSetCardShimmer";
    import BackButton from "@/Components/BackButton";
    export default {
        components: {
            AppLayout,
            PracticeSetCard,
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
                practiceSets: [],
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
            fetchSets() {
                let _this = this;
                _this.loading = true;
                axios.get(route('fetch_practice_sets', {
                    category: _this.category.slug,
                    section: _this.section.slug,
                    skill: _this.skill.slug
                })).then(function (response) {
                        let data = response.data.sets;
                        _this.practiceSets = data.data;
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
            loadMoreSets() {
                let _this = this;
                _this.paginationLoading = true;
                axios.get(this.pagination.links.next)
                    .then(function (response) {
                        let data = response.data.sets.data;
                        _this.pagination = response.data.sets.meta.pagination;
                        data.forEach((item) => _this.practiceSets.push(item));
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

        computed: {
            title() {
                return this.skill.name + ' '+this.__('Practice Sets')+' - ' + this.$page.props.general.app_name;
            },
            subTitle() {
                return this.practiceSets.length > 0 ? this.practiceSets.length + ' Practice Sets in this Section.' : 'No Practice Sets in this Section.'
            }
        },

        created() {
            this.fetchSets();
        }
    }
</script>
