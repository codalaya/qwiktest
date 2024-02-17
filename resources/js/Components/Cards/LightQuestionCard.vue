<template>
    <div class="w-full overflow-hidden dark_question_card rounded cursor-pointer mb-1">
        <div :class="[active ? 'bg-gray-200': 'text-gray-600']" class="hover:bg-gray-200 rounded p-4">
            <div class="flex items-start gap-4">
                <question-chip v-tooltip.right="questionStatus" :sno="sno" :status="chipStatus" :is-active="active"></question-chip>
                <div class="leading-relaxed text-sm" v-html="question.question"></div>
            </div>
        </div>
    </div>
</template>
<script>
    import QuestionChip from "@/Components/Buttons/QuestionChip";
    import Tooltip from 'primevue/tooltip';
    export default {
        name: 'LightQuestionCard',
        components: {
            QuestionChip
        },
        directives: {
            'tooltip': Tooltip
        },
        props: {
            question: Object,
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
                } else {
                    return 'Not Visited';
                }
            },
            chipStatus() {
                if(this.status === 'answered') {
                    return 'success';
                } else if(this.status === 'not_answered') {
                    return 'danger'
                } else {
                    return 'default';
                }
            }
        },
        created() {
            this.$nextTick(function() {
                window.renderMathInElement(this.$el);
            });
        }
    }
</script>
