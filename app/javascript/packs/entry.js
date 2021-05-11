import Vue from 'vue';
import App from './App.vue';
import InfiniteLoading from 'vue-infinite-loading';
import Vuetify from 'vuetify';
import 'vuetify/dist/vuetify.min.css';
import '@mdi/font/css/materialdesignicons.css';

import { store } from './store';
import { router } from './router';
import './cable';

Vue.use(Vuetify);
Vue.use(InfiniteLoading);

const app = new Vue({
  el: '#app',
  render: h => h(App),
  vuetify: new Vuetify({}),
  router,
  store
});