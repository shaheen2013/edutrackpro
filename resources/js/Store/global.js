export default {
    namespaced: true,

    state: () => ({
        site: {},
        global: {},
    }),

    mutations: {
        setGlobalData(state, data) {
            state.site = data.site;
            state.global = data.global;
        },
    },

    actions: {
        setGlobal(context, data) {
            context.commit('setGlobalData', data);
        }
    },
}
