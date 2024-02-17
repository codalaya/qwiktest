<template>
    <app-layout>
        <template #header>
            <div class="flex items-center">
                <back-button />
                <h1 class="app-heading">{{ category.name }} {{ section.name }}</h1>
            </div>
        </template>

        <template #actions>
            <div class="uppercase font-semibold text-secondary">{{ section.skills.length }} {{ __('Skills') }}</div>
        </template>

        <div class="py-8">
            <div class="card flex flex-col justify-center items-center">
                <div class="card-body w-full grid grid-cols-1 divide-y divide-gray-200">
                    <template v-for="(skill, index) in section.skills">
                        <skill-card :skill="skill" :category-slug="category.slug" :section-slug="section.slug" :sno="index+1"></skill-card>
                    </template>
                </div>
            </div>
        </div>
    </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    import SectionHeader from "@/Components/SectionHeader";
    import BackButton from "@/Components/BackButton";
    import SkillCard from "@/Components/Cards/SkillCard";

    export default {
        components: {
            AppLayout,
            SectionHeader,
            BackButton,
            SkillCard
        },
        props: {
            category: Object,
            section: Object
        },
        metaInfo() {
            return {
                title: this.title
            }
        },

        computed: {
            title() {
                return this.category.name +' '+ this.section.name + ' - ' + this.$page.props.general.app_name;
            }
        },
    }
</script>
