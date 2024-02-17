<template>
    <div class="flex justify-center card">
        <div class="w-full card-body">
            <div class="flex items-center justify-between mb-8">
                <p class="font-semibold leading-4 ltr:text-left rtl:text-right text-primary">{{ __('Choose Section') }}</p>
                <p class="font-mono text-sm leading-3 ltr:pl-6 rtl:pr-6 text-right text-gray-500 dark:text-gray-400">{{ category.category }} {{ category.type }}</p>
            </div>
            <div class="grid grid-cols-2 sm:grid-cols-4 gap-4 items-center justify-between mb-4">
                <template v-for="section in category.sections">
                    <inertia-link :href="route('learn_practice_section', {category: category.slug, section: section.slug})">
                        <section-card :section="section"></section-card>
                    </inertia-link>
                </template>
            </div>
        </div>
    </div>
</template>
<script>
    import SectionCard from "@/Components/Cards/SectionCard";
    export default {
        name: 'PracticeCategoryCard',
        components: {
            SectionCard
        },
        props: {
            category: Object
        }
    }
</script>
