<template>
    <section>
        <div class="h-screen max-h-screen overflow-hidden select-none">
            <!-- Header starts -->
            <div class="w-full h-16 absolute z-30 top-0 ltr:right-0 rtl:left-0 mx-auto bg-gray-800 shadow-lg">
                <div class="w-full h-full mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="h-full flex flex-col justify-center items-center">
                        <div class="w-full flex items-center justify-end gap-4 sm:gap-0 sm:justify-between">
                            <div class="hidden sm:block">
                                <slot name="title"></slot>
                            </div>
                            <div class="flex items-center gap-4">
                                <div class="flex gap-1 bg-yellow-900 p-2 text-sm rounded-2xl">
                                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                                        version="1.1" class="h-5 w-5" viewBox="0 0 256 256" xml:space="preserve">
                                        <defs>
                                        </defs>
                                        <g style="stroke: none; stroke-width: 0; stroke-dasharray: none; stroke-linecap: butt; stroke-linejoin: miter; stroke-miterlimit: 10; fill: none; fill-rule: nonzero; opacity: 1;"
                                            transform="translate(1.4065934065934016 1.4065934065934016) scale(2.81 2.81)">
                                            <circle cx="45" cy="45" r="42"
                                                style="stroke: none; stroke-width: 1; stroke-dasharray: none; stroke-linecap: butt; stroke-linejoin: miter; stroke-miterlimit: 10; fill: rgb(239,165,0); fill-rule: nonzero; opacity: 1;"
                                                transform="  matrix(1 0 0 1 0 0) " />
                                            <path
                                                d="M 52.856 71.387 c -0.845 0 -1.685 -0.354 -2.277 -1.046 L 32.848 49.679 c -0.763 -0.89 -0.938 -2.142 -0.449 -3.207 c 0.49 -1.064 1.554 -1.747 2.726 -1.747 h 10.075 c 4.492 0 8.146 -3.654 8.146 -8.146 s -3.654 -8.146 -8.146 -8.146 H 35.125 c -1.657 0 -3 -1.343 -3 -3 s 1.343 -3 3 -3 h 10.075 c 7.801 0 14.146 6.346 14.146 14.146 S 53 50.725 45.199 50.725 h -3.547 l 13.479 15.708 c 1.079 1.258 0.935 3.151 -0.322 4.23 C 54.243 71.149 53.548 71.387 52.856 71.387 z"
                                                style="stroke: none; stroke-width: 1; stroke-dasharray: none; stroke-linecap: butt; stroke-linejoin: miter; stroke-miterlimit: 10; fill: rgb(246,142,0); fill-rule: nonzero; opacity: 1;"
                                                transform=" matrix(1 0 0 1 0 0) " stroke-linecap="round" />
                                            <path
                                                d="M 62.876 28.432 H 35.125 c -1.657 0 -3 -1.343 -3 -3 s 1.343 -3 3 -3 h 27.751 c 1.657 0 3 1.343 3 3 S 64.533 28.432 62.876 28.432 z"
                                                style="stroke: none; stroke-width: 1; stroke-dasharray: none; stroke-linecap: butt; stroke-linejoin: miter; stroke-miterlimit: 10; fill: rgb(246,142,0); fill-rule: nonzero; opacity: 1;"
                                                transform=" matrix(1 0 0 1 0 0) " stroke-linecap="round" />
                                            <path
                                                d="M 62.876 39.578 H 35.125 c -1.657 0 -3 -1.343 -3 -3 s 1.343 -3 3 -3 h 27.751 c 1.657 0 3 1.343 3 3 S 64.533 39.578 62.876 39.578 z"
                                                style="stroke: none; stroke-width: 1; stroke-dasharray: none; stroke-linecap: butt; stroke-linejoin: miter; stroke-miterlimit: 10; fill: rgb(246,142,0); fill-rule: nonzero; opacity: 1;"
                                                transform=" matrix(1 0 0 1 0 0) " stroke-linecap="round" />
                                            <path
                                                d="M 46.732 83.853 C 26.752 82.186 11 65.403 11 45 S 26.752 7.814 46.732 6.147 V 0.132 C 23.44 1.813 5 21.287 5 45 c 0 23.713 18.44 43.187 41.732 44.868 V 83.853 z"
                                                style="stroke: none; stroke-width: 1; stroke-dasharray: none; stroke-linecap: butt; stroke-linejoin: miter; stroke-miterlimit: 10; fill: rgb(246,142,0); fill-rule: nonzero; opacity: 1;"
                                                transform=" matrix(1 0 0 1 0 0) " stroke-linecap="round" />
                                            <path
                                                d="M 45 90 C 20.187 90 0 69.813 0 45 C 0 20.187 20.187 0 45 0 c 24.813 0 45 20.187 45 45 C 90 69.813 69.813 90 45 90 z M 45 6 C 23.495 6 6 23.495 6 45 s 17.495 39 39 39 s 39 -17.495 39 -39 S 66.505 6 45 6 z"
                                                style="stroke: none; stroke-width: 1; stroke-dasharray: none; stroke-linecap: butt; stroke-linejoin: miter; stroke-miterlimit: 10; fill: rgb(255,222,80); fill-rule: nonzero; opacity: 1;"
                                                transform=" matrix(1 0 0 1 0 0) " stroke-linecap="round" />
                                            <path
                                                d="M 48.856 71.387 c -0.845 0 -1.685 -0.354 -2.277 -1.046 L 28.848 49.679 c -0.763 -0.89 -0.938 -2.142 -0.449 -3.207 c 0.49 -1.064 1.554 -1.747 2.726 -1.747 h 10.075 c 4.492 0 8.146 -3.654 8.146 -8.146 s -3.654 -8.146 -8.146 -8.146 H 31.125 c -1.657 0 -3 -1.343 -3 -3 s 1.343 -3 3 -3 h 10.075 c 7.801 0 14.146 6.346 14.146 14.146 S 49 50.725 41.199 50.725 h -3.547 l 13.479 15.708 c 1.079 1.258 0.935 3.151 -0.322 4.23 C 50.243 71.149 49.548 71.387 48.856 71.387 z"
                                                style="stroke: none; stroke-width: 1; stroke-dasharray: none; stroke-linecap: butt; stroke-linejoin: miter; stroke-miterlimit: 10; fill: rgb(255,222,80); fill-rule: nonzero; opacity: 1;"
                                                transform=" matrix(1 0 0 1 0 0) " stroke-linecap="round" />
                                            <path
                                                d="M 58.876 28.432 H 31.125 c -1.657 0 -3 -1.343 -3 -3 s 1.343 -3 3 -3 h 27.751 c 1.657 0 3 1.343 3 3 S 60.533 28.432 58.876 28.432 z"
                                                style="stroke: none; stroke-width: 1; stroke-dasharray: none; stroke-linecap: butt; stroke-linejoin: miter; stroke-miterlimit: 10; fill: rgb(255,222,80); fill-rule: nonzero; opacity: 1;"
                                                transform=" matrix(1 0 0 1 0 0) " stroke-linecap="round" />
                                            <path
                                                d="M 58.876 39.578 H 31.125 c -1.657 0 -3 -1.343 -3 -3 s 1.343 -3 3 -3 h 27.751 c 1.657 0 3 1.343 3 3 S 60.533 39.578 58.876 39.578 z"
                                                style="stroke: none; stroke-width: 1; stroke-dasharray: none; stroke-linecap: butt; stroke-linejoin: miter; stroke-miterlimit: 10; fill: rgb(255,222,80); fill-rule: nonzero; opacity: 1;"
                                                transform=" matrix(1 0 0 1 0 0) " stroke-linecap="round" />
                                        </g>
                                    </svg>
                                    <div class="text-white">{{ currentScore }}</div>
                                </div>
                                <div class="flex gap-1 bg-green-900 p-2 text-sm rounded-2xl">
                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512"
                                        class="h-5 w-5 fill-white">
                                        <path
                                            d="M353.8 54.1L330.2 6.3c-3.9-8.3-16.1-8.6-20.4 0L286.2 54.1l-52.3 7.5c-9.3 1.4-13.3 12.9-6.4 19.8l38 37-9 52.1c-1.4 9.3 8.2 16.5 16.8 12.2l46.9-24.8 46.6 24.4c8.6 4.3 18.3-2.9 16.8-12.2l-9-52.1 38-36.6c6.8-6.8 2.9-18.3-6.4-19.8l-52.3-7.5zM256 256c-17.7 0-32 14.3-32 32V480c0 17.7 14.3 32 32 32H384c17.7 0 32-14.3 32-32V288c0-17.7-14.3-32-32-32H256zM32 320c-17.7 0-32 14.3-32 32V480c0 17.7 14.3 32 32 32H160c17.7 0 32-14.3 32-32V352c0-17.7-14.3-32-32-32H32zm416 96v64c0 17.7 14.3 32 32 32H608c17.7 0 32-14.3 32-32V416c0-17.7-14.3-32-32-32H480c-17.7 0-32 14.3-32 32z" />
                                    </svg>
                                    <div class="text-white">{{ currentRank }}</div>
                                </div>
                                <button @click="toggleFullScreen"
                                    class="hidden sm:block focus:outline-none text-white text-sm bg-gray-700 hover:bg-gray-600 rounded-sm p-2">
                                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                                        xmlns="http://www.w3.org/2000/svg">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M4 8V4m0 0h4M4 4l5 5m11-1V4m0 0h-4m4 0l-5 5M4 16v4m0 0h4m-4 0l5-5m11 5l-5-5m5 5v-4m0 4h-4">
                                        </path>
                                    </svg>
                                </button>
                                <h4 class="flex items-center text-white text-sm bg-gray-700 rounded-sm px-4 py-2">
                                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                                        xmlns="http://www.w3.org/2000/svg">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                    </svg>
                                    <slot name="timer"></slot>
                                </h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Header ends -->
            <!-- Section starts -->
            <div
                class="z-20 h-16 w-full mx-auto absolute top-16 left-0 bg-white border-b border-gray-200 flex justify-between items-center px-4 sm:px-6 lg:px-8">
                <slot name="sections"></slot>
            </div>
            <!-- Section ends -->
            <div class="flex flex-no-wrap bg-white">
                <div class="relative h-full container mx-auto md:w-4/5 w-full">
                    <v-offline @detected-condition="detectOffline">
                        <div v-if="!online"
                            class="flex items-center z-50 p-2 bg-red-700 text-sm rounded shadow-md absolute top-5 right-5 text-white">
                            <svg class="w-6 h-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                                xmlns="http://www.w3.org/2000/svg">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M18.364 5.636a9 9 0 010 12.728m0 0l-2.829-2.829m2.829 2.829L21 21M15.536 8.464a5 5 0 010 7.072m0 0l-2.829-2.829m-4.243 2.829a4.978 4.978 0 01-1.414-2.83m-1.414 5.658a9 9 0 01-2.167-9.238m7.824 2.167a1 1 0 111.414 1.414m-1.414-1.414L3 3m8.293 8.293l1.414 1.414">
                                </path>
                            </svg>
                            <span>{{ __('You are offline. Responses will not save.') }}</span>
                        </div>
                    </v-offline>
                    <slot></slot>
                </div>
                <!-- Sidebar starts -->
                <div
                    class="md:w-96 overflow-hidden absolute sm:relative md:h-full flex-col justify-between hidden border-l border-gray-100 sm:flex sm:flex-col transition duration-150 ease-in-out">
                    <div class="z-20 h-16 w-full mx-auto absolute top-0 right-0 flex items-center px-4 shadow"></div>
                    <div
                        class="z-20 h-16 w-full mx-auto absolute top-16 ltr:left-0 rtl:right-0 bg-white border-b border-l border-gray-200 flex ltr:flex-row rtl:flex-row-reverse justify-between items-center px-4 sm:px-6 lg:px-8">
                        <slot name="actions"></slot>
                    </div>
                    <perfect-scrollbar
                        class="h-screen max-h-screen px-4 sm:px-6 lg:px-8 pt-32 pb-72 bg-gray-50 border-l border-gray-200"
                        ref="scroll" :options="scrollbarOptions">
                        <slot name="questions"></slot>
                    </perfect-scrollbar>
                    <div
                        class="md:w-96 w-full absolute left-0 bottom-16 px-4 sm:px-6 lg:px-8 bg-white border-t border-l border-gray-200">
                        <slot name="stats"></slot>
                    </div>
                    <div
                        class="md:w-96 w-full absolute left-0 bottom-0 px-4 sm:px-6 lg:px-8 bg-white border-t border-l border-gray-200">
                        <slot name="footer"></slot>
                    </div>
                </div>
                <div class="w-80 h-full z-40 absolute bg-gray-50 shadow md:h-full flex-col justify-between sm:hidden transition duration-150 ease-in-out"
                    ref="mobileNav">
                    <div v-if="moved" id="openSideBar"
                        class="h-10 w-10 text-white bg-gray-800 absolute ltr:right-0 rtl:left-0 mt-3 ltr:-mr-10 rtl:-ml-10 flex items-center shadow ltr:rounded-tr ltr:rounded-br rtl:rounded-tl rtl:rounded-bl justify-center cursor-pointer"
                        @click="sidebarHandler(true)">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                            xmlns="http://www.w3.org/2000/svg">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M8.228 9c.549-1.165 2.03-2 3.772-2 2.21 0 4 1.343 4 3 0 1.4-1.278 2.575-3.006 2.907-.542.104-.994.54-.994 1.093m0 3h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z">
                            </path>
                        </svg>
                    </div>
                    <div v-if="!moved" id="closeSideBar"
                        class="h-10 w-10 text-white bg-gray-800 absolute ltr:right-0 rtl:left-0 mt-3 z-50 ltr:mr-4 rtl:ml-4 flex items-center shadow rounded justify-center cursor-pointer"
                        @click="sidebarHandler(true)">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                            xmlns="http://www.w3.org/2000/svg">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12">
                            </path>
                        </svg>
                    </div>
                    <div class="z-30 h-16 w-full mx-auto absolute top-0 left-0 bg-gray-800 shadow flex items-center px-4">
                        <slot name="title"></slot>
                    </div>
                    <div
                        class="z-20 h-16 w-full mx-auto absolute top-16 left-0 bg-gray-50 border-b border-gray-200 flex ltr:flex-row rtl:flex-row-reverse justify-between items-center px-4">
                        <slot name="actions"></slot>
                    </div>
                    <perfect-scrollbar class="h-screen max-h-screen overflow-hidden px-4 pt-32 pb-72" ref="scroll"
                        :options="scrollbarOptions">
                        <slot name="questions"></slot>
                    </perfect-scrollbar>
                    <div class="w-full absolute bottom-16 border-t border-gray-200 bg-white px-4">
                        <slot name="stats"></slot>
                    </div>
                    <div class="w-full absolute bottom-0 border-t border-gray-200 bg-white px-4">
                        <slot name="footer"></slot>
                    </div>
                </div>
                <!-- Sidebar ends -->
            </div>

        </div>
        <Toast position="bottom-right" />
    </section>
