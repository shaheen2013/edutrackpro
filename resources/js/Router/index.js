import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

// ========== define route==========
const routes = [
    { path: '/', name: 'login', component: () => import('@/Views/Auth/Login.vue') },


    // if any component or view not found then showing 404 page
    {
        path: '*', component: () => import('@/Views/Errors/NotFoundLayout.vue'), beforeEnter: authGuard,
        children: [
            { path: '*', name: '404', component: () => import('@/Views/Errors/404.vue'), beforeEnter: authGuard }
        ]
    }
];



// ========== define router==========
const router = new VueRouter({
    routes,
    hashbang: false,
    mode: 'history',
    base: '/',
    linkExactActiveClass: "active",
    scrollBehavior() {
        return { x: 0, y: 0 };
    }
})

/** check auth login / not */
function authGuard(to, from, next) {
    let user = localStorage.getItem('user')
    if (user) {
        next()
    } else {
        window.location.href = "/";
    }
}

export default router
