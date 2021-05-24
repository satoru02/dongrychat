import Vue from 'vue';
import { createStore } from 'vuex';

Vue.use(createStore)

import UserStore from './stores/user_store';

const store = createStore({
  modules: {
    UserStore
  }
});

export { store };