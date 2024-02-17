const state = {
    isQuestionLoading: true,
};
const getters = {
    isQuizLoading: (state) => state.isQuestionLoading,
};

const mutations = {
    SET_QUIZ_LOADING: (state, value) => (state.isQuestionLoading = value),
};

export default {
    state,
    getters,
    mutations,
};
