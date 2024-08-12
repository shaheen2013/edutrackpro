let _userInfo = localStorage.getItem('user');

export default {
    namespaced: true,

    state: () => ({
        user: JSON.parse(_userInfo) || null,
    }),

    mutations: {
        setAuthInfo: function (state, data) {
            state.user = data.user;
            let user = JSON.stringify(data.user);
            localStorage.setItem('user', user);
        },
        removeAuthInfo: function (state) {
            state.user = null;
        }
    },

    actions: {
        logout(context) {
            localStorage.removeItem('user');
            context.commit('removeAuthInfo');
        },
        loginStore(context, data) {
            context.commit('setAuthInfo', data);
        }
    }
}
