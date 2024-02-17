<template>
    <div class="q-data rounded bg-yellow-50 border border-yellow-200 p-6">
        <h4 class="font-semibold text-gray-600 mb-4 uppercase">{{ __('Solution') }}</h4>
        <div v-if="question.solution_video">
            <video-attachment :reference="'player_'+question.code" :options="question.solution_video" :show-message="false"></video-attachment>
        </div>
        <div v-html="question.solution"></div>
    </div>
</template>
<script>
    import VideoAttachment from "@/Components/Questions/Attachments/VideoAttachment";

    export default {
        name: 'PracticeSolutionCard',
        components: {
            VideoAttachment
        },
        props: {
            question: Object,
        },
        created() {
            this.$nextTick(function() {
                window.renderMathInElement(this.$el);
            });
        }
    }
</script>
