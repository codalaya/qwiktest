<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">{{ __('Subscriptions') }}</h4>
        </template>
        <template #actions>
            <button @click="createForm = true" class="qt-btn qt-btn-success">
                {{ __('Add') }} {{ __('Manual Subscription') }}
            </button>
        </template>

        <div class="container mx-auto py-10 px-4 sm:px-6 lg:px-8">
            <div class="card">
                <div class="card-body">
                    <vue-good-table mode="remote" @on-page-change="onPageChange" @on-column-filter="onColumnFilter" @on-per-page-change="onPerPageChange"
                                    :pagination-options="options" :columns="columns"
                                    :totalRows="subscriptions.meta.pagination.total"
                                    :rows="subscriptions.data" :rtl="$page.props.rtl">
                        <template slot="table-row" slot-scope="props">
                            <!-- Code Column -->
                            <div v-if="props.column.field === 'code'">
                                <Tag v-clipboard:copy="props.row.code" :value="props.row.code" v-clipboard:success="handleCopyStatus" icon="pi pi-copy"
                                     class="w-full p-mr-2 cursor-pointer"/>
                            </div>

                            <!-- Status Column -->
                            <div v-else-if="props.column.field === 'status'">
                                <span :class="[props.row.status === 'active' ? 'badge-success' : 'badge-danger', 'badge uppercase']">{{ props.row.status }}</span>
                            </div>

                            <!-- Action Column -->
                            <div v-else-if="props.column.field === 'actions'">
                                <actions-dropdown>
                                    <template #actions>
                                        <button @click="showDetails = true; currentId = props.row.id;" class="action-item">{{ __('Details') }}</button>
                                        <button @click="deleteSubscription(props.row.id)" class="action-item">{{ __('Delete') }}</button>
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
                                        {{ __('New') }} {{ __('Subscription') }}
                                    </button>
                                </template>
                            </no-data-table>
                        </div>
                    </vue-good-table>

                    <!-- Sidebar Forms -->
                    <Sidebar position="right" :visible.sync="createForm" class="p-sidebar-md">
                        <SubscriptionForm :errors="errors" :status-types="subscriptionStatuses" @close="createForm = false" :title="__('New') +' '+__('Subscription')"/>
                    </Sidebar>
                    <Sidebar position="right" :visible.sync="showDetails" class="p-sidebar-md">
                        <SubscriptionDetails :errors="errors" :status-types="subscriptionStatuses" :subscription-id="currentId" @close="showDetails = false" :title="__('Subscription') +' '+__('Details')"/>
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
    import SubscriptionForm from "@/Components/Forms/SubscriptionForm";
    import Chip from 'primevue/chip';
    import Tag from 'primevue/tag';
    import NoDataTable from "@/Components/NoDataTable";
    import SubscriptionDetails from "@/Pages/Admin/SubscriptionDetails";
    import ActionsDropdown from "@/Components/ActionsDropdown";

    export default {
        components: {
            SubscriptionForm,
            AdminLayout,
            SubscriptionDetails,
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
            subscriptions: Object,
            errors: Object,
            plans: Array,
            subscriptionStatuses: Array,
            subCategories: Array,
        },
        data() {
            return {
                createForm: false,
                editForm: false,
                showDetails: false,
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
                    },
                    {
                        label: this.__('Plan'),
                        field: 'plan',
                        filterOptions: {
                            enabled: true,
                            placeholder: this.__('Search') +' '+ this.__('Plan'),
                            filterValue: null,
                            filterDropdownItems: this.plans,
                        },
                        sortable: false,
                    },
                    {
                        label: this.__('User'),
                        field: 'user',
                        sortable: false,
                    },
                    {
                        label: this.__('Starts'),
                        field: 'starts',
                        sortable: false,
                    },
                    {
                        label: this.__('Ends'),
                        field: 'ends',
                        sortable: false,
                    },
                    {
                        label: this.__('Payment'),
                        field: 'payment',
                        filterOptions: {
                            enabled: true,
                            placeholder: this.__('Search') +' '+ this.__('Payment'),
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
                            filterDropdownItems: this.subscriptionStatuses,
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
                    perPage: this.subscriptions.meta.pagination.per_page,
                    setCurrentPage: this.subscriptions.meta.pagination.current_page,
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
                return this.__('Subscriptions')+' - ' + this.$page.props.general.app_name;
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
            deleteSubscription(id) {
                this.$confirm.require({
                    header: this.__('Confirm Delete'),
                    message: this.__('Do you want to delete this record?'),
                    icon: 'pi pi-info-circle',
                    acceptClass: 'p-button-danger',
                    rejectLabel: this.__('Cancel'),
                    acceptLabel: this.__('Delete'),
                    accept: () => {
                        this.$inertia.delete(route('subscriptions.destroy', {id: id}), {}, {
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
                        life: 3000
                    });
                }
            }
        }
    }
</script>
