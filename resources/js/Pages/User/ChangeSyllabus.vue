<template>
    <app-layout>
        <template #header>
            <h1 class="app-heading">{{ __('Update Syllabus') }}</h1>
        </template>

        <div class="py-8">
            <div class="flex flex-col items-center">
                <div class="w-full">
                    <section-header :title="'Choose Category'"></section-header>
                    <div v-if="categories.length > 0" class="grid grid-cols-1 md:grid-cols-2 gap-4 mt-6 mb-12">
                        <template v-for="(category, index) in categories">
                            <div @click="updateSyllabus(category.code)" class="card cursor-pointer group hover:bg-primary">
                                <div class="card-body h-28 flex flex-col justify-center items-center">
                                    <div class="font-semibold text-primary group-hover:text-white mb-2">{{ category.name }}</div>
                                    <div class="flex items-center justify-center bg-secondary rounded">
                                        <p class="text-xs leading-loose text-center text-white px-2">{{ category.category }} {{ category.type }}</p>
                                    </div>
                                </div>
                            </div>
                        </template>
                    </div>
                    <div class="mb-6" v-else>
                        <empty-student-card :title="__('No Categories Found')" />
                    </div>
                </div>
            </div>
        </div>
    </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    import EmptyStudentCard from "@/Components/Cards/EmptyStudentCard";
    import SectionHeader from "@/Components/SectionHeader";

    export default {
        components: {
            AppLayout,
            EmptyStudentCard,
            SectionHeader
        },
        props: {
            categories: Array,
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        methods: {
            updateSyllabus(code) {
                this.$inertia.post(route('update_syllabus'), {
                    category: code,
                })
            }
        },
        computed: {
            title() {
                return this.__('Change Syllabus')+' - ' + this.$page.props.general.app_name;
            }
        },
    }
</script>
