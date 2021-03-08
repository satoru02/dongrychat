import Vue from 'vue'
import App from './App.vue'
import Vuetify from 'vuetify'
import VueRouter from 'vue-router'
import 'vuetify/dist/vuetify.min.css'
import '@mdi/font/css/materialdesignicons.css'

Vue.use(Vuetify)
Vue.use(VueRouter)

//component
import Top from '../components/top/TopPage'
import Content from '../components/contents/ContentPage'
import Search from '../components/search/SearchTop'
import Trend from '../components/trend/TrendTop'
import Authorization from '../components/authorization/AuthorizationTop'
import Login from '../components/authorization/Login'
import Signup from '../components/authorization/Signup'
import User from '../components/user/UserTop'

const router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Top',
      component: Top
    },
    {
      // #temporary name
      path: '/content',
      name: 'Content',
      component: Content
    },
    {
      path: '/search',
      name: 'Search',
      component: Search
    },
    {
      path: '/trend',
      name: 'Trend',
      component: Trend
    },
    {
      path: '/authorization',
      name: 'Authorization',
      component: Authorization
    },
    {
      path: '/login',
      name: 'Login',
      component: Login
    },
    {
      path: '/signup',
      name: 'Signup',
      component: Signup
    },
    {
      path: '/user',
      name: 'User',
      component: User
    }
  ]
})

const app = new Vue({
   el: '#app',
   render: h => h(App),
   vuetify: new Vuetify({
    }),
   router
})