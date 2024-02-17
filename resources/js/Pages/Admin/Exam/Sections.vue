<template>
    <admin-layout>
        <Toast position="top-right"/>
        <div class="container mx-auto pt-4 px-4 sm:px-6 lg:px-8">
            <div class="w-full bg-white dark:bg-gray-800 py-5 flex flex-col xl:flex-row items-start xl:items-center justify-between px-5 xl:px-10 shadow rounded-t">
                <div class="mb-4 sm:mb-0 md:mb-0 lg:mb-0 xl:mb-0 lg:w-1/2">
                    <h2 class="text-gray-800 dark:text-gray-100 text-lg font-bold">{{ __('Exam') }} {{ __('Sections') }}</h2>
                    <p class="font-normal text-sm text-gray-600 dark:text-gray-100 mt-1" v-html="editFlag ? exam.title : __('New')+' '+ __('Exam')"></p>
                </div>
                <horizontal-stepper :steps="steps" :edit-flag="editFlag"></horizontal-stepper>
            </div>
        </div>

        <div class="py-6">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="flex flex-wrap justify-center">
                    <div class="w-full">
                        <div class="w-full flex justify-end mb-2">
                            <Button @click="createForm = true" severity="success" :label="__('Add')+' '+__('Section')"/>
                        </div>
                        <table class="shadow-lg bg-white section-form w-full">
                            <tr>
                                <th class="bg-blue-100 border ltr:text-left rtl:text-right text-sm px-8 py-4">{{ __('#') }}</th>
                                <th class="bg-blue-100 border ltr:text-left rtl:text-right text-sm px-8 py-4">{{ __('Display Name') }}</th>
                                <th class="bg-blue-100 border ltr:text-left rtl:text-right text-sm px-8 py-4">{{ __('Section') }}</th>
                                <th class="bg-blue-100 border ltr:text-left rtl:text-right text-sm px-8 py-4">{{ __('Total Questions') }}</th>
                                <th class="bg-blue-100 border ltr:text-left rtl:text-right text-sm px-8 py-4">{{ __('Total Duration') }}</th>
                                <th class="bg-blue-100 border ltr:text-left rtl:text-right text-sm px-8 py-4">{{ __('Total Marks') }}</th>
                                <th class="bg-blue-100 border ltr:text-left rtl:text-right text-sm px-8 py-4">{{ __('Actions') }}</th>
                            </tr>
                            <tr v-for="section in sections">
                                <td class="border px-8 py-2">
                                    <span class="text-sm">{{ section.section_order }}</span>
                                </td>
                                <td class="border px-8 py-2">
                                    <span class="text-sm">{{ section.name }}</span>
                                </td>
                                <td class="border px-8 py-2">
                                    <span class="text-sm">{{ section.section }}</span>
                                </td>
                                <td class="border px-8 py-2">
                                    <span class="text-sm">{{ section.total_questions }} {{ __('Q') }}</span>
                                </td>
                                <td class="border px-8 py-2">
                                    <span class="text-sm">{{ section.total_duration }} {{ __('Minutes') }}</span>
                                </td>
                                <td class="border px-8 py-2">
                                    <span class="text-sm">{{ section.total_marks > 0 ? section.total_marks : 0  }} {{ __('Marks') }}</span>
                                </td>
                                <td class="border px-8 py-2">
                                    <Button icon="pi pi-pencil" class="p-button-rounded p-button-secondary p-button-text p-mr-2"
                                            @click="editForm = true; currentId = section.id;"/>
                                    <Button @click="deleteSection(section.id)" icon="pi pi-trash" class="p-button-rounded p-button-danger p-button-text"/>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>

                <Sidebar position="right" :visible.sync="createForm" class="p-sidebar-md">
                    <SectionForm :errors="errors" @close="createForm = false" :exam="this.exam" :title="__('New')+' '+ __('Section')"/>
                </Sidebar>
                <Sidebar position="right" :visible.sync="editForm" class="p-sidebar-md">
                    <SectionForm :edit-flag.sync="editForm" :section-id="currentId" :errors="errors"
                                 @close="editForm = false" :exam="this.exam" :title="__('Edit')+' '+ __('Section')"/>
                </Sidebar>

            </div>
        </div>
    </admin-layout>
</template>

<script>
    import AdminLayout from '@/Layouts/AdminLayout'
    import ExamNavigation from "@/Components/Exams/ExamNavigation";
    import Column from 'primevue/column';
    import InputText from 'primevue/inputtext';
    import Toolbar from 'primevue/toolbar';
    import Button from 'primevue/button';
    import Sidebar from 'primevue/sidebar'
    import SectionForm from "@/Components/Exams/SectionForm";
    import Toast from 'primevue/toast';
    import HorizontalStepper from "@/Components/Stepper/HorizontalStepper";

    export default {
        components: {
            AdminLayout,
            ExamNavigation,
            SectionForm,
            Column,
            InputText,
            Toolbar,
            Button,
            Sidebar,
            Toast,
            HorizontalStepper
        },
        props: {
            sections: Array,
            exam: Object,
            errors: Object,
            steps: Array,
            editFlag: false,
        },
        data() {
            return {
                createForm: false,
                editForm: false,
                currentId: null,
                loading: false,
            }
        },
        metaInfo() {
            return {
                title: this.title
            }
        },

        computed: {
            title() {
                return this.exam.title+ ' '+this.__('Sections')+' - ' + this.$page.props.general.app_name;
            }
        },
        methods: {
            deleteSection(id) {
                let _this = this;
                this.$confirm.require({
                    header: this.__('Confirm Delete'),
                    message: this.__('Do you want to delete this record?'),
                    icon: 'pi pi-info-circle',
                    acceptClass: 'p-button-danger',
                    rejectLabel: this.__('Cancel'),
                    acceptLabel: this.__('Delete'),
                    accept: () => {
                        this.$inertia.delete(route('exams.sections.destroy', { exam: _this.exam.id, section: id }), {}, {
                            onSuccess: () => {
                                this.$toast.add({
                                    severity: 'info',
                                    summary: this.__('Confirmed'),
                                    detail: this.__('Record deleted'),
                                    life: 3000
                                });
                            },
                        });
                    },
                    reject: () => {

                    }
                });
            },
        }
    }
</script>
