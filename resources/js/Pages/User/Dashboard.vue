<template>
    <app-layout>
        <template #header>
            <h1 class="app-heading">{{ __('Dashboard') }}</h1>
        </template>

        <div class="py-6">
            <div class="w-full gap-4 md:gap-6 flex flex-col flex-col-reverse md:flex-row">

                <div class="w-full md:w-1/3">
                    <div class="text-2xl">👋 Welcome User,</div>
                </div>
            </div>
        </div>
    </app-layout>
</template>

<script>
import AppLayout from '@/Layouts/AppLayout'
import SubCategoryCard from "@/Components/Cards/SubCategoryCard";
import PracticeSessionCard from "@/Components/Cards/PracticeSessionCard";
import QuizScheduleCard from "@/Components/Cards/QuizScheduleCard";
import EmptyStudentCard from "@/Components/Cards/EmptyStudentCard";
import SectionHeader from "@/Components/SectionHeader";
import PopoverRow from 'v-calendar/lib/components/popover-row.umd.min'

export default {
    components: {
        AppLayout,
        SubCategoryCard,
        PracticeSessionCard,
        QuizScheduleCard,
        EmptyStudentCard,
        SectionHeader,
        PopoverRow
    },
    props: {
        practiceSessions: Array,
        quizSchedules: Array,
        minDate: String,
        maxDate: String,
        scheduleCalendar: Array,
    },
    data() {
        return {
            attrs: this.scheduleCalendar,
        }
    },
    metaInfo() {
        return {
            title: this.title
        }
    },
    computed: {
        title() {
            return this.__('User Dashboard') + ' - ' + this.$page.props.general.app_name;
        },
        calendarRows() {
            return this.$page.props.isMobile ? 1 : 2;
        }
    },
}
</script>
<style scoped>
.vc-container {
    border: 0 !important;
}
</style>
