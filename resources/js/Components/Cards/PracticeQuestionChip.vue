<template>
    <div v-tooltip.top="questionStatus" class="w-full overflow-hidden rounded-sm cursor-pointer">
        <question-chip :sno="sno" :status="chipStatus" :is-active="active"></question-chip>
    </div>
</template>
<script>
    import QuestionChip from "@/Components/Buttons/QuestionChip";
    import Tooltip from 'primevue/tooltip';
    export default {
        name: 'PracticeQuestionChip',
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
                    return this.is_correct ? 'Correct Answer': 'Wrong Answer';
                } else {
                    return 'Not Answered';
                }
            },
            chipStatus() {
                if(this.status === 'answered') {
                    return this.is_correct ? 'success': 'danger';
                } else {
                    return 'default';
                }
            }
        }
    }
</script>
