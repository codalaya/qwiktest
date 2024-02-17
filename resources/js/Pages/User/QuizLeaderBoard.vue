<template>
    <app-layout>
        <template #header>
            <div class="flex items-center">
                <back-button />
                <h1 class="app-heading">{{ quiz.title }} {{ __('Leaderboard') }}</h1>
            </div>
        </template>

        <div class="w-full mt-8">
            <progress-navigator :steps="steps"></progress-navigator>
        </div>

        <div class="py-8">
            <div>
                <div class="w-full bg-white dark:bg-gray-800 rounded shadow overflow-hidden">
                    <table class="w-full ">
                        <tr>
                            <th class="border ltr:text-left rtl:text-right text-sm px-8 py-4">{{ __('#') }}</th>
                            <th class="border ltr:text-left rtl:text-right text-sm px-8 py-4">{{ __('Test Taker') }}</th>
                            <th class="border ltr:text-left rtl:text-right text-sm px-8 py-4">{{ __('High Score') }}</th>
                        </tr>
                        <tr v-for="(scorer, index) in topScorers" :key="'scorer'+scorer.id">
                            <td class="border px-8 py-2">
                                <span class="text-sm">{{ index+1 }}</span>
                            </td>
                            <td class="border px-8 py-2">
                                <span class="text-sm">{{ scorer.name }}</span>
                                <span v-if="scorer.id === currentUserId" class="ml-2 text-sm bg-green-100 text-green-500 rounded-sm px-2 py-1">{{ __('You') }}</span>
                            </td>
                            <td class="border px-8 py-2">
                                <span class="text-sm">{{ scorer.high_score }}</span>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    import RewardsBadge from "@/Components/RewardsBadge";
    import BackButton from "@/Components/BackButton";
    import ProgressNavigator from "@/Components/Stepper/ProgressNavigator";

    export default {
        components: {
            AppLayout,
            RewardsBadge,
            BackButton,
            ProgressNavigator
        },
        props: {
            quiz: Object,
            session: Object,
            topScorers: Array,
            steps: Array,
        },
        data() {
            return {
                loading: false,
            }
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        computed: {
            title() {
                return this.quiz.title + ' '+this.__('Leaderboard')+' - ' + this.$page.props.general.app_name;
            },
            currentUserId() {
                return this.$page.props.user.id;
            }
        }
    }
</script>
