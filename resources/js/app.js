import '@/bootstrap';
import Vue from "vue";
import App from '@/Components/App.vue';
import router from '@/Router';
import store from '@/Store';
import '@/Plugin/plugin'
import '@/Mixins/crud'
import '@/Mixins/filter'
import '@/Mixins/mixin'

Vue.config.productionTip = false;


new Vue({
    render: h => h(App),
    router,
    store,
    data: {
        baseurl: laravel.baseurl,
        spinner: false,
        loggedIn: false,
    }
}).$mount('#app');
