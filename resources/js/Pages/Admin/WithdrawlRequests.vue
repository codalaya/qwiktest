<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">{{ __('Withdrawl Requests') }}</h4>
        </template>
        <template #actions>
            <inertia-link :href="route('withdrawl-requests.create')" class="qt-btn qt-btn-success">
                {{ __('New') }} {{ __('Withdrawl REquest') }}
            </inertia-link>
        </template>

        <div class="container mx-auto py-8 px-4 sm:px-6 lg:px-8">
            <div class="card">
                <div class="card-body">
                    <vue-good-table mode="remote" @on-page-change="onPageChange" @on-column-filter="onColumnFilter"
                        @on-per-page-change="onPerPageChange" :pagination-options="options" :columns="columns"
                        :totalRows="requests.meta.pagination.total" :rows="requests.data" :rtl="$page.props.rtl">
                        <template slot="table-row" slot-scope="props">

                            <!-- Code Column -->
                            <div v-if="props.column.field === 'code'">
                                <Tag v-clipboard:copy="props.row.code" severity="info"
                                    v-clipboard:success="handleCopyStatus" :value="props.row.code" icon="pi pi-copy"
                                    class="w-full p-mr-2 mb-2 text-xs cursor-pointer" />
                            </div>

                            <!-- Status Column -->
                            <div v-else-if="props.column.field === 'status'">
                                <span
                                    :class="[props.row.status === 'completed' ? 'badge-success' : 'badge-danger', 'badge']">{{
                                        __(props.row.status) }}</span>
                            </div>

                            <!-- Actions Column -->
                            <div v-else-if="props.column.field === 'actions'">
                                <actions-dropdown>
                                    <template #actions>
                                        <button @click="editForm = true; currentId = props.row.id;" class="action-item">{{
                                            __('Edit')
                                        }}</button>
                                        <button @click="deleteRequest(props.row.id)" class="action-item">{{ __('Delete')
                                        }}</button>
                                    </template>
                                </actions-dropdown>
                            </div>

                            <!-- Remaining Columns -->
                            <span v-else>
                                {{ props.formattedRow[props.column.field] }}
                            </span>

                        </template>
                    </vue-good-table>

                    <Sidebar position="right" :visible.sync="editForm" class="p-sidebar-md">
                        <RequestForm :edit-flag.sync="editForm" :request-id="currentId" :form-errors="errors"
                            @close="editForm = false" :title="__('Edit') + ' ' + __('Request')" />
                    </Sidebar>
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
import Sidebar from 'primevue/sidebar'
import Toast from 'primevue/toast';
import Chip from 'primevue/chip';
import Tag from 'primevue/tag';
import Button from 'primevue/button';
import RequestForm from "@/Components/Forms/RequestForm";
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
        NoDataTable,
        RequestForm, Sidebar,
    },
    props: {
        requests: Object,
        errors: Object,
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
                    field: 'id',
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
                    label: this.__('User Name'),
                    field: 'user_name',
                    filterOptions: {
                        enabled: true,
                        placeholder: this.__('Search') + ' ' + this.__('Name'),
                        filterValue: null,
                        trigger: 'enter',
                    },
                    sortable: false,
                },
                {
                    label: this.__('Amount'),
                    field: 'amount',
                    filterOptions: {
                        enabled: true,
                        placeholder: this.__('Search') + ' ' + this.__('Amount'),
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
                        placeholder: this.__('Search') + ' ' + this.__('Status'),
                        filterValue: null,
                        filterDropdownItems: [{ value: 'completed', text: this.__('Completed') }, { value: 'pending', text: this.__('Pending') }],
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
                perPage: this.requests.meta.pagination.per_page,
                setCurrentPage: this.requests.meta.pagination.current_page,
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
            return this.__('Withdrawl Requests') + ' - ' + this.$page.props.general.app_name;
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

        goToSchedules(id) {
            this.$inertia.get(route('withdrawl-requests.schedules.index', { request: id }));
        },
        goToAnalytics(id) {
            this.$inertia.get(route('withdrawl-requests.overall_report', { request: id }));
        },
        deleteRequest(id) {
            this.$confirm.require({
                header: this.__('Confirm Delete'),
                message: this.__('This will remove all the user sessions. Do you want to delete this request?'),
                icon: 'pi pi-info-circle',
                acceptClass: 'p-button-danger',
                rejectLabel: this.__('Cancel'),
                acceptLabel: this.__('Delete'),
                accept: () => {
                    this.$inertia.delete(route('withdrawl-requests.destroy', { id: id }), {}, {
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
