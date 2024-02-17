<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">{{ __('Videos') }}</h4>
        </template>
        <template #actions>
            <inertia-link :href="route('videos.create')" class="qt-btn qt-btn-success">
                {{ __('New') }} {{ __('Video') }}
            </inertia-link>
        </template>

        <div class="container mx-auto py-8 px-4 sm:px-6 lg:px-8">
            <div class="card">
                <div class="card-body">
                    <vue-good-table mode="remote" @on-page-change="onPageChange" @on-column-filter="onColumnFilter" @on-per-page-change="onPerPageChange"
                                    :pagination-options="options" :columns="columns"
                                    :totalRows="videos.meta.pagination.total"
                                    :rows="videos.data" :rtl="$page.props.rtl">
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
                                        <button @click="editVideo(props.row.id)" class="action-item">{{ __('Edit') }}</button>
                                        <button @click="deleteVideo(props.row.id)" class="action-item">{{ __('Delete') }}</button>
                                    </template>
                                </actions-dropdown>
                            </div>

                            <!-- Remaining Columns -->
                            <span v-else>
                              {{props.formattedRow[props.column.field]}}
                            </span>
                        </template>

                        <div slot="emptystate">
                            <no-data-table />
                        </div>
                    </vue-good-table>
                </div>
            </div>
        </div>
    </admin-layout>
</template>

<script>
    import AdminLayout from '@/Layouts/AdminLayout'
    import ArcDropdown from '@/Components/Dropdown'
    import ArcDropdownLink from '@/Components/DropdownLink'
    import Toast from 'primevue/toast';
    import Chip from 'primevue/chip';
    import Tag from 'primevue/tag';
    import Button from 'primevue/button';
    import NoDataTable from "@/Components/NoDataTable";
    import ActionsDropdown from "@/Components/ActionsDropdown";
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
            videos: Object,
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
                            placeholder: this.__('Search') + ' ' + this.__('Title'),
                            filterValue: null,
                            trigger: 'enter',
                        },
                        sortable: false,
                        width: '11rem',
                    },
                    {
                        label: this.__('Type'),
                        field: 'type',
                        sortable: false,
                        filterOptions: {
                            enabled: true,
                            placeholder: this.__('Search') + ' '+ this.__('Type'),
                            filterValue: null,
                            filterDropdownItems: [{value: 'mp4', text: this.__('MP4')}, {value: 'youtube', text: this.__('Youtube')}, {value: 'vimeo', text: this.__('Vimeo')}],
                        },
                        width: '11rem',
                    },
                    {
                        label: this.__('Section'),
                        field: 'section',
                        sortable: false,
                        filterOptions: {
                            enabled: true,
                            placeholder: this.__('Search') + ' ' + this.__('Section'),
                            filterValue: null,
                            trigger: 'enter',
                        },
                    },
                    {
                        label: this.__('Skill'),
                        field: 'skill',
                        sortable: false,
                        filterOptions: {
                            enabled: true,
                            placeholder: this.__('Search') + ' ' + this.__('Skill'),
                            filterValue: null,
                            trigger: 'enter',
                        },
                    },
                    {
                        label: this.__('Topic'),
                        field: 'topic',
                        sortable: false,
                        filterOptions: {
                            enabled: true,
                            placeholder: this.__('Search') + ' ' + this.__('Topic'),
                            filterValue: null,
                            trigger: 'enter',
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
                            filterDropdownItems: [{value: 1, text: this.__('Active')}, {value: 0, text: this.__('In-active')}],
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
                    perPage: this.videos.meta.pagination.per_page,
                    setCurrentPage: this.videos.meta.pagination.current_page,
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
                return this.__('Videos')+' - ' + this.$page.props.general.app_name;
            }
        },
        methods: {
            updateParams(newProps) {
                this.serverParams = Object.assign({}, this.serverParams, newProps);
            },
            onPageChange(params) {
                this.updateParams({page: params.currentPage});
                this.loadItems();
                this.$nextTick(function() {
                    window.renderMathInElement(this.$el);
                });
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
            editVideo(id) {
                this.$inertia.get(route('videos.edit', {video: id}));
            },
            deleteVideo(id) {
                this.$confirm.require({
                    header: this.__('Confirm Delete'),
                    message: this.__('Do you want to delete this record?'),
                    icon: 'pi pi-info-circle',
                    acceptClass: 'p-button-danger',
                    rejectLabel: this.__('Cancel'),
                    acceptLabel: this.__('Delete'),
                    accept: () => {
                        this.$inertia.delete(route('videos.destroy', {id: id}), {}, {
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
        },
        created() {
            this.$nextTick(function() {
                window.renderMathInElement(this.$el);
            });
        }
    }
</script>
