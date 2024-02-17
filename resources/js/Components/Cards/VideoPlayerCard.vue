<template>
    <div class="card flex flex-col overflow-hidden">
        <div v-if="video.paid && !subscription" class="card-body w-full bg-gray-50 flex flex-col justify-center items-center">
            <content-locked class="py-12 sm:py-24"></content-locked>
        </div>
        <div v-else class="w-full">
            <div v-if="video.type === 'mp4'">
                <vue-plyr :ref="reference" :options="plyrOptions">
                    <video :src="video.link">
                        <source :src="video.link" type="video/mp4">
                    </video>
                </vue-plyr>
            </div>
            <div v-if="video.type === 'youtube'">
                <vue-plyr :ref="reference" :options="plyrOptions">
                    <div class="plyr__video-embed">
                        <iframe :src="getVideoLink" allowfullscreen allowtransparency allow="autoplay"></iframe>
                    </div>
                </vue-plyr>
            </div>
            <div v-if="video.type === 'vimeo'">
                <vue-plyr :ref="reference">
                    <div class="plyr__video-embed">
                        <iframe :src="getVideoLink"></iframe>
                    </div>
                </vue-plyr>
            </div>
        </div>
        <div class="card-body">
            <h4 class="text-lg font-semibold mb-4">{{ video.title }}</h4>
            <div v-if="video.description" v-html="video.description" class="max-w-full prose"></div>
            <div v-else class="text-sm text-gray-400">{{ __('No description found') }}</div>
        </div>
    </div>
</template>
<script>
    import VuePlyr from 'vue-plyr';
    import ContentLocked from "@/Components/Cards/ContentLocked";
    export default {
        name: 'VideoPlayerCard',
        components: {
            VuePlyr,
            ContentLocked
        },
        props: {
            reference: String,
            video: Object,
            subscription: {
                type: Boolean,
                default: false,
            },
        },
        data() {
            return {
                plyrOptions: {
                    controls: ['play-large', 'play', 'progress', 'current-time', 'mute', 'volume', 'captions', 'settings', 'airplay', 'fullscreen'],
                    speed: { selected: 1, options: [0.5,1,1.25] }
                },
            }
        },
        computed: {
            getVideoLink() {
                if(this.video.type === 'youtube') {
                    return "https://www.youtube.com/embed/"+this.video.link+"?amp;iv_load_policy=3&amp;modestbranding=1&amp;playsinline=1&amp;showinfo=0&amp;rel=0&amp;enablejsapi=1";
                }
                if(this.options.video.type === 'vimeo') {
                    return "https://player.vimeo.com/video/"+this.video.link+"?loop=false&amp;byline=false&amp;portrait=false&amp;title=false&amp;speed=true&amp;transparent=0&amp;gesture=media"
                }
                return "";
            }
        },
        created() {
            this.$nextTick(function() {
                window.renderMathInElement(this.$el);
            });
        },
    }
</script>
