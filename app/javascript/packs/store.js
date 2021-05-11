import Vue from 'vue';
import Vuex from 'vuex';
import createPersistedState from 'vuex-persistedstate';

Vue.use(Vuex);
const store = new Vuex.Store({
  state: {
    currentUser: {},
    signedIn: false,
    csrf: null,
  },
  getters: {
    isAdmin: state => {
      return state.currentUser.role == "admin"
    },
    isManager: state => {
      return state.currentUser.role == "manager"
    },
    currentUserId: state => {
      return state.currentUser && state.currentUser.data.attributes.id
    }
  },
  mutations: {
    setCurrentUser(state, {
      currentUser,
      csrf,
      token,
    }) {
      state.currentUser = currentUser
      state.signedIn = true
      state.csrf = csrf
      state.token = token
    },
    unsetCurrentUser(state) {
      state.currentUser = {}
      state.signedIn = false
      state.csrf = null
      state.token = null
    },
    refresh(state, csrf) {
      state.signedIn = true
      state.csrf = csrf
    },
    follow(state, user_id){
      state.currentUser.following.push(user_id)
    },
    unfollow(state, user_id){
      state.currentUser.following = state.currentUser.following.filter(
        following => following != user_id
      )
    }
  },
  plugins: [createPersistedState()]
});

export {
  store
};