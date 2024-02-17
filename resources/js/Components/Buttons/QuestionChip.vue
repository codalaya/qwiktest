<template>
    <div :class="[chipClasses, borderClasses]" class="q-chip relative text-sm flex flex-col items-center justify-between border border-b-0 rounded-sm">
        <span :class="[textClasses]" class="q-chip-sno flex justify-center items-center">{{ sno }}</span>
        <span :class="[statusClasses,borderClasses]" class="q-chip-status overflow-hidden text-white absolute bottom-0 h-3 rounded-bl-sm rounded-br-sm"></span>
    </div>
</template>
<script>
    export default {
        name: "QuestionChip",
        props: {
            sno: Number|String,
            status: {
                type: String,
                default: ''
            },
            isActive: {
                type: Boolean,
                default: false
            }
        },
        computed: {
            statusClasses() {
                switch(this.status) {
                    case 'success':
                        return 'bg-green-400';
                    case 'warning':
                        return 'bg-purple-400';
                    case 'caution':
                        return 'bg-yellow-400';
                    case 'danger':
                        return 'bg-red-400';
                    default:
                    return 'bg-gray-400'
                }
            },
            chipClasses() {
                return this.isActive ? 'bg-gray-100': '';
            },
            textClasses() {
                return this.isActive ? 'text-gray-800': 'text-gray-400';
            },
            borderClasses() {
                switch(this.status) {
                    case 'success':
                        return 'border-green-400';
                    case 'warning':
                        return 'border-purple-400';
                    case 'caution':
                        return 'border-yellow-400';
                    case 'danger':
                        return 'border-red-400';
                    default:
                        return 'border-gray-400'
                }
            }
        },
    }
</script>
<style scoped>
    .q-chip {
        width: 40px;
        height: 40px;
    }
    .q-chip-sno {
        width: 40px;
        height: 30px;
    }
    .q-chip-status {
        width: 40px;
        height: 10px;
    }
</style>
