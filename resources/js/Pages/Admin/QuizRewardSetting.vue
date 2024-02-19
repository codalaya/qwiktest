<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">{{ __('Quiz Prize Settings') }}</h4>
        </template>

        <div class="container mx-auto py-8 px-4 sm:px-6 lg:px-8">
            <div class="card">
                <div class="card-body">
                    <arc-form-section @submitted="updateSettings">
                        <template #title>
                            {{ __('Quiz Prize Settings') }}
                        </template>

                        <template #form>


                            <div class="col-span-6 sm:col-span-4">
                                <arc-label for="rankOne" :value="__('Rank 1 Reward')" />
                                <arc-input id="rankOne" type="number" class="mt-1 block w-full" v-model="form.rankOne" />
                                <arc-input-error :message="form.errors.rankOne" class="mt-2" />
                            </div>

                            <div class="col-span-6 sm:col-span-4">
                                <arc-label for="rankTwo" :value="__('Rank 2 Reward')" />
                                <arc-input id="rankTwo" type="number" class="mt-1 block w-full" v-model="form.rankTwo" />
                                <arc-input-error :message="form.errors.rankTwo" class="mt-2" />
                            </div>

                            <div class="col-span-6 sm:col-span-4">
                                <arc-label for="rankThree" :value="__('Rank 3 Reward')" />
                                <arc-input id="rankThree" type="number" class="mt-1 block w-full"
                                    v-model="form.rankThree" />
                                <arc-input-error :message="form.errors.rankThree" class="mt-2" />
                            </div>

                            <div class="col-span-6 sm:col-span-4">
                                <arc-label for="above10Rank" :value="__('Above 10 Rank Reward')" />
                                <arc-input id="above10Rank" type="number" class="mt-1 block w-full"
                                    v-model="form.above10Rank" />
                                <arc-input-error :message="form.errors.above10Rank" class="mt-2" />
                            </div>
                        </template>

                        <template #actions>
                            <arc-action-message :on="form.recentlySuccessful" class="mr-3">
                                {{ __('Saved') }}.
                            </arc-action-message>

                            <arc-button :class="{ 'opacity-25': form.processing }" :disabled="form.processing">
                                {{ __('Save') }}
                            </arc-button>
                        </template>
                    </arc-form-section>
                </div>
            </div>
        </div>


    </admin-layout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout'
import ArcActionMessage from "@/Components/ActionMessage";
import ArcButton from "@/Components/Button";
import ArcFormSection from "@/Components/FormSection";
import ArcInput from "@/Components/Input";
import ArcInputError from "@/Components/InputError";
import ArcLabel from "@/Components/Label";
import ArcSecondaryButton from "@/Components/SecondaryButton";

export default {
    name: 'QuizRewardSetting',
    components: {
        AdminLayout,
        ArcActionMessage,
        ArcButton,
        ArcFormSection,
        ArcInput,
        ArcInputError,
        ArcLabel,
        ArcSecondaryButton,
    },
    props: {
        rankOne: Number,
        rankTwo: Number,
        rankThree: Number,
        above10Rank: Number,
    },
    data() {
        return {
            form: this.$inertia.form({
                rankOne: this.rankOne ?? 0,
                rankTwo: this.rankTwo ?? 0,
                rankThree: this.rankThree ?? 0,
                above10Rank: this.above10Rank ?? 0,
            })
        }
    },
    methods: {
        updateSettings() {
            this.form.post(route('quizzes.update_quiz_rewards'), { preserveScroll: true })
        }
    }
}
</script>
