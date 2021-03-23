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
import ActionCableVue from 'actioncable-vue';
import 'vuetify/dist/vuetify.min.css';
import '@mdi/font/css/materialdesignicons.css';

import Top from '../components/top/TopPage';
import TvDetails from '../components/details/TvDetailsPage';
import MvDetails from '../components/details/MvDetailsPage';
import TvSpace from '../components/space/TvSpace';
import MvSpace from '../components/space/MvSpace';
import Trend from '../components/trend/TrendTop';
import Authorization from '../components/authorization/AuthorizationTop';
import AccountActivation from '../components/authorization/AccountActivation';
import ResetPassword from '../components/authorization/ResetPassword';
import Login from '../components/authorization/Login';
import Logout from '../components/authorization//Logout';
import Signup from '../components/authorization/Signup';
import ForgotPassword from '../components/authorization/ForgotPassword';
import User from '../components/user/UserTop';
import Search from '../components/search/Search';
import Contents from '../components/contents/ContentsList';
import Actors from '../components/contents/ActorsList';
import UserSettings from '../components/user/UserSettings';
import Results from '../components/search/SearchResults';

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

  const developmentOptions = {
    debug: true,
    debugLevel: 'error',
    connectionUrl: 'ws://localhost:5000/cable',
    connectImmediately: true
  };

  const productionOptions = {
    debug: true,
    debugLevel: 'error',
    connectionUrl: 'wss://52.199.240.50/cable',
    connectImmediately: true
  }

  if (process.env.NODE_ENV === "development") {
    Vue.use(ActionCableVue, developmentOptions)
  } else if (process.env.NODE_ENV === "production") {
    Vue.use(ActionCableVue, productionOptions)
  }

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
      path: '/tv/:id/:tv_name/season/:number',
      name: 'TvDetails',
      component: TvDetails
    },
    {
      path: '/mv/:id/:mv_name',
      name: 'MvDetails',
      component: MvDetails
    },
    {
      path: '/tv_space/:name/:season_number/:episode_number',
      name: 'TvSpace',
      props: true,
      component: TvSpace
    },
    {
      path: '/mv_space/:name',
      name: 'MvSpace',
      props: true,
      component: MvSpace
    },
    {
      path: '/tv_space/:space_id',
      name: 'subscribedTvSpace',
      props: true,
      component: TvSpace
    },
    {
      path: '/mv_space/:space_id',
      name: 'subscribedMvSpace',
      props: true,
      component: MvSpace
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
      path: '/settings',
      name: 'Settings',
      component: UserSettings
    },
    {
      path: '/search',
      name: 'Search',
      component: Search
    },
    {
      path: '/results/:query',
      name: 'Results',
      props: true,
      component: Results
    },
    {
      path: '/popular',
      name: 'Popular',
      component: Contents
    },
    {
      path: '/streaming/:platform',
      name: 'Streaming',
      component: Contents
    },
    {
      path: '/top_rated',
      name: 'TopRated',
      component: Contents
    },
    {
      path: '/actors',
      name: 'Actors',
      component: Actors
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