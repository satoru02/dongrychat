import Vue from 'vue';
import Vuex from 'vuex';
import UserStore from './modules/user_store';
import createPersistedState from 'vuex-persistedstate';

Vue.use(Vuex);

const store = new Vuex.Store({
  modules: {
    user: UserStore
  },
  plugins: [createPersistedState()]
});

export { store };