<template>
    <div v-tooltip.top="questionStatus" class="w-full overflow-hidden rounded-sm cursor-pointer">
        <question-chip :sno="sno" :status="chipStatus" :is-active="active"></question-chip>
    </div>
</template>
<script>
    import QuestionChip from "@/Components/Buttons/QuestionChip";
    import Tooltip from 'primevue/tooltip';
    export default {
        name: 'ExamQuestionChip',
        components: {
            QuestionChip
        },
        directives: {
            'tooltip': Tooltip
        },
        props: {
            sno: Number,
            active: Boolean,
            is_correct: Boolean,
            status: String,
        },
        computed: {
            questionStatus() {
                if(this.status === 'answered') {
                    return 'Answered';
                } else if(this.status === 'not_answered') {
                    return 'Not Answered'
                } else if(this.status === 'mark_for_review') {
                    return 'Marked for Review'
                } else if(this.status === 'answered_mark_for_review') {
                    return 'Answered & Marked for Review'
                } else if(this.status === 'touched') {
                    return 'Answered & Not Saved'
                } else {
                    return 'Not Visited';
                }
            },
            chipStatus() {
                if(this.status === 'answered') {
                    return 'success';
                } else if(this.status === 'not_answered') {
                    return 'danger'
                } else if(this.status === 'mark_for_review') {
                    return 'warning'
                } else if(this.status === 'answered_mark_for_review') {
                    return 'caution'
                } else {
                    return 'default';
                }
            }
        }
    }
</script>
