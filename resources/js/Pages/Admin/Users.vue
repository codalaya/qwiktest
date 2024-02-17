<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">{{ __('Users') }}</h4>
        </template>
        <template #actions>
            <div class="flex gap-4 items-center">
                <!-- <inertia-link :href="route('initiate_import_users')" class="qt-btn qt-btn-primary">
                    {{ __('Import Users') }}
                </inertia-link> -->
                <button @click="createForm = true" class="qt-btn qt-btn-success">
                    {{ __('New') }} {{ __('User') }}
                </button>
            </div>
        </template>

        <div class="container mx-auto py-10 px-4 sm:px-6 lg:px-8">
            <div class="card">
                <div class="card-body">
                    <vue-good-table mode="remote" @on-page-change="onPageChange" @on-column-filter="onColumnFilter" @on-per-page-change="onPerPageChange"
                                    :pagination-options="options" :columns="columns"
                                    :totalRows="users.meta.pagination.total"
                                    :rows="users.data" :rtl="$page.props.rtl">
                        <template slot="table-row" slot-scope="props">
                            <!-- Code Column -->
                            <div v-if="props.column.field === 'code'">
                                <Tag v-clipboard:copy="props.row.code" :value="props.row.code" icon="pi pi-copy"
                                     class="w-full p-mr-2 cursor-pointer"/>
                            </div>

                            <!-- Status Column -->
                            <div v-else-if="props.column.field === 'status'">
                                <span :class="[props.row.status ? 'badge-success' : 'badge-danger', 'badge']">{{ props.row.status ? __('Active') : __('In-active') }}</span>
                            </div>

                            <!-- Action Column -->
                            <div v-else-if="props.column.field === 'actions'">
                                <actions-dropdown>
                                    <template #actions>
                                        <button @click="editForm = true; currentId = props.row.id;" class="action-item">{{ __('Edit') }}</button>
                                        <button @click="deleteUser(props.row.id)" class="action-item">{{ __('Delete') }}</button>
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
                                        {{ __('New') }} {{ __('User') }}
                                    </button>
                                </template>
                            </no-data-table>
                        </div>
                    </vue-good-table>

                    <!-- Sidebar Forms -->
                    <Sidebar position="right" :visible.sync="createForm" class="p-sidebar-md">
                        <UserForm :form-errors="errors" :roles="roles" @close="createForm = false" :user-groups="userGroups" :title="__('New') +' '+__('User')"/>
                    </Sidebar>
                    <Sidebar position="right" :visible.sync="editForm" class="p-sidebar-md">
                        <UserForm :edit-flag.sync="editForm" :roles="roles" :user-id="currentId" :user-groups="userGroups" :form-errors="errors"
                                       @close="editForm = false" :title="__('Edit') +' '+__('User')"/>
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
    import UserForm from "@/Components/Forms/UserForm";
    import Chip from 'primevue/chip';
    import Tag from 'primevue/tag';
    import NoDataTable from "@/Components/NoDataTable";
    import ActionsDropdown from "@/Components/ActionsDropdown";
    import Swal from 'sweetalert2';

    export default {
        components: {
            UserForm,
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
            users: Object,
            errors: Object,
            roles: Array,
            userGroups: Array
        },
        data() {
            return {
                createForm: false,
                editForm: false,
                currentId: null,
                columns: [
                    {
                        label: this.__('Name'),
                        field: 'fullName',
                        filterOptions: {
                            enabled: true,
                            placeholder: this.__('Search') +' '+ this.__('Name'),
                            filterValue: null,
                            trigger: 'enter',
                        },
                        sortable: false,
                    },
                    {
                        label: this.__('User Name'),
                        field: 'userName',
                        filterOptions: {
                            enabled: true,
                            placeholder: this.__('Search') +' '+ this.__('User Name'),
                            filterValue: null,
                            trigger: 'enter',
                        },
                        sortable: false,
                    },
                    {
                        label: this.__('Email'),
                        field: 'email',
                        filterOptions: {
                            enabled: true,
                            placeholder: this.__('Search') +' '+ this.__('Email'),
                            filterValue: null,
                            trigger: 'enter',
                        },
                        sortable: false,
                    },
                    {
                        label: this.__('Role'),
                        field: 'role',
                        filterOptions: {
                            enabled: true,
                            placeholder: this.__('Search') +' '+ this.__('Role'),
                            filterValue: null,
                            filterDropdownItems: this.roles,
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
                        width: '11rem'
                    },
                    {
                        label: this.__('Actions'),
                        field: 'actions',
                        sortable: false,
                        width: '12rem'
                    },
                ],
                options: {
                    enabled: true,
                    mode: 'pages',
                    perPage: this.users.meta.pagination.per_page,
                    setCurrentPage: this.users.meta.pagination.current_page,
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
                return this.__('Users')+' - ' + this.$page.props.general.app_name;
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
            async deleteUser(id) {
                const { value: code } = await Swal.fire({
                    html: this.__('Do you want to delete this account? This action permanently erases the entire user\'s data, including exam sessions and subscriptions. ' +
                        'Type <strong>permanently delete</strong> in the below input box and click the delete button.'),
                    icon: 'warning',
                    input: 'text',
                    inputPlaceholder: 'permanently delete',
                    inputAttributes: {
                        maxlength: 18,
                        minlength: 18,
                        autocapitalize: 'off',
                        autocorrect: 'off'
                    },
                    showCancelButton: true,
                    cancelButtonText: this.__('Cancel'),
                    confirmButtonText: this.__('Delete'),
                    confirmButtonColor: "#d33"
                })

                if(code && code === 'permanently delete') {
                    this.$inertia.delete(route('users.destroy', {id: id}), {}, {
                        onSuccess: () => {
                            this.$toast.add({
                                severity: 'info',
                                summary: this.__('Confirmed'),
                                detail: this.__('Record deleted'),
                                life: 3000
                            });
                        },
                    });
                } else {
                    this.$toast.add({
                        severity: 'info',
                        summary: this.__('Invalid Confirmation'),
                        detail: this.__('The entered confirmation text is invalid.'),
                        life: 3000
                    });
                }
            },
            handleCopyStatus(status) {
                if (status) {
                    this.$toast.add({
                        severity: 'success',
                        summary: this.__('Copied'),
                        detail: this.__('Copied Successfully!'),
                        life: 3000
                    });
                }
            }
        }
    }
</script>
