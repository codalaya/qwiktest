<template>
    <app-layout>
        <template #header>
            <h1 class="app-heading">{{ __('My Payments') }}</h1>
        </template>
        <div class="card mt-10">
            <div class="card-body">
                <vue-good-table mode="remote" @on-page-change="onPageChange" @on-column-filter="onColumnFilter" @on-per-page-change="onPerPageChange"
                                :pagination-options="options" :columns="columns"
                                :totalRows="payments.meta.pagination.total"
                                :rows="payments.data" :rtl="$page.props.rtl">
                    <template slot="table-row" slot-scope="props">
                        <!-- Status Column -->
                        <div v-if="props.column.field === 'status'">
                            <span :class="[props.row.status === 'success' ? 'badge-success' : 'badge-danger', 'badge-sm uppercase text-xs']">{{ __(props.row.status) }}</span>
                        </div>

                        <!-- Actions Column -->
                        <div class="py-2" v-else-if="props.column.field === 'actions'">
                            <a v-if="enable_invoice" class="qt-btn qt-btn-sm qt-btn-success" target="_blank" :href="route('download_invoice', {id: props.row.payment_id})">
                                {{ __('Invoice') }}
                            </a>
                        </div>

                        <!-- Remaining Columns -->
                        <span v-else>
                            {{props.formattedRow[props.column.field]}}
                        </span>
                    </template>

                    <div slot="emptystate">
                        <no-data-table></no-data-table>
                    </div>
                </vue-good-table>
            </div>
        </div>
    </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    import EmptyStudentCard from "@/Components/Cards/EmptyStudentCard";
    import NoDataTable from "@/Components/NoDataTable";

    export default {
        components: {
            AppLayout,
            EmptyStudentCard,
            NoDataTable
        },
        props: {
            payments: Object,
            steps: Array,
            errors: Object,
            enable_invoice: {
                type: Boolean,
                default: false
            }
        },
        data() {
            return {
                columns: [
                    {
                        label:  this.__('Payment')+' '+this.__('ID'),
                        field: 'payment_id',
                        sortable: false,
                    },
                    {
                        label: this.__('Plan'),
                        field: 'plan',
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
                        label: this.__('Method'),
                        field: 'method',
                        sortable: false,
                    },
                    {
                        label: this.__('Status'),
                        field: 'status',
                        sortable: false,
                    },
                    {
                        label: this.__('Actions'),
                        field: 'actions',
                        width: '11rem',
                        sortable: false,
                    }
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
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        computed: {
            title() {
                return this.__('My Payments')+' - ' + this.$page.props.general.app_name;
            }
        },
    }
</script>
