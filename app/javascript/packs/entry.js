import Vue from 'vue'
import App from './App.vue'
import Vuetify from 'vuetify'
import VueRouter from 'vue-router'
import 'vuetify/dist/vuetify.min.css'
import '@mdi/font/css/materialdesignicons.css'

//component
import Top from '../components/top/TopPage'

Vue.use(Vuetify)
Vue.use(VueRouter)

const router = new VueRouter({
  mode: 'history',
  routes: [
    {
    path:"/",
    name: 'Top',
    component: Top
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