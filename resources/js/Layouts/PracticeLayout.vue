<template>
    <div class="h-screen max-h-screen overflow-hidden flex flex-no-wrap bg-white select-none">
        <!-- Sidebar starts -->
        <div class="w-96 overflow-hidden absolute sm:relative bg-gray-800 shadow md:h-full flex-col justify-between hidden sm:flex sm:flex-col">
            <div class="z-30 h-16 w-full mx-auto absolute top-0 left-0 bg-gray-700 flex items-center px-4">
                <slot name="title"></slot>
            </div>
            <div v-if="$slots.actions" class="z-30 h-16 w-full mx-auto absolute top-16 left-0 bg-gray-800 flex justify-between items-center px-4">
                <slot name="actions"></slot>
            </div>
            <perfect-scrollbar :class="[$slots.actions ? 'pt-32' : 'pt-16']" class="h-screen max-h-screen px-4 pb-16" ref="scroll" :options="scrollbarOptions">
                <slot name="questions"></slot>
            </perfect-scrollbar>
            <div class="w-96 w-full absolute left-0 bottom-0 px-4 border-t border-gray-700">
                <slot name="footer"></slot>
            </div>
        </div>
        <div class="w-80 h-full z-40 fixed bg-gray-800 shadow md:h-full flex-col justify-between sm:hidden transition duration-150 ease-in-out" ref="mobileNav">
            <div v-if="moved" id="openSideBar" class="h-10 w-10 text-white bg-gray-800 absolute ltr:right-0 rtl:left-0 mt-3 ltr:-mr-10 rtl:-ml-10 flex items-center shadow ltr:rounded-tr ltr:rounded-br rtl:rounded-tl rtl:rounded-bl justify-center cursor-pointer" @click="sidebarHandler(true)">
                <svg class="w-6 h-6" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M0 0h24v24H0z" fill="none"/><path d="M3 13h2v-2H3v2zm0 4h2v-2H3v2zm0-8h2V7H3v2zm4 4h14v-2H7v2zm0 4h14v-2H7v2zM7 7v2h14V7H7z"/></svg>
            </div>
            <div v-if="!moved" id="closeSideBar" class="h-10 w-10 text-white bg-gray-800 absolute ltr:right-0 rtl:left-0 mt-3 z-50 ltr:mr-4 rtl:ml-4 flex items-center shadow rounded justify-center cursor-pointer" @click="sidebarHandler(true)">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path></svg>
            </div>
            <div class="z-30 h-16 w-full mx-auto absolute top-0 left-0 bg-gray-700 flex items-center px-4">
                <slot name="title"></slot>
            </div>
            <div v-if="$slots.actions" class="z-30 h-16 w-full mx-auto absolute top-16 left-0 bg-gray-800 flex justify-between items-center px-4">
                <slot name="actions"></slot>
            </div>
            <perfect-scrollbar :class="[$slots.actions ? 'pt-32' : 'pt-16']" class="h-screen max-h-screen overflow-hidden px-4 pb-16" ref="scroll" :options="scrollbarOptions">
                <slot name="questions"></slot>
            </perfect-scrollbar>
            <div class="w-full absolute bottom-0 px-8 border-t border-gray-700">
                <ul class="w-full flex items-center justify-between bg-gray-800">
                    <slot name="footer"></slot>
                </ul>
            </div>
        </div>
        <!-- Sidebar ends -->
        <div class="relative h-full container mx-auto md:w-4/5 w-full">
            <v-offline @detected-condition="detectOffline">
                <div v-if="!online" class="flex items-center z-50 p-2 bg-red-700 text-sm rounded shadow-md absolute top-5 right-5 text-white">
                    <svg class="w-6 h-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18.364 5.636a9 9 0 010 12.728m0 0l-2.829-2.829m2.829 2.829L21 21M15.536 8.464a5 5 0 010 7.072m0 0l-2.829-2.829m-4.243 2.829a4.978 4.978 0 01-1.414-2.83m-1.414 5.658a9 9 0 01-2.167-9.238m7.824 2.167a1 1 0 111.414 1.414m-1.414-1.414L3 3m8.293 8.293l1.414 1.414"></path></svg>
                    <span>{{ __('You are offline. Responses will not save.') }}</span>
                </div>
            </v-offline>
            <slot></slot>
        </div>
        <!-- Sidebar Backdrop -->
        <div class="fixed inset-0 z-30 w-screen h-screen bg-black bg-opacity-25 md:hidden" v-show="!moved" @click="sidebarHandler(false)"></div>
    </div>
</template>

<script>
    import { PerfectScrollbar } from 'vue2-perfect-scrollbar'
    export default {
        name: "PracticeLayout",
        components: {
            PerfectScrollbar
        },
        data() {
            return {
                moved: true,
                scrollbarOptions: {
                    maxScrollbarLength: 1,
                    suppressScrollX: true
                },
                online: true
            }
        },
        methods: {
            detectOffline(e) {
                this.online = e;
            },
            sidebarHandler() {
                // this.$refs.scroll.$el.scrollTop = 0;
                let sideBar = this.$refs.mobileNav;
                if (this.moved) {
                    sideBar.style.transform = "translateX(0px)";
                    this.moved = false;
                } else {
                    sideBar.style.transform = this.$page.props.rtl ? "translateX(320px)" : "translateX(-320px)";
                    this.moved = true;
                }
            },
        },
        mounted() {
            let sideBar = this.$refs.mobileNav;
            sideBar.style.transform = this.$page.props.rtl ? "translateX(320px)" : "translateX(-320px)";
        }
    };
</script>
