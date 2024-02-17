<template>
    <div class="bg-white">
        <div class="p-6 flex">
            <div class="w-full flex gap-4">
                <h3 class="text-xl text-secondary font-bold">{{ serial }}</h3>
                <div class="w-full flex flex-col">
                    <h4 class="text-lg font-semibold text-primary mb-3">{{ skill.name }}</h4>
                    <div class="flex flex-col sm:flex-row gap-4">
                        <div class="w-full sm:w-48 rounded shadow-inner border border-gray-200 group hover:bg-primary cursor-pointer">
                            <inertia-link :href="route('skill_videos', {category: categorySlug, section: sectionSlug, skill: skill.slug})">
                                <div class="card-body flex flex-col items-center gap-1">
                                    <svg class="w-6 h-6 text-gray-500 group-hover:text-white" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M0 0h24v24H0V0z" fill="none"/><path d="M4 6H2v14c0 1.1.9 2 2 2h14v-2H4V6zm16-4H8c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm0 14H8V4h12v12zM12 5.5v9l6-4.5z"/></svg>
                                    <span class="text-gray-500 group-hover:text-white">{{ skill.practice_videos_count === 0 ? 'No' : skill.practice_videos_count }} {{ __('Videos') }}</span>
                                </div>
                            </inertia-link>
                        </div>
                        <div class="w-full sm:w-48 rounded shadow-inner border border-gray-200 group hover:bg-primary cursor-pointer">
                            <inertia-link :href="route('skill_lessons', {category: categorySlug, section: sectionSlug, skill: skill.slug})">
                                <div class="card-body flex flex-col items-center gap-1">
                                    <svg class="w-6 h-6 text-gray-500 group-hover:text-white" xmlns="http://www.w3.org/2000/svg" enable-background="new 0 0 24 24" viewBox="0 0 24 24" fill="currentColor"><path d="M0,0h24v24H0V0z" fill="none"/><g><path d="M19.5,3.5L18,2l-1.5,1.5L15,2l-1.5,1.5L12,2l-1.5,1.5L9,2L7.5,3.5L6,2v14H3v3c0,1.66,1.34,3,3,3h12c1.66,0,3-1.34,3-3V2 L19.5,3.5z M15,20H6c-0.55,0-1-0.45-1-1v-1h10V20z M19,19c0,0.55-0.45,1-1,1s-1-0.45-1-1v-3H8V5h11V19z"/><rect height="2" width="6" x="9" y="7"/><rect height="2" width="2" x="16" y="7"/><rect height="2" width="6" x="9" y="10"/><rect height="2" width="2" x="16" y="10"/></g></svg>
                                    <span class="text-gray-500 group-hover:text-white">{{ skill.practice_lessons_count === 0 ? 'No' : skill.practice_lessons_count }} {{ __('Lessons') }}</span>
                                </div>
                            </inertia-link>
                        </div>
                        <div class="w-full sm:w-48 rounded shadow-inner border border-gray-200 group hover:bg-primary cursor-pointer">
                            <inertia-link :href="route('skill_practice_sets', {category: categorySlug, section: sectionSlug, skill: skill.slug})">
                                <div class="card-body flex flex-col items-center gap-1">
                                    <svg class="w-6 h-6 text-gray-500 group-hover:text-white" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M0 0h24v24H0V0z" fill="none"/><path d="M19 2H5c-1.11 0-2 .9-2 2v14c0 1.1.89 2 2 2h4l3 3 3-3h4c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm0 16h-4.83l-.59.59L12 20.17l-1.59-1.59-.58-.58H5V4h14v14zm-8-3h2v2h-2zm1-8c1.1 0 2 .9 2 2 0 2-3 1.75-3 5h2c0-2.25 3-2.5 3-5 0-2.21-1.79-4-4-4S8 6.79 8 9h2c0-1.1.9-2 2-2z"/></svg>
                                    <span class="text-gray-500 group-hover:text-white">{{ skill.practice_sets_count === 0 ? 'No' : skill.practice_sets_count }} {{ __('Practice Sets') }}</span>
                                </div>
                            </inertia-link>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    export default {
        name: "SkillCard",
        props: {
            skill: Object,
            categorySlug: String,
            sectionSlug: String,
            sno: Number
        },
        computed: {
            serial() {
                return String(this.sno).padStart(2, '0');
            }
        }
    }
</script>