</template>

<script>
import { PerfectScrollbar } from 'vue2-perfect-scrollbar'
import Toast from 'primevue/toast';
import { mapState } from 'vuex';

export default {
    name: "QuizLayout",
    components: {
        PerfectScrollbar,
        Toast
    },
    data() {
        return {
            moved: true,
            fullScreen: false,
            scrollbarOptions: {
                maxScrollbarLength: 1,
                suppressScrollX: true
            },
            online: true
        }
    },
    computed: {
        ...mapState('quiz', {
            currentScore: state => state.currentScore,
            currentRank: state => state.currentRank,
        })
    },
    methods: {
        detectOffline(e) {
            this.online = e;
        },
        sidebarHandler() {
            let sideBar = this.$refs.mobileNav;
            if (this.moved) {
                sideBar.style.transform = "translateX(0px)";
                this.moved = false;
            } else {
                sideBar.style.transform = this.$page.props.rtl ? "translateX(320px)" : "translateX(-320px)";
                this.moved = true;
            }
        },
        toggleFullScreen() {
            !this.fullScreen ? this.openFullScreen() : this.closeFullScreen();
            this.fullScreen = !this.fullScreen;
        },
        openFullScreen() {
            let elem = document.documentElement;
            if (elem.requestFullscreen) {
                elem.requestFullscreen();
            } else if (elem.mozRequestFullScreen) { /* Firefox */
                elem.mozRequestFullScreen();
            } else if (elem.webkitRequestFullscreen) { /* Chrome, Safari and Opera */
                elem.webkitRequestFullscreen();
            } else if (elem.msRequestFullscreen) { /* IE/Edge */
                elem.msRequestFullscreen();
            }
        },
        closeFullScreen() {
            if (document.exitFullscreen) {
                document.exitFullscreen();
            } else if (document.mozCancelFullScreen) { /* Firefox */
                document.mozCancelFullScreen();
            } else if (document.webkitExitFullscreen) { /* Chrome, Safari and Opera */
                document.webkitExitFullscreen();
            } else if (document.msExitFullscreen) { /* IE/Edge */
                document.msExitFullscreen();
            }
        },

    },
    mounted() {
        let sideBar = this.$refs.mobileNav;
        console.log(window.innerHeight, window.innerWidth);

        if (window.innerWidth <= 800) {
            console.log('hiding sidebar here.')
            sideBar.style.transform = this.$page.props.rtl ? "translateX(320px)" : "translateX(-320px)";
        }
    }
}
</script>
