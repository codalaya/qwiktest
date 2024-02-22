<template>
    <admin-layout>
        <div class="container mx-auto pt-4 px-4 sm:px-6 lg:px-8">
            <div
                class="w-full bg-white dark:bg-gray-800 py-5 flex flex-col xl:flex-row items-start xl:items-center justify-between px-5 xl:px-10 shadow rounded-t">
                <div class="mb-4 sm:mb-0 md:mb-0 lg:mb-0 xl:mb-0 lg:w-1/2">
                    <h2 class="text-gray-800 dark:text-gray-100 text-lg font-bold">{{ __('Quiz') }} {{ __('Schedules') }}
                    </h2>
                    <p class="font-normal text-sm text-gray-600 dark:text-gray-100 mt-1"
                        v-html="editFlag ? quiz.title : 'New Quiz'"></p>
                </div>
                <horizontal-stepper :steps="steps" :edit-flag="editFlag"></horizontal-stepper>
            </div>
        </div>


        <div class="container mx-auto py-8 px-4 sm:px-6 lg:px-8">
            <div class="card">
                <div class="card-body">
                    <div class="flex justify-end items-center mb-6">
                        <button @click="createForm = true" class="qt-btn qt-btn-success">
                            {{ __('New') }} {{ __('Schedule') }}
                        </button>
                    </div>
                    <vue-good-table mode="remote" @on-page-change="onPageChange" @on-column-filter="onColumnFilter"
                        @on-per-page-change="onPerPageChange" :pagination-options="options" :columns="columns"
                        :totalRows="quizSchedules.meta.pagination.total" :rows="quizSchedules.data" :rtl="$page.props.rtl">
                        <template slot="table-row" slot-scope="props">

                            <!-- Code Column -->
                            <div v-if="props.column.field === 'code'">
                                <Tag v-clipboard:copy="props.row.code" v-clipboard:success="handleCopyStatus"
                                    :value="props.row.code" icon="pi pi-copy"
                                    class="w-full p-mr-2 text-sm cursor-pointer" />
                            </div>

                            <!-- Status Column -->
                            <div v-else-if="props.column.field === 'status'">
                                <span
                                    :class="[props.row.status === 'Active' ? 'badge-success' : 'badge-danger', 'badge']">{{
                                        __(props.row.status) }}</span>
                            </div>

                            <!-- Actions Column -->
                            <div v-else-if="props.column.field === 'actions'">
                                <actions-dropdown>
                                    <template #actions>
                                        <button @click="copyLink(props.row)" class="action-item">
                                            {{ __('Copy Quiz Link') }}</button>
                                        <button @click="goToAnalytics(props.row.id)" class="action-item">{{ __('Analytics')
                                        }}</button>
                                        <button @click="editForm = true; currentId = props.row.id;" class="action-item">{{
                                            __('Edit') }}</button>
                                        <button @click="deleteSchedule(props.row.id)" class="action-item">{{ __('Delete')
                                        }}</button>
                                    </template>
                                </actions-dropdown>
                            </div>

                            <!-- Remaining Fields Column -->
                            <span v-else>
                                {{ props.formattedRow[props.column.field] }}
                            </span>
                        </template>

                        <div slot="emptystate">
                            <no-data-table>
                                <template slot="action">
                                    <button @click="createForm = true" class="qt-btn-sm qt-btn-primary" type="button">
                                        {{ __('New') }} {{ __('Schedule') }}
                                    </button>
                                </template>
                            </no-data-table>
                        </div>
                    </vue-good-table>

                    <!-- Sidebar Forms -->
                    <Sidebar position="right" :visible.sync="createForm" class="p-sidebar-md">
                        <QuizScheduleForm :form-errors="errors" @close="createForm = false;" :user-groups="userGroups"
                            :quiz-id="quiz.id" :title="__('New') + ' ' + __('Schedule')" />
                    </Sidebar>
                    <Sidebar position="right" :visible.sync="editForm" class="p-sidebar-md">
                        <QuizScheduleForm :edit-flag.sync="editForm" :quiz-schedule-id="currentId" :form-errors="errors"
                            :quiz-id="quiz.id" :user-groups="userGroups" @close="editForm = false"
                            :title="__('Edit') + ' ' + __('Schedule')" />
                    </Sidebar>
                </div>
            </div>
        </div>
    </admin-layout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout'
import Column from 'primevue/column';
import InputText from 'primevue/inputtext';
import Toolbar from 'primevue/toolbar';
import Button from 'primevue/button';
import Sidebar from 'primevue/sidebar'
import QuizScheduleForm from "@/Components/Forms/QuizScheduleForm";
import Toast from 'primevue/toast';
import Chip from 'primevue/chip';
import Tag from 'primevue/tag';
import HorizontalStepper from "@/Components/Stepper/HorizontalStepper";
import NoDataTable from "@/Components/NoDataTable";
import ActionsDropdown from "@/Components/ActionsDropdown";

export default {
    components: {
        QuizScheduleForm,
        AdminLayout,
        Column,
        InputText,
        Toolbar,
        Button,
        Sidebar,
        Toast,
        Chip,
        Tag,
        HorizontalStepper,
        NoDataTable,
        ActionsDropdown
    },
    props: {
        quiz: Object,
        steps: Array,
        editFlag: false,
        quizSchedules: Object,
        userGroups: Array,
        errors: Object,
    },
    data() {
        return {
            createForm: false,
            editForm: false,
            currentId: null,
            columns: [
                {
                    label: this.__('Code'),
                    field: 'code',
                    filterOptions: {
                        enabled: true,
                        placeholder: this.__('Search') + ' ' + this.__('Code'),
                        filterValue: null,
                        trigger: 'enter',
                    },
                    sortable: false,
                    width: '11rem',
                },
                {
                    label: this.__('Type'),
                    field: 'type',
                    sortable: false,
                },
                {
                    label: this.__('Starts At'),
                    field: 'starts_at',
                    sortable: false,
                },
                {
                    label: this.__('Ends At'),
                    field: 'ends_at',
                    sortable: false,
                },
                {
                    label: this.__('Status'),
                    field: 'status',
                    sortable: false,
                    filterOptions: {
                        enabled: true,
                        placeholder: this.__('Search') + ' ' + this.__('Status'),
                        filterValue: null,
                        filterDropdownItems: [{ value: 'active', text: this.__('Active') }, { value: 'expired', text: this.__('Expired') }, { value: 'cancelled', text: this.__('Cancelled') }],
                    },
                },
                {
                    label: this.__('Actions'),
                    field: 'actions',
                    sortable: false,
                }
            ],
            options: {
                enabled: true,
                mode: 'pages',
                perPage: this.quizSchedules.meta.pagination.per_page,
                setCurrentPage: this.quizSchedules.meta.pagination.current_page,
                perPageDropdown: [10, 20, 50, 100],
                dropdownAllowAll: false,
            },
            serverParams: {
                columnFilters: {},
                sort: {
                    field: '',
                    type: '',
                },
                page: 1,
                perPage: 10
            },
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
            return this.__('Quiz Schedules') + ' - ' + this.$page.props.general.app_name;
        }
    },
    methods: {
        updateParams(newProps) {
            this.serverParams = Object.assign({}, this.serverParams, newProps);
        },
        onPageChange(params) {
            this.updateParams({ page: params.currentPage });
            this.loadItems();
        },
        onPerPageChange(params) {
            this.updateParams({ perPage: params.currentPerPage });
            this.loadItems();
        },
        onSortChange(params) {
            this.updateParams({
                sort: [{
                    type: params.sortType,
                    field: this.columns[params.columnIndex].field,
                }],
            });
            this.loadItems();
        },
        onColumnFilter(params) {
            this.updateParams(params);
            this.loadItems();
        },
        getQueryParams() {
            let data = {
                'page': this.serverParams.page,
                'perPage': this.serverParams.perPage
            }

            for (const [key, value] of Object.entries(this.serverParams.columnFilters)) {
                if (value) {
                    data[key] = value;
                }
            }

            return data;
        },
        loadItems() {
            this.$inertia.get(route(route().current(), { quiz: this.quiz.id }), this.getQueryParams(), {
                replace: false,
                preserveState: true,
                preserveScroll: true,
            });
        },
        goToAnalytics(id) {
            this.$inertia.get(route('quizzes.overall_report', { quiz: this.quiz.id, schedule: id }));
        },
        deleteSchedule(id) {
            this.$confirm.require({
                header: this.__('Confirm Delete'),
                message: this.__('Do you want to delete this record?'),
                icon: 'pi pi-info-circle',
                acceptClass: 'p-button-danger',
                rejectLabel: this.__('Cancel'),
                acceptLabel: this.__('Delete'),
                accept: () => {
                    this.$inertia.delete(route('quizzes.schedules.destroy', { quiz: this.quiz.id, schedule: id }), {}, {
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
        handleCopyStatus(status) {
            if (status) {
                this.$toast.add({
                    severity: 'success',
                    summary: this.__('Copied'),
                    detail: this.__('Copied Successfully!'),
                    life: 2000
                });
            }
        },
        copyLink() {
            const url = route('quiz_instructions', this.quiz.slug);
            navigator.clipboard.writeText(url);
            this.$toast.add({ severity: 'info', summary: 'Link Copied!' })
        }
    }
}
</script>
