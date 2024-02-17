<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">{{ __('Payments') }}</h4>
        </template>

        <div class="container mx-auto py-10 px-4 sm:px-6 lg:px-8">
            <div class="card">
                <div class="card-body">
                    <vue-good-table mode="remote" @on-page-change="onPageChange" @on-column-filter="onColumnFilter" @on-per-page-change="onPerPageChange"
                                    :pagination-options="options" :columns="columns"
                                    :totalRows="payments.meta.pagination.total"
                                    :rows="payments.data" :rtl="$page.props.rtl">
                        <template slot="table-row" slot-scope="props">
                            <!-- Code Column -->
                            <div v-if="props.column.field === 'code'">
                                <Tag v-clipboard:copy="props.row.code" :value="props.row.code" v-clipboard:success="handleCopyStatus" icon="pi pi-copy"
                                     class="w-full p-mr-2 cursor-pointer"/>
                            </div>

                            <!-- Status Column -->
                            <div v-else-if="props.column.field === 'status'">
                                <span :class="[props.row.status === 'success' ? 'badge-success' : 'badge-danger', 'badge uppercase']">{{ props.row.status }}</span>
                            </div>

                            <!-- Action Column -->
                            <div v-else-if="props.column.field === 'actions'">
                                <Button v-if="props.row.status === 'pending' && props.row.method === 'Bank'" class="p-button p-button-sm p-button-success p-mr-2" @click="approvePayment(props.row.id, props.row.code)">
                                    {{ __('Authorize') }}
                                </Button>
                                <actions-dropdown>
                                    <template #actions>
                                        <button @click="showDetails = true; currentId = props.row.id;" class="action-item">{{ __('Details') }}</button>
                                        <button @click="deletePayment(props.row.id)" class="action-item">{{ __('Delete') }}</button>
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
                                    {{ __('No Payments') }}
                                </template>
                            </no-data-table>
                        </div>
                    </vue-good-table>

                    <!-- Details Sidebar -->
                    <Sidebar position="right" :visible.sync="showDetails" class="p-sidebar-md">
                        <PaymentDetails :errors="errors" :status-types="paymentStatuses" @close="showDetails = false" :payment-id="currentId" :title="__('Payment') +' '+__('Details')"/>
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
    import Chip from 'primevue/chip';
    import Tag from 'primevue/tag';
    import NoDataTable from "@/Components/NoDataTable";
    import PaymentDetails from "@/Pages/Admin/PaymentDetails";
    import ActionsDropdown from "@/Components/ActionsDropdown";

    export default {
        components: {
            AdminLayout,
            PaymentDetails,
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
            payments: Object,
            errors: Object,
            paymentProcessors: Array,
            paymentStatuses: Array
        },
        data() {
            return {
                createForm: false,
                editForm: false,
                showDetails: false,
                currentId: null,
                columns: [
                    {
                        label: this.__('Payment ID'),
                        field: 'code',
                        filterOptions: {
                            enabled: true,
                            placeholder: this.__('Search') +' '+ this.__('Payment ID'),
                            filterValue: null,
                            trigger: 'enter',
                        },
                        sortable: false,
                    },
                    {
                        label: this.__('Plan'),
                        field: 'plan',
                        sortable: false,
                    },
                    {
                        label: this.__('User'),
                        field: 'user',
                        sortable: false,
                    },
                    {
                        label: this.__('Amount'),
                        field: 'amount',
                        sortable: false,
                    },
                    {
                        label: this.__('Date'),
                        field: 'date',
                        sortable: false,
                    },
                    {
                        label: this.__('Payment Method'),
                        field: 'method',
                        filterOptions: {
                            enabled: true,
                            placeholder: this.__('Search') +' '+ this.__('Method'),
                            filterValue: null,
                            filterDropdownItems: this.paymentProcessors,
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
                            filterDropdownItems: this.paymentStatuses,
                        },
                        width: '11rem'
                    },
                    {
                        label: this.__('Actions'),
                        field: 'actions',
                        sortable: false,
                        width: '15rem'
                    },
                ],
                options: {
                    enabled: true,
                    mode: 'pages',
                    perPage: this.payments.meta.pagination.per_page,
                    setCurrentPage: this.payments.meta.pagination.current_page,
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
                return this.__('Payments')+' - ' + this.$page.props.general.app_name;
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
            approvePayment(id, code) {
                this.$confirm.require({
                    header: this.__('Approve/Cancel Payment'),
                    message: this.__('If approved, the subscription will be activated. If cancelled, nothing will happen.'),
                    icon: 'pi pi-info-circle',
                    acceptClass: 'p-button-success',
                    rejectClass: 'p-button-danger',
                    rejectLabel: this.__('Cancel Payment'),
                    acceptLabel: this.__('Approve Payment'),
                    accept: () => {
                        this.$inertia.post(route('authorize_bank_payment', {id: id}), {status: 'approved'}, {
                            onSuccess: () => {
                                //
                            },
                        });
                    },
                    reject: () => {
                        this.$inertia.post(route('authorize_bank_payment', {id: id}), {status: 'rejected'}, {
                            onSuccess: () => {
                                //
                            },
                        });
                    }
                });

            },
            deletePayment(id) {
                this.$confirm.require({
                    header: this.__('Confirm Delete'),
                    message: this.__('This action will remove the associated subscription. Do you want to delete this payment?'),
                    icon: 'pi pi-info-circle',
                    acceptClass: 'p-button-danger',
                    rejectLabel: this.__('Cancel'),
                    acceptLabel: this.__('Delete'),
                    accept: () => {
                        this.$inertia.delete(route('payments.destroy', {id: id}), {}, {
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
