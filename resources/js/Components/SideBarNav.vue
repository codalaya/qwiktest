<template>
    <nav :class="{'flex-1 bg-primary': !isMobile}" class="relative px-4 space-y-3">
        <!-- <div class="bg-gray-100 bg-opacity-10 rounded-md py-3 px-4">
            <h4 class="text-white text-base font-semibold">{{ $page.props.currentCategory ? $page.props.currentCategory.name : __('No Syllabus Selected')}}</h4>
            <inertia-link :href="route('change_syllabus')" class="text-secondary underline text-sm">
                {{ $page.props.currentCategory ? __('Change Syllabus') : __('Choose Syllabus') }}
            </inertia-link>
        </div> -->
        <inertia-link :href="route('user_dashboard')"
                      :class="[route().current() === 'user_dashboard' ? 'bg-secondary text-white' : 'text-white hover:bg-secondary hover:text-white']"
                      class="group rounded-md md py-3 px-4 flex items-center text-base font-semibold">
            <svg :class="[route().current() === 'user_dashboard' ? 'text-white' : 'text-secondary']" class="group-hover:text-white ltr:mr-3 rtl:ml-3 flex-shrink-0 h-6 w-6" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M0 0h24v24H0V0z" fill="none"/><path d="M19 5v2h-4V5h4M9 5v6H5V5h4m10 8v6h-4v-6h4M9 17v2H5v-2h4M21 3h-8v6h8V3zM11 3H3v10h8V3zm10 8h-8v10h8V11zm-10 4H3v6h8v-6z"/></svg>
            {{ __('Dashboard') }}
        </inertia-link>

        <!-- <inertia-link :href="route('learn_practice')"
                      :class="[route().current() === 'learn_practice' ? 'bg-secondary text-white' : 'text-white hover:bg-secondary hover:text-white']"
                      class="group rounded-md py-3 px-4 flex items-center text-base font-semibold">
            <svg :class="[route().current() === 'learn_practice' ? 'text-white' : 'text-secondary']" class="group-hover:text-white ltr:mr-3 rtl:ml-3 flex-shrink-0 h-6 w-6" xmlns="http://www.w3.org/2000/svg" enable-background="new 0 0 24 24" viewBox="0 0 24 24" fill="currentColor"><g><path d="M0,0h24v24H0V0z" fill="none"/></g><g><path d="M5,20V4h2v7l2.5-1.5L12,11V4h5v7.08c0.33-0.05,0.66-0.08,1-0.08s0.67,0.03,1,0.08V4c0-1.1-0.9-2-2-2H5C3.9,2,3,2.9,3,4v16 c0,1.1,0.9,2,2,2h7.26c-0.42-0.6-0.75-1.28-0.97-2H5z M18,13c-2.76,0-5,2.24-5,5s2.24,5,5,5s5-2.24,5-5S20.76,13,18,13z M16.75,20.5v-5l4,2.5L16.75,20.5z"/></g></svg>
            {{ __('Learn & Practice') }}
        </inertia-link> -->

        <!-- <inertia-link :href="route('exam_dashboard')"
                      :class="[route().current() === 'exam_dashboard' ? 'bg-secondary text-white' : 'text-white hover:bg-secondary hover:text-white']"
                      class="group rounded-md py-3 px-4 flex items-center text-base font-semibold">
            <svg :class="[route().current() === 'exam_dashboard' ? 'text-white' : 'text-secondary']" class="group-hover:text-white ltr:mr-3 rtl:ml-3 flex-shrink-0 h-6 w-6" xmlns="http://www.w3.org/2000/svg" enable-background="new 0 0 24 24" viewBox="0 0 24 24" fill="currentColor"><path d="M10 11H18V9H10ZM10 14H14V12H10ZM10 8H18V6H10ZM8 18Q7.175 18 6.588 17.413Q6 16.825 6 16V4Q6 3.175 6.588 2.587Q7.175 2 8 2H20Q20.825 2 21.413 2.587Q22 3.175 22 4V16Q22 16.825 21.413 17.413Q20.825 18 20 18ZM8 16H20Q20 16 20 16Q20 16 20 16V4Q20 4 20 4Q20 4 20 4H8Q8 4 8 4Q8 4 8 4V16Q8 16 8 16Q8 16 8 16ZM8 4Q8 4 8 4Q8 4 8 4V16Q8 16 8 16Q8 16 8 16Q8 16 8 16Q8 16 8 16V4Q8 4 8 4Q8 4 8 4ZM4 22Q3.175 22 2.588 21.413Q2 20.825 2 20V6H4V20Q4 20 4 20Q4 20 4 20H18V22Z"/></svg>
            {{ __('Exams') }}
        </inertia-link> -->

        <inertia-link :href="route('quiz_dashboard')"
                      :class="[route().current() === 'quiz_dashboard' ? 'bg-secondary text-white' : 'text-white hover:bg-secondary hover:text-white']"
                      class="group rounded-md py-3 px-4 flex items-center text-base font-semibold">
            <svg :class="[route().current() === 'quiz_dashboard' ? 'text-white' : 'text-secondary']" class="group-hover:text-white ltr:mr-3 rtl:ml-3 flex-shrink-0 h-6 w-6" xmlns="http://www.w3.org/2000/svg" enable-background="new 0 0 24 24" viewBox="0 0 24 24" fill="currentColor"><g><path d="M0,0h24v24H0V0z" fill="none"/></g><g><path d="M4,6H2v14c0,1.1,0.9,2,2,2h14v-2H4V6z M20,2H8C6.9,2,6,2.9,6,4v12c0,1.1,0.9,2,2,2h12c1.1,0,2-0.9,2-2V4 C22,2.9,21.1,2,20,2z M20,16H8V4h12V16z M13.51,10.16c0.41-0.73,1.18-1.16,1.63-1.8c0.48-0.68,0.21-1.94-1.14-1.94 c-0.88,0-1.32,0.67-1.5,1.23l-1.37-0.57C11.51,5.96,12.52,5,13.99,5c1.23,0,2.08,0.56,2.51,1.26c0.37,0.6,0.58,1.73,0.01,2.57 c-0.63,0.93-1.23,1.21-1.56,1.81c-0.13,0.24-0.18,0.4-0.18,1.18h-1.52C13.26,11.41,13.19,10.74,13.51,10.16z M12.95,13.95 c0-0.59,0.47-1.04,1.05-1.04c0.59,0,1.04,0.45,1.04,1.04c0,0.58-0.44,1.05-1.04,1.05C13.42,15,12.95,14.53,12.95,13.95z"/></g></svg>
            {{ __('Quizzes') }}
        </inertia-link>

        <inertia-link :href="route('my_progress')"
                      :class="[route().current() === 'my_progress' ? 'bg-secondary text-white' : 'text-white hover:bg-secondary hover:text-white']"
                      class="group rounded-md py-3 px-4 flex items-center text-base font-semibold">
            <svg :class="[route().current() === 'my_progress' ? 'text-white' : 'text-secondary']" class="group-hover:text-white ltr:mr-3 rtl:ml-3 flex-shrink-0 h-6 w-6" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M0 0h24v24H0V0z" fill="none"/><path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm0 16H5V5h14v14zM7 10h2v7H7zm4-3h2v10h-2zm4 6h2v4h-2z"/></svg>
            {{ __('My Progress') }}
        </inertia-link>
    </nav>
</template>
<script>
    export default {
        name: "SideBarNav",
        props: {
            isMobile: Boolean,
        }
    }
</script>
