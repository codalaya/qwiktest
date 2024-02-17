<template>
    <app-layout>
        <template #header>
            <h1 class="app-heading">{{ __('Learn & Practice') }} {{ category.name }}</h1>
        </template>

        <div class="py-8">
            <div class="flex flex-col justify-center items-center">
                <div class="w-full">
                    <div class="flex flex-col gap-4 justify-center">
                        <practice-category-card :category="category"></practice-category-card>
                    </div>
                </div>
            </div>
        </div>
    </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    import PracticeCategoryCard from "@/Components/Cards/PracticeCategoryCard";
    import SectionHeader from "@/Components/SectionHeader";
    export default {
        components: {
            AppLayout,
            PracticeCategoryCard,
            SectionHeader
        },
        props: {
            category: Object,
        },
        metaInfo() {
            return {
                title: this.title
            }
        },

        computed: {
            title() {
                return this.__('Learn & Practice')+' '+ this.category.name +' - ' + this.$page.props.general.app_name;
            }
        },
    }
</script>
