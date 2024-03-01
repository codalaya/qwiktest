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
                                <arc-label for="rank1" :value="__('Rank 1 Reward')" />
                                <arc-input id="rank1" type="number" class="mt-1 block w-full" v-model="form.rank1" />
                                <arc-input-error :message="form.errors.rank1" class="mt-2" />
                            </div>

                            <div class="col-span-6 sm:col-span-4">
                                <arc-label for="rank2" :value="__('Rank 2 Reward')" />
                                <arc-input id="rank2" type="number" class="mt-1 block w-full" v-model="form.rank2" />
                                <arc-input-error :message="form.errors.rank2" class="mt-2" />
                            </div>

                            <div class="col-span-6 sm:col-span-4">
                                <arc-label for="rank3" :value="__('Rank 3 Reward')" />
                                <arc-input id="rank3" type="number" class="mt-1 block w-full" v-model="form.rank3" />
                                <arc-input-error :message="form.errors.rank3" class="mt-2" />
                            </div>

                            <div class="col-span-6 sm:col-span-4">
                                <arc-label for="rank4" :value="__('Rank 4 Reward')" />
                                <arc-input id="rank4" type="number" class="mt-1 block w-full" v-model="form.rank4" />
                                <arc-input-error :message="form.errors.rank4" class="mt-2" />
                            </div>

                            <div class="col-span-6 sm:col-span-4">
                                <arc-label for="rank5" :value="__('Rank 5 Reward')" />
                                <arc-input id="rank5" type="number" class="mt-1 block w-full" v-model="form.rank5" />
                                <arc-input-error :message="form.errors.rank5" class="mt-2" />
                            </div>

                            <div class="col-span-6 sm:col-span-4">
                                <arc-label for="rank6" :value="__('Rank 6 Reward')" />
                                <arc-input id="rank6" type="number" class="mt-1 block w-full" v-model="form.rank6" />
                                <arc-input-error :message="form.errors.rank6" class="mt-2" />
                            </div>

                            <div class="col-span-6 sm:col-span-4">
                                <arc-label for="rank7" :value="__('Rank 7 Reward')" />
                                <arc-input id="rank7" type="number" class="mt-1 block w-full" v-model="form.rank7" />
                                <arc-input-error :message="form.errors.rank7" class="mt-2" />
                            </div>

                            <div class="col-span-6 sm:col-span-4">
                                <arc-label for="rank8" :value="__('Rank 8 Reward')" />
                                <arc-input id="rank8" type="number" class="mt-1 block w-full" v-model="form.rank8" />
                                <arc-input-error :message="form.errors.rank8" class="mt-2" />
                            </div>

                            <div class="col-span-6 sm:col-span-4">
                                <arc-label for="rank9" :value="__('Rank 9 Reward')" />
                                <arc-input id="rank9" type="number" class="mt-1 block w-full" v-model="form.rank9" />
                                <arc-input-error :message="form.errors.rank9" class="mt-2" />
                            </div>

                            <div class="col-span-6 sm:col-span-4">
                                <arc-label for="rank10" :value="__('Rank 10 Reward')" />
                                <arc-input id="rank10" type="number" class="mt-1 block w-full" v-model="form.rank10" />
                                <arc-input-error :message="form.errors.rank10" class="mt-2" />
                            </div>

                            <div class="col-span-6 sm:col-span-4">
                                <arc-label for="rankUpto20" :value="__('Below 10 Rank Up to 20 Reward')" />
                                <arc-input id="rankUpto20" type="number" class="mt-1 block w-full"
                                    v-model="form.rankUpto20" />
                                <arc-input-error :message="form.errors.rankUpto20" class="mt-2" />
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
        rank1: Number,
        rank2: Number,
        rank3: Number,
        rank4: Number,
        rank5: Number,
        rank6: Number,
        rank7: Number,
        rank8: Number,
        rank9: Number,
        rank10: Number,
        rankUpto20: Number,
    },
    data() {
        return {
            form: this.$inertia.form({
                rank1: this.rank1 ?? 0,
                rank2: this.rank2 ?? 0,
                rank3: this.rank3 ?? 0,
                rank4: this.rank4 ?? 0,
                rank5: this.rank5 ?? 0,
                rank6: this.rank6 ?? 0,
                rank7: this.rank7 ?? 0,
                rank8: this.rank8 ?? 0,
                rank9: this.rank9 ?? 0,
                rank10: this.rank10 ?? 0,
                rankUpto20: this.rankUpto20 ?? 0,
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
