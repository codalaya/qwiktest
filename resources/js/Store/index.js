import Vuex from "vuex";
import Vue from "vue";
import exam from "./Modules/exam";
import quiz from "./Modules/Quiz";

Vue.use(Vuex);

export default new Vuex.Store({
    modules: {
        exam,
        quiz,
    },
});
