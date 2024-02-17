<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">{{ practiceSet.title }} - {{ __('Detailed Report') }}</h4>
        </template>
        <template #actions>
            <a :href="route('practice-sets.export_report', {practice_set: practiceSet.id})" target="_blank" class="qt-btn qt-btn-primary">
                {{ __('Download Report') }}
            </a>
            <inertia-link :href="route('practice-sets.overall_report', {practice_set: practiceSet.id})" class="ltr:ml-2 rtl:mr-2 qt-btn qt-btn-success">
                {{ __('Overall Report') }}
            </inertia-link>
        </template>

        <div class="py-8">
            <div class="container mx-auto px-4 sm:px-6 lg:px-8">
                <div class="card">
                    <div class="card-body">
                        <vue-good-table mode="remote" @on-page-change="onPageChange" @on-column-filter="onColumnFilter" @on-per-page-change="onPerPageChange"
                                        :pagination-options="options" :columns="columns"
                                        :totalRows="practiceSessions.meta.pagination.total"
                                        :rows="practiceSessions.data" :rtl="$page.props.rtl">
                            <template slot="table-row" slot-scope="props">
                                <!-- Status Column -->
                                <div v-if="props.column.field === 'status'">
                                    <span :class="[props.row.status === 'Completed' ? 'badge-success' : 'badge-danger', 'badge-sm uppercase text-xs']">{{ __(props.row.status) }}</span>
                                </div>

                                <!-- Actions Column -->
                                <div class="py-2" v-else-if="props.column.field === 'actions'">
                                    <actions-dropdown>
                                        <template #actions>
                                            <inertia-link :href="route('practice_session_results', {practice_set: props.row.slug, session: props.row.id})"
                                                          class="action-item">{{ __('View Performance') }}</inertia-link>
                                            <button @click="deleteSession(props.row.id)" class="action-item">{{ __('Delete') }}</button>
                                        </template>
                                    </actions-dropdown>
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
            </div>
        </div>
    </admin-layout>
</template>

<script>
    import AdminLayout from '@/Layouts/AdminLayout'
    import NoDataTable from "@/Components/NoDataTable";
    import ActionsDropdown from "@/Components/ActionsDropdown";

    export default {
        components: {
            AdminLayout,
            NoDataTable,
            ActionsDropdown
        },
        props: {
            practiceSet: Object,
            practiceSessions: Object,
            schedule: Object
        },
        data() {
            return {
                loading: false,
                columns: [
                    {
                        label: this.__('Test Taker'),
                        field: 'name',
                        sortable: false,
                    },
                    {
                        label: this.__('Completed On'),
                        field: 'completed',
                        sortable: false,
                    },
                    {
                        label: this.__('Points Earned'),
                        field: 'total_points_earned',
                        sortable: false,
                    },
                    {
                        label: this.__('Accuracy'),
                        field: 'accuracy',
                        sortable: false,
                    },
                    {
                        label: this.__('IP'),
                        field: 'ip',
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
                    }
                ],
                options: {
                    enabled: true,
                    mode: 'pages',
                    perPage: this.practiceSessions.meta.pagination.per_page,
                    setCurrentPage: this.practiceSessions.meta.pagination.current_page,
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
            toggleReport() {
                this.detailed = !this.detailed;
            },
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
            deleteSession(id) {
                this.$confirm.require({
                    header: this.__('Confirm Delete'),
                    message: this.__('User progress will be lost. Do you want to delete this session?'),
                    icon: 'pi pi-info-circle',
                    acceptClass: 'p-button-danger',
                    rejectLabel: this.__('Cancel'),
                    acceptLabel: this.__('Delete'),
                    accept: () => {
                        this.$inertia.delete(route('delete_practice_session', {practice_set: this.practiceSet.slug, session: id}), {}, {
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
        },
        metaInfo() {
            return {
                title: this.title
            }
        },
        computed: {
            title() {
                return this.practiceSet.title + ' '+this.__('Detailed Report')+' - ' + this.$page.props.general.app_name;
            },
        }
    }
</script>
