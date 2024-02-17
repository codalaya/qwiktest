<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">{{ __('Exam Types') }}</h4>
        </template>
        <template #actions>
            <button @click="createForm = true" class="qt-btn qt-btn-success">
                {{ __('New :name', {name: __('Exam Type')}) }}
            </button>
        </template>

        <div class="container mx-auto py-8 px-4 sm:px-6 lg:px-8">
            <div class="card">
                <div class="card-body">
                    <vue-good-table mode="remote" @on-page-change="onPageChange" @on-column-filter="onColumnFilter" @on-per-page-change="onPerPageChange"
                                    :pagination-options="options" :columns="columns"
                                    :totalRows="examTypes.meta.pagination.total"
                                    :rows="examTypes.data">
                        <template slot="table-row" slot-scope="props">
                            <!-- Code Column -->
                            <div v-if="props.column.field === 'code'">
                                <Tag v-clipboard:copy="props.row.code" v-clipboard:success="handleCopyStatus" :value="props.row.code" icon="pi pi-copy"
                                     class="w-full p-mr-2 text-sm cursor-pointer"/>
                            </div>

                            <!-- Status Column -->
                            <div v-else-if="props.column.field === 'status'">
                                <span :class="[props.row.status ? 'badge-success' : 'badge-danger', 'badge']">{{ props.row.status ? 'Active' : 'In-active' }}</span>
                            </div>

                            <!-- Actions Column -->
                            <div v-else-if="props.column.field === 'actions'">
                                <actions-dropdown>
                                    <template #actions>
                                        <button @click="editForm = true; currentId = props.row.id;" class="action-item">Edit</button>
                                        <button @click="deleteRecord(props.row.id)" class="action-item">Delete</button>
                                    </template>
                                </actions-dropdown>
                            </div>

                            <!-- Remaining Columns -->
                            <span v-else>
                              {{props.formattedRow[props.column.field]}}
                            </span>
                        </template>

                        <div slot="emptystate">
                            <no-data-table>
                                <template slot="action">
                                    <button @click="createForm = true" class="qt-btn-sm qt-btn-primary" type="button">
                                        Create New
                                    </button>
                                </template>
                            </no-data-table>
                        </div>
                    </vue-good-table>

                    <!-- Sidebar Forms -->
                    <Sidebar position="right" :visible.sync="createForm" class="p-sidebar-md">
                        <ExamTypeForm :form-errors="errors" @close="createForm = false;" title="New Exam Type"/>
                    </Sidebar>
                    <Sidebar position="right" :visible.sync="editForm" class="p-sidebar-md">
                        <ExamTypeForm :edit-flag.sync="editForm" :exam-type-id="currentId" :form-errors="errors"
                                      @close="editForm = false;" title="Edit Exam Type"/>
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
    import ExamTypeForm from "@/Components/Forms/ExamTypeForm";
    import Chip from 'primevue/chip';
    import Tag from 'primevue/tag';
    import NoDataTable from "@/Components/NoDataTable";
    import ActionsDropdown from "@/Components/ActionsDropdown";

    export default {
        components: {
            ExamTypeForm,
            AdminLayout,
            Column,
            InputText,
            Toolbar,
            Button,
            Sidebar,
            Chip,
            Tag,
            NoDataTable,
            ActionsDropdown
        },
        props: {
            examTypes: Object,
            errors: Object,
        },
        data() {
            return {
                createForm: false,
                editForm: false,
                currentId: null,
                columns: [
                    {
                        label: 'Code',
                        field: 'code',
                        filterOptions: {
                            enabled: true,
                            placeholder: 'Search by Code',
                            filterValue: null,
                            trigger: 'enter',
                        },
                        sortable: false,
                        width: '11rem',
                    },
                    {
                        label: 'Name',
                        field: 'name',
                        filterOptions: {
                            enabled: true,
                            placeholder: 'Search by Name',
                            filterValue: null,
                            trigger: 'enter',
                        },
                        sortable: false,
                    },
                    {
                        label: 'Status',
                        field: 'status',
                        sortable: false,
                        filterOptions: {
                            enabled: true,
                            placeholder: 'Filter by Status',
                            filterValue: null,
                            filterDropdownItems: [{value: 1, text: 'Active'}, {value: 0, text: 'In-active'}],
                        },
                    },
                    {
                        label: 'Actions',
                        field: 'actions',
                        sortable: false,
                    }
                ],
                options: {
                    enabled: true,
                    mode: 'pages',
                    perPage: this.examTypes.meta.pagination.per_page,
                    setCurrentPage: this.examTypes.meta.pagination.current_page,
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
                return 'Exam Types - ' + this.$page.props.general.app_name + ' Admin';
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
            deleteRecord(id) {
                this.$confirm.require({
                    header: 'Confirm Delete',
                    message: 'Do you want to delete this record?',
                    icon: 'pi pi-info-circle',
                    acceptClass: 'p-button-danger',
                    rejectLabel: 'Cancel',
                    acceptLabel: 'Delete',
                    accept: () => {
                        this.$inertia.delete(route('exam-types.destroy', {id: id}), {}, {
                            onSuccess: () => {
                                this.$toast.add({
                                    severity: 'info',
                                    summary: 'Confirmed',
                                    detail: 'Record deleted',
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
                        summary: 'Copied',
                        detail: 'Copied Successfully!',
                        life: 2000
                    });
                }
            }
        }
    }
</script>
