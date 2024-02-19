const state = {
    isQuestionLoading: true,
    currentScore: 0,
    currentRank: 0,
};
const getters = {
    isQuizLoading: (state) => state.isQuestionLoading,
    currentScore: (state) => state.currentScore,
    currentRank: (state) => state.currentRank,
};

const mutations = {
    SET_QUIZ_LOADING: (state, value) => (state.isQuestionLoading = value),
    SET_CURRENT_RANK: (state, value) => (state.currentRank = value),
    SET_CURRENT_SCORE: (state, value) => (state.currentScore = value),
};

export default {
    namespaced: true,
    state,
    getters,
    mutations,
};
