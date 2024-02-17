<template>
    <app-layout>
        <template #header>
            <h1 class="app-heading">{{ __('My Subscriptions') }}</h1>
        </template>
        <div class="card mt-10">
            <div class="card-body">
                <vue-good-table mode="remote" @on-page-change="onPageChange" @on-column-filter="onColumnFilter" @on-per-page-change="onPerPageChange"
                                :pagination-options="options" :columns="columns"
                                :totalRows="subscriptions.meta.pagination.total"
                                :rows="subscriptions.data" :rtl="$page.props.rtl">
                    <template slot="table-row" slot-scope="props">
                        <!-- Status Column -->
                        <div v-if="props.column.field === 'plan'">
                            <span>{{ props.row.plan }}</span><br>
                            <span class="text-xs text-gray-400">{{ props.row.payment }}</span>
                        </div>

                        <!-- Features Column -->
                        <div v-else-if="props.column.field === 'features'">
                            <ul>
                                <li v-for="feature in props.row.features" :key="feature.code" class="text-sm">- {{ __(feature.name) }}</li>
                            </ul>
                        </div>

                        <!-- Status Column -->
                        <div v-else-if="props.column.field === 'status'">
                            <span :class="[props.row.status === 'active' ? 'badge-success' : 'badge-danger', 'badge-sm uppercase text-xs']">{{ __(props.row.status) }}</span>
                        </div>

                        <!-- Actions Column -->
                        <div class="py-2" v-else-if="props.column.field === 'actions'">
                            <button type="button" v-if="props.row.canCancel" @click="cancelSubscription(props.row.id)" class="qt-btn qt-btn-sm qt-btn-danger">
                                {{ __('Cancel') }}
                            </button>
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
    import Swal from 'sweetalert2';

    export default {
        components: {
            AppLayout,
            EmptyStudentCard,
            NoDataTable
        },
        props: {
            subscriptions: Object,
            steps: Array,
            errors: Object,
        },
        data() {
            return {
                columns: [
                    {
                        label: this.__('Plan'),
                        field: 'plan',
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
                        label: this.__('Feature Access'),
                        field: 'features',
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
                        sortable: false,
                        width: '12rem',
                    }
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
            cancelSubscription(id) {
                Swal.fire({
                    title: this.__('Are you sure?'),
                    text: this.__('Do you want to cancel this subscription?'),
                    icon: 'warning',
                    showCancelButton: true,
                    cancelButtonText: this.__('No'),
                    confirmButtonColor: '#d33',
                    cancelButtonColor: '#3085d6',
                    confirmButtonText: this.__('Yes! Cancel')
                }).then((result) => {
                    if (result.isConfirmed) {
                        this.$inertia.post(route('cancel_my_subscription', {id: id}), {}, {
                            onSuccess: () => {
                                Swal.fire(
                                    this.__('Cancelled'),
                                    this.__('Subscription Cancelled'),
                                    'success'
                                )
                            },
                        });
                    }
                });
            }
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        computed: {
            title() {
                return this.__('My Subscriptions')+' - ' + this.$page.props.general.app_name;
            }
        },
    }
</script>
