import Vue from 'vue'
import App from './App.vue'
import Vuetify from 'vuetify'
import VueRouter from 'vue-router'
import 'vuetify/dist/vuetify.min.css'
import '@mdi/font/css/materialdesignicons.css'

Vue.use(Vuetify)
Vue.use(VueRouter)

const router = new VueRouter({
  mode: 'history',
  routes: [{
    path:"/",
  }]
})

const app = new Vue({
   el: '#app',
   render: h => h(App),
   vuetify: new Vuetify({
    }),
   router
})