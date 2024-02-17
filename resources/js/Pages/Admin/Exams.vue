<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">{{ __('Exams')}}</h4>
        </template>
        <template #actions>
            <inertia-link :href="route('exams.create')" class="qt-btn qt-btn-success">
                {{ __('New') }} {{ __('Exam') }}
            </inertia-link>
        </template>

        <div class="container mx-auto py-8 px-4 sm:px-6 lg:px-8">
            <div class="card">
                <div class="card-body">
                    <vue-good-table mode="remote"
                                    @on-page-change="onPageChange"
                                    @on-column-filter="onColumnFilter"
                                    @on-per-page-change="onPerPageChange"
                                    :pagination-options="options" :columns="columns"
                                    :totalRows="exams.meta.pagination.total"
                                    :rows="exams.data" :rtl="$page.props.rtl">
                        <template slot="table-row" slot-scope="props">

                            <!-- Code Column -->
                            <div v-if="props.column.field === 'code'">
                                <Tag v-clipboard:copy="props.row.code" severity="info" v-clipboard:success="handleCopyStatus"
                                     :value="props.row.code" icon="pi pi-copy" class="w-full p-mr-2 mb-2 text-xs cursor-pointer"/>
                            </div>

                            <!-- Status Column -->
                            <div v-else-if="props.column.field === 'status'">
                                <span :class="[props.row.status === 'Published' ? 'badge-success' : 'badge-danger', 'badge']">{{ __(props.row.status) }}</span>
                            </div>

                            <!-- Actions Column -->
                            <div v-else-if="props.column.field === 'actions'">
                                <actions-dropdown>
                                    <template #actions>
                                        <button @click="goToAnalytics(props.row.id)" class="action-item">Analytics</button>
                                        <button @click="goToSchedules(props.row.id)" class="action-item">Schedules</button>
                                        <button @click="editExam(props.row.id)" class="action-item">Edit</button>
                                        <button @click="deleteExam(props.row.id)" class="action-item">Delete</button>
                                    </template>
                                </actions-dropdown>
                            </div>

                            <!-- Remaining Columns -->
                            <span v-else>
                              {{ props.formattedRow[props.column.field] }}
                            </span>

                        </template>
                        <div slot="emptystate">
                            <no-data-table>
                                <template slot="action">
                                    <inertia-link :href="route('exams.create')" class="qt-btn-sm qt-btn-primary">
                                        {{ __('Create') }}
                                    </inertia-link>
                                </template>
                            </no-data-table>
                        </div>
                    </vue-good-table>
                </div>
            </div>
        </div>
    </admin-layout>
</template>

<script>
    import AdminLayout from '@/Layouts/AdminLayout';
    import ArcDropdown from '@/Components/Dropdown';
    import ActionsDropdown from "@/Components/ActionsDropdown";
    import ArcDropdownLink from '@/Components/DropdownLink';
    import Toast from 'primevue/toast';
    import Chip from 'primevue/chip';
    import Tag from 'primevue/tag';
    import Button from 'primevue/button';
    import NoDataTable from "@/Components/NoDataTable";

    export default {
        components: {
            AdminLayout,
            ArcDropdown,
            ArcDropdownLink,
            ActionsDropdown,
            Toast,
            Chip,
            Tag,
            Button,
            NoDataTable
        },
        props: {
            examTypes: Array,
            exams: Object,
            statusFilters: Array,
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
                        label: this.__('Title'),
                        field: 'title',
                        filterOptions: {
                            enabled: true,
                            placeholder: this.__('Search') + ' '+ this.__('Title'),
                            filterValue: null,
                            trigger: 'enter',
                        },
                        sortable: false,
                    },
                    {
                        label: this.__('Category'),
                        field: 'category',
                        filterOptions: {
                            enabled: true,
                            placeholder: this.__('Search') + ' '+ this.__('Category'),
                            filterValue: null,
                            trigger: 'enter',
                        },
                        sortable: false,
                    },
                    {
                        label: this.__('Type'),
                        field: 'examType',
                        filterOptions: {
                            enabled: true,
                            placeholder: this.__('Search') + ' '+ this.__('Type'),
                            filterValue: null,
                            filterDropdownItems: this.examTypes,
                        },
                        sortable: false,
                    },
                    {
                        label: this.__('Sections'),
                        field: 'sections',
                        sortable: false,
                    },
                    {
                        label: this.__('Visibility'),
                        field: 'visibility',
                        sortable: false,
                        filterOptions: {
                            enabled: true,
                            placeholder: this.__('Search') + ' '+ this.__('Visibility'),
                            filterValue: null,
                            filterDropdownItems: [{value: 1, text: this.__('Private')}, {value: 0, text: this.__('Public')}],
                        },
                    },
                    {
                        label: this.__('Status'),
                        field: 'status',
                        sortable: false,
                        filterOptions: {
                            enabled: true,
                            placeholder: this.__('Search') + ' '+ this.__('Status'),
                            filterValue: null,
                            filterDropdownItems: [{value: 1, text: this.__('Published')}, {value: 0, text: this.__('Draft')}],
                        },
                    },
                    {
                        label: this.__('Actions'),
                        field: 'actions',
                        sortable: false,
                        width: '200px',
                        tdClass: 'text-center',
                    }
                ],
                options: {
                    enabled: true,
                    mode: 'pages',
                    perPage: this.exams.meta.pagination.per_page,
                    setCurrentPage: this.exams.meta.pagination.current_page,
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
                return this.__('Exams')+' - ' + this.$page.props.general.app_name;
            }
        },
        methods: {
            updateParams(newProps) {
                this.serverParams = Object.assign({}, this.serverParams, newProps);
            },
            onPageChange(params) {
                this.updateParams({page: params.currentPage});
                this.loadItems();
            },
            onPerPageChange(params) {
                this.updateParams({perPage: params.currentPerPage});
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
                this.serverParams.page = 1;
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
                this.$inertia.get(route(route().current()), this.getQueryParams(), {
                    replace: false,
                    preserveState: true,
                    preserveScroll: true,
                });
            },
            editExam(id) {
                this.$inertia.get(route('exams.edit', {exam: id}));
            },
            goToSchedules(id) {
                this.$inertia.get(route('exams.schedules.index', {exam: id}));
            },
            goToAnalytics(id) {
                this.$inertia.get(route('exams.overall_report', {exam: id}));
            },
            deleteExam(id) {
                this.$confirm.require({
                    header: this.__('Confirm Delete'),
                    message: this.__('This will remove all the user sessions. Do you want to delete this exam?'),
                    icon: 'pi pi-info-circle',
                    acceptClass: 'p-button-danger',
                    rejectLabel: this.__('Cancel'),
                    acceptLabel: this.__('Delete'),
                    accept: () => {
                        this.$inertia.delete(route('exams.destroy', {id: id}), {}, {
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
            }
        }
    }
</script>
