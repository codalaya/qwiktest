<template>
    <div class="bg-white rounded p-6 shadow">
        <h4 class="pb-4 text-sm font-semibold uppercase text-gray-800">{{ __('Quick Links') }}</h4>
        <div class="grid grid-cols-1 sm:grid-cols-2 flex justify-between items-center">
            <ul>
                <li class="mb-2"><inertia-link class="qt-link-success" :href="route('quizzes.index')">{{ __('New Quiz Schedule') }}</inertia-link></li>
                <li class="mb-2"><inertia-link class="qt-link-success" :href="route('quizzes.create')">{{ __('Create New Quiz') }}</inertia-link></li>
                <li class="mb-2"><inertia-link class="qt-link-success" :href="route('practice-sets.create')">{{ __('Create Practice Set') }}</inertia-link></li>
                <li class="mb-2"><inertia-link class="qt-link-success" :href="route('quizzes.index')">{{ __('View Quizzes') }}</inertia-link></li>
                <li class="mb-2"><inertia-link class="qt-link-success" :href="route('practice-sets.index')">{{ __('View Practice Sets') }}</inertia-link></li>
            </ul>
            <ul>
                <li class="mb-2"><inertia-link class="qt-link-success" :href="route('questions.index')">{{ __('Create New Question') }}</inertia-link></li>
                <li class="mb-2"><inertia-link class="qt-link-success" :href="route('initiate_import_questions')">{{ __('Import Questions') }}</inertia-link></li>
                <li class="mb-2"><inertia-link class="qt-link-success" :href="route('comprehensions.index')">{{ __('Create New Comprehension') }}</inertia-link></li>
                <li class="mb-2"><inertia-link class="qt-link-success" :href="route('skills.index')">{{ __('Create New Skill') }}</inertia-link></li>
                <li class="mb-2"><inertia-link class="qt-link-success" :href="route('topics.index')">{{ __('Create New Topic') }}</inertia-link></li>
            </ul>
        </div>
    </div>
</template>
