<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">{{ __('Categories') }}</h4>
        </template>
        <template #actions>
            <button @click="createForm = true" class="qt-btn qt-btn-success">
                {{ __('New') }} {{ __('Category') }}
            </button>
        </template>

        <div class="container mx-auto py-8 px-4 sm:px-6 lg:px-8">
            <div class="card">
                <div class="card-body">
                    <vue-good-table mode="remote" @on-page-change="onPageChange" @on-column-filter="onColumnFilter" @on-per-page-change="onPerPageChange"
                                    :pagination-options="options" :columns="columns"
                                    :totalRows="categories.meta.pagination.total"
                                    :rows="categories.data" :rtl="$page.props.rtl">
                        <template slot="table-row" slot-scope="props">
                            <!-- Code Column -->
                            <div v-if="props.column.field === 'code'">
                                <Tag v-clipboard:copy="props.row.code" v-clipboard:success="handleCopyStatus" :value="props.row.code" icon="pi pi-copy"
                                     class="w-full p-mr-2 text-sm cursor-pointer"/>
                            </div>

                            <!-- Status Column -->
                            <div v-else-if="props.column.field === 'status'">
                                <span :class="[props.row.status === 'Active' ? 'badge-success' : 'badge-danger', 'badge']">{{ __(props.row.status) }}</span>
                            </div>

                            <!-- Actions Column -->
                            <div v-else-if="props.column.field === 'actions'">
                                <actions-dropdown>
                                    <template #actions>
                                        <button @click="editForm = true; currentId = props.row.id;" class="action-item">{{ __('Edit') }}</button>
                                        <button @click="deleteCategory(props.row.id)" class="action-item">{{ __('Delete') }}</button>
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
                                        {{ __('New') }} {{ __('Category') }}
                                    </button>
                                </template>
                            </no-data-table>
                        </div>
                    </vue-good-table>

                    <!-- Sidebar Forms -->
                    <Sidebar position="right" :visible.sync="createForm" class="p-sidebar-md">
                        <CategoryForm :form-errors="errors" @close="createForm = false" :title="__('New') +' '+__('Category')"/>
                    </Sidebar>
                    <Sidebar position="right" :visible.sync="editForm" class="p-sidebar-md">
                        <CategoryForm :edit-flag.sync="editForm" :category-id="currentId" :form-errors="errors"
                                       @close="editForm = false" :title="__('New') +' '+__('Category')"/>
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
    import CategoryForm from "@/Components/Forms/CategoryForm";
    import Chip from 'primevue/chip';
    import Tag from 'primevue/tag';
    import NoDataTable from "@/Components/NoDataTable";
    import ActionsDropdown from "@/Components/ActionsDropdown";

    export default {
        components: {
            CategoryForm,
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
            categories: Object,
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
                            placeholder: this.__('Search') +' '+ this.__('Code'),
                            filterValue: null,
                            trigger: 'enter',
                        },
                        sortable: false,
                        width: '11rem',
                    },
                    {
                        label: this.__('Name'),
                        field: 'name',
                        filterOptions: {
                            enabled: true,
                            placeholder: this.__('Search') +' '+ this.__('Name'),
                            filterValue: null,
                            trigger: 'enter',
                        },
                        sortable: false,
                    },
                    {
                        label: this.__('Status'),
                        field: 'status',
                        sortable: false,
                        filterOptions: {
                            enabled: true,
                            placeholder: this.__('Search') +' '+ this.__('Status'),
                            filterValue: null,
                            filterDropdownItems: [{value: 1, text: this.__('Active')}, {value: 0, text: this.__('In-active')}],
                        },
                        width: '11rem',
                    },
                    {
                        label: this.__('Actions'),
                        field: 'actions',
                        sortable: false,
                        width: '12rem',
                    }
                ],
                options: {
                    enabled: true,
                    mode: 'pages',
                    perPage: this.categories.meta.pagination.per_page,
                    setCurrentPage: this.categories.meta.pagination.current_page,
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
                return this.__('Categories')+' - ' + this.$page.props.general.app_name;
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
            deleteCategory(id) {
                this.$confirm.require({
                    header: this.__('Confirm Delete'),
                    message: this.__('Do you want to delete this record?'),
                    icon: 'pi pi-info-circle',
                    acceptClass: 'p-button-danger',
                    rejectLabel: this.__('Cancel'),
                    acceptLabel: this.__('Delete'),
                    accept: () => {
                        this.$inertia.delete(route('categories.destroy', {id: id}), {}, {
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
