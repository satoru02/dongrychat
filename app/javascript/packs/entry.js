import Vue from 'vue';
import App from './App.vue';
import InfiniteLoading from 'vue-infinite-loading';
import Vuetify from 'vuetify';
import VueGtag from "vue-gtag";
import { store } from '../stores/index';
import { router } from '../router/router';
import 'vuetify/dist/vuetify.min.css';
// import '@mdi/font/css/materialdesignicons.css';
import '../analytics/analytics';
import '../channels/cable';

Vue.use(Vuetify);
Vue.use(InfiniteLoading);
Vue.use(VueGtag, {
  router
});

const app = new Vue({
  el: '#app',
  render: h => h(App),
  vuetify: new Vuetify({}),
  router,
  store,
});