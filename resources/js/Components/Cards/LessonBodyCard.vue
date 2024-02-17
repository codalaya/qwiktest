<template>
    <div class="card flex flex-col">
        <div v-if="lesson.paid && !subscription" class="card-body w-full bg-gray-50 flex flex-col justify-center items-center">
            <content-locked class="py-12 sm:py-24"></content-locked>
        </div>
        <div v-else class="card-body w-full flex flex-col justify-start items-start">
            <h4 class="text-lg font-semibold mb-4">{{ lesson.title }}</h4>
            <div v-html="lesson.body" class="max-w-full prose"></div>
        </div>
    </div>
</template>
<script>
    import ContentLocked from "@/Components/Cards/ContentLocked";

    export default {
        name: 'LessonBodyCard',
        components: {
            ContentLocked
        },
        props: {
            lesson: Object,
            subscription: {
                type: Boolean,
                default: false,
            },
        },
        created() {
            this.$nextTick(function() {
                window.renderMathInElement(this.$el);
            });
        }
    }
</script>
