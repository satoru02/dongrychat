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
import UserFollowings from '../components/user/UserFollowings';
import UserFollowers from '../components/user/UserFollowers';

Vue.use(Vuetify);
Vue.use(VueRouter);
Vue.use(Vuex);
Vue.use(VueAxios, axios);

const developmentOptions = {
  debug: true,
  debugLevel: 'error',
  connectionUrl: `ws://${process.env.LOCALHOST}/cable`,
  connectImmediately: true
};

const productionOptions = {
  debug: true,
  debugLevel: 'error',
  connectionUrl: `wss://52.199.240.50/cable`,
  // connectionUrl: `wss://${process.env.SERVICE_DOMAIN}/cable`,
  connectImmediately: true
};

if (process.env.NODE_ENV === "development") {
  Vue.use(ActionCableVue, developmentOptions);
  Vue.use(VueAuthenticate, {
    baseUrl: `http://${process.env.LOCALHOST}`,
    providers: {
      google: {
        clientId: process.env.GOOGLE_CLIENT_ID,
        client_secret: process.env.GOOGLE_CLIENT_SECRET,
        redirectUri: `http://${process.env.LOCALHOST}/login`,
        grant_type: 'authorization_code',
      },
      facebook: {
        clientId: process.env.FACEBOOK_CLIENT_ID,
        client_secret: process.env.FACEBOOK_CLIENT_SECRET,
        redirectUri: `http://${process.env.LOCALHOST}/login`,
        grant_type: 'authorization_code',
      }
    }
  });
} else if (process.env.NODE_ENV === "production") {
  Vue.use(ActionCableVue, productionOptions);
  Vue.use(VueAuthenticate, {
    baseUrl: `https://${process.env.SERVICE_DOMAIN}`,
    providers: {
      google: {
        clientId: process.env.GOOGLE_CLIENT_ID,
        client_secret: process.env.GOOGLE_CLIENT_SECRET,
        redirectUri: `https://${process.env.SERVICE_DOMAIN}/login`,
        grant_type: 'authorization_code',
      },
      facebook: {
        clientId: process.env.FACEBOOK_CLIENT_ID,
        client_secret: process.env.FACEBOOK_CLIENT_SECRET,
        redirectUri: `https://${process.env.SERVICE_DOMAIN}/login`,
        grant_type: 'authorization_code',
      }
    }
  });
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
})

const router = new VueRouter({
  mode: 'history',
  routes: [{
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
      path: '/users/:id',
      name: "User",
      component: User,
      children: [
        {
          path: "followings",
          name: "Followings",
          component: UserFollowings,
          props: (route) => ({
            query: route.query.status
          })
        },
        {
          path: "followers",
          name: "Followers",
          component: UserFollowers,
          props: (route) => ({
            query: route.query.status
          })
        },
      ]
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
  vuetify: new Vuetify({}),
  router,
  store
});

export {
  store
};