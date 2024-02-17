<template>
    <div class="overflow-y-auto h-screen px-2">
        <div class="bg-gray-100 py-4 lg:py-4 rounded">
            <div class="container px-6 mx-auto flex ltr:flex-row rtl:flex-row-reverse">
                <div>
                    <h4 class="text-base font-semibold leading-tight text-gray-800">
                        {{ title }}
                    </h4>
                </div>
            </div>
        </div>
        <div v-if="loading" class="my-6 w-11/12 mx-auto xl:w-full xl:mx-0">
            <form-input-shimmer></form-input-shimmer>
            <form-input-shimmer></form-input-shimmer>
            <form-input-shimmer></form-input-shimmer>
        </div>
        <div v-else class="mt-6 w-11/12 mx-auto xl:w-full xl:mx-0">
            <div class="grid grid-cols-1 gap-4 flex-wrap">
                <template v-if="question.question_type === 'MSA'">
                    <MSAPreview :question="question"></MSAPreview>
                </template>
                <template v-if="question.question_type === 'MMA'">
                    <MMAPreview :question="question"></MMAPreview>
                </template>
                <template v-if="question.question_type === 'TOF'">
                    <TOFPreview :question="question"></TOFPreview>
                </template>
                <template v-if="question.question_type === 'FIB'">
                    <FIBPreview :question="question"></FIBPreview>
                </template>
                <template v-if="question.question_type === 'MTF'">
                    <MTFPreview :question="question"></MTFPreview>
                </template>
                <template v-if="question.question_type === 'ORD'">
                    <ORDPreview :question="question"></ORDPreview>
                </template>
                <template v-if="question.question_type === 'SAQ'">
                    <SAQPreview :question="question"></SAQPreview>
                </template>
            </div>
        </div>
    </div>
</template>
<script>
    import FormInputShimmer from "@/Components/Shimmers/FormInputShimmer";
    import ArcLabel from "@/Components/Label";
    import ArcInputError from "@/Components/InputError";
    import ArcButton from "@/Components/Button";
    import TOFPreview from "@/Components/Questions/Previews/TOFPreview";
    import LAQPreview from "@/Components/Questions/Previews/LAQPreview";
    import SAQPreview from "@/Components/Questions/Previews/SAQPreview";
    import ORDPreview from "@/Components/Questions/Previews/ORDPreview";
    import MTFPreview from "@/Components/Questions/Previews/MTFPreview";
    import FIBPreview from "@/Components/Questions/Previews/FIBPreview";
    import MMAPreview from "@/Components/Questions/Previews/MMAPreview";
    import MSAPreview from "@/Components/Questions/Previews/MSAPreview";
    export default {
        name: 'QuestionPreview',
        components: {
            FormInputShimmer,
            ArcLabel,
            ArcInputError,
            ArcButton,
            TOFPreview,
            LAQPreview,
            SAQPreview,
            ORDPreview,
            MTFPreview,
            FIBPreview,
            MMAPreview,
            MSAPreview,
        },
        props: {
            questionId: Number,
            errors: Object,
            title: ''
        },
        data() {
            return {
                question: Object,
                loading: false,
            }
        },
        methods: {
            fetch() {
                let _this = this;
                _this.loading = true;
                axios.get(route('questions.show', { id: this.questionId }))
                    .then(function (response) {
                        _this.question = response.data;
                    })
                    .catch(function (error) {
                        _this.loading = false;
                    })
                    .then(function () {
                        _this.loading = false;
                    });
            }
        },
        mounted() {
            this.fetch();
        }
    }
</script>
