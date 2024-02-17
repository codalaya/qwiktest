<template>
    <div class="relative inline-block ltr:text-left rtl:text-right">
        <div>
            <button @click="open = ! open" type="button" class="inline-flex justify-center w-full rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none" id="menu-button" aria-expanded="true" aria-haspopup="true">
                {{ __('Actions') }}
                <!-- Heroicon name: solid/chevron-down -->
                <svg class="ltr:-mr-1 ltr:ml-2 rtl:mr-2 rtl:-ml-1 h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                    <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
                </svg>
            </button>
        </div>
        <!-- Full Screen Dropdown Overlay -->
        <div v-show="open" class="fixed inset-0 z-40" @click="open = false">
        </div>
        <div @click="open = ! open" v-show="open" class="z-40 origin-top-right absolute right-0 mt-2 w-56 rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5 focus:outline-none" role="menu" aria-orientation="vertical" aria-labelledby="menu-button" tabindex="-1">
            <div class="py-1" role="none">
                <slot name="actions"></slot>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "ActionsDropdown",
        data() {
            return {
                open: false
            }
        }
    }
</script>

<style scoped>

</style>
