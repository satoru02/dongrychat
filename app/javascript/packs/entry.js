import Vue from 'vue';
import App from './App.vue';
import Vuetify from 'vuetify';
import axios from 'axios';
import Vuex from 'vuex';
import VueAxios from 'vue-axios';
import VueAuthenticate from 'vue-authenticate';
import createPersistedState from 'vuex-persistedstate';
import VueGtag from "vue-gtag";
import VueRouter from 'vue-router';
import 'vuetify/dist/vuetify.min.css';
import '@mdi/font/css/materialdesignicons.css';

import Top from '../components/top/TopPage';
import TvDetails from '../components/tv/TvDetailsPage';
import MvDetails from '../components/mv/MvDetailsPage';
import Space from '../components/space/Space';
import Search from '../components/search/SearchTop';
import Trend from '../components/trend/TrendTop';
import Authorization from '../components/authorization/AuthorizationTop';
import AccountActivation from '../components/authorization/AccountActivation';
import ResetPassword from '../components/authorization/ResetPassword';
import Login from '../components/authorization/Login';
import Logout from '../components/authorization//Logout';
import Signup from '../components/authorization/Signup';
import ForgotPassword from '../components/authorization/ForgotPassword';
import User from '../components/user/UserTop';
import SearchIndex from '../components/search/SearchIndex';

Vue.use(Vuetify);
Vue.use(VueRouter);
Vue.use(Vuex);
Vue.use(VueAxios, axios);
Vue.use(VueAuthenticate, {
  baseUrl: 'http://localhost:5000',
  providers: {
    google: {
      clientId: process.env.GOOGLE_CLIENT_ID,
      client_secret: process.env.GOOGLE_CLIENT_SECRET,
      redirectUri: 'http://localhost:5000/login',
      grant_type: 'authorization_code',
    },
    facebook: {
      clientId: process.env.FACEBOOK_CLIENT_ID,
      client_secret: process.env.FACEBOOK_CLIENT_SECRET,
      redirectUri: 'http://localhost:5000/login',
      grant_type: 'authorization_code',
    }
  }
});

// Vue.use(VueGtag, {
//   config: {id: process.env.GA_ID},
//   router
// })

const store = new Vuex.Store({
  state: {
    currentUser: {},
    signedIn: false,
    csrf: null
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
      token
    }) {
      state.currentUser = currentUser
      state.signedIn = true
      state.csrf = csrf
      state.token = token
    },
    unsetCurrentUser(state){
      state.currentUser = {}
      state.signedIn = false
      state.csrf = null
      state.token = null
    },
    refresh(state, csrf){
      state.signedIn = true
      state.csrf = csrf
    }
  },
  plugins: [createPersistedState()]
})

const router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Top',
      component: Top
    },
    {
      path: '/tv/:id/season/:number',
      name: 'TvDetails',
      component: TvDetails
    },
    {
      path: '/space/:name/:season_number/:episode_number',
      name: 'TvSpace',
      props: true,
      component: Space
    },
    {
      path: '/space/:name',
      name: 'MvSpace',
      props: true,
      component: Space
    },
    {
      path: '/mv/:id',
      name: 'MvDetails',
      component: MvDetails
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
      path: "/account_activations/:token",
      name: "AccountActivation",
      component: AccountActivation
    },
    {
      path: "/password_resets/:token",
      name: "ResetPassword",
      component: ResetPassword
    },
    {
      path: '/login',
      name: 'Login',
      component: Login
    },
    {
      path: '/logout',
      name: 'Logout',
      component: Logout
    },
    {
      path: '/signup',
      name: 'Signup',
      component: Signup
    },
    {
      path: '/forgot_password',
      name: 'ForgotPassword',
      component: ForgotPassword
    },
    {
      path: '/user',
      name: 'User',
      component: User
    },
    {
      path: '/searchindex',
      name: 'SearchIndex',
      component: SearchIndex
    }
  ]
})

const app = new Vue({
   el: '#app',
   render: h => h(App),
   vuetify: new Vuetify({
    }),
   router,
   store
});

export { store };