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
import Vuelidate from 'vuelidate';
import ActionCableVue from 'actioncable-vue';
import InfiniteLoading from 'vue-infinite-loading';
import 'vuetify/dist/vuetify.min.css';
import '@mdi/font/css/materialdesignicons.css';
import HomeTop from '../components/Home/HomeTop';
import DetailTop from '../components/Detail/DetailsTop';
import SpaceTop from '../components/Space/SpaceTop';
import SpaceChats from '../components/Space/SpaceChats';
import SpaceUsers from '../components/Space/SpaceUsers';
// import SpaceReviews from '../components/Space/SpaceReviews';
// import SpaceNews from '../components/Space/SpaceNews';
import ChartTop from '../components/Chart/ChartTop';

import AccountActivation from '../components/Authorization/AccountActivation';
import ResetPassword from '../components/Authorization/ResetPassword';
import Login from '../components/Authorization/Login';
import Logout from '../components/Authorization//Logout';
import Signup from '../components/Authorization/Signup';
import ForgotPassword from '../components/Authorization/ForgotPassword';
import Search from '../components/Search/Search';
import UserSettings from '../components/User/UserSettings';
import Results from '../components/Search/SearchResults';
import UserFollowings from '../components/User/UserFollowings';
import UserFollowers from '../components/User/UserFollowers';
import SearchList from '../components/Search/SearchList';

Vue.use(Vuetify);
Vue.use(VueRouter);
Vue.use(Vuex);
Vue.use(VueAxios, axios);
Vue.use(Vuelidate);
Vue.use(InfiniteLoading);

const developmentOptions = {
  debug: true,
  debugLevel: 'error',
  connectionUrl: `ws://${process.env.LOCALHOST}/cable`,
  connectImmediately: true
};

const productionOptions = {
  debug: true,
  debugLevel: 'error',
  connectionUrl: `wss://dongrychat.com/cable`,
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

Vue.use(VueGtag, {
  config: {id: process.env.GA_ID},
  app_name: process.env.GA_APP_NAME,
  pageTrackerScreenviewEnabled: true,
  router
})

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
})

function guardMyroute(to, from, next){
  if(store.state.signedIn){
    next();
  } else {
    next('/login')
  }
}
function guardMultiLogin(to, from, next){
  if(!store.state.signedIn){
    next();
  } else {
    next('/')
  }
}

const router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/signup',
      name: 'Signup',
      component: Signup,
      beforeEnter: guardMultiLogin,
      meta: {
        title: 'アカウント登録'
      }
    },
    {
      path: '/login',
      name: 'Login',
      component: Login,
      beforeEnter: guardMultiLogin,
      meta: {
        title: 'ログイン'
      }
    },
    {
      path: "/account_activations/:token",
      name: "AccountActivation",
      component: AccountActivation,
      beforeEnter: guardMultiLogin
    },
    {
      path: '/forgot_password',
      name: 'ForgotPassword',
      component: ForgotPassword,
      beforeEnter: guardMultiLogin,
      meta: {
        title: 'パスワードを忘れた'
      }
    },
    {
      path: "/password_resets/:token",
      name: "ResetPassword",
      component: ResetPassword,
      beforeEnter: guardMultiLogin,
      meta: {
        title: 'パスワードの再設定'
      }
    },
    {
      path: '/logout',
      name: 'Logout',
      component: Logout,
    },
    {
      path: '/',
      name: 'Chart',
      component: ChartTop,
      meta: {
        title: '今週の注目チャット'
      }
    },
    {
      path: '/home',
      name: 'Home',
      beforeEnter: guardMyroute,
      component: HomeTop,
      meta: {
        title: 'ホーム'
      }
    },
    {
      path: '/tv/:id/:tv_name/season/:number',
      name: 'TvDetails',
      component: DetailTop,
    },
    {
      path: '/mv/:id/:mv_name',
      name: 'MvDetails',
      component: DetailTop
    },
    {
      path: '/mv_space/m/:name',
      props: true,
      component: SpaceTop,
      beforeEnter: guardMyroute,
      children: [
        {
          path: 'chats',
          name: 'MvSpace',
          component: SpaceChats,
        },
        {
          path: 'members',
          name: 'MvSpaceMembers',
          component: SpaceUsers,
        },
        {
          path: 'reviews',
          name: 'MvSpaceReviews',
          // component: SpaceReviews,
        },
        {
          path: 'news',
          name: 'MvSpaceNews',
          // component: SpaceNews,
        }
      ]
    },
    {
      path: '/mv_space/:space_id',
      props: true,
      component: SpaceTop,
      beforeEnter: guardMyroute,
      children: [
        {
          path: 'chats',
          name: 'subscribedMvSpace',
          component: SpaceChats,
        },
        {
          path: 'members',
          name: 'subscribedMvSpaceMembers',
          component: SpaceUsers,
        },
        {
          path: 'reviews',
          name: 'subscribedMvSpaceReviews',
          // component: SpaceReviews,
        },
        {
          path: 'news',
          name: 'subscribedMvSpaceNews',
          // component: SpaceNews,
        }
      ]
    },
    {
      path: '/tv_space/:name/:season_number/:episode_number',
      props: true,
      component: SpaceTop,
      beforeEnter: guardMyroute,
      children: [
        {
          path: 'chats',
          name: 'TvSpace',
          component: SpaceChats,
        },
        {
          path: 'members',
          name: 'TvSpaceMembers',
          component: SpaceUsers,
        },
        {
          path: 'reviews',
          name: 'TvSpaceReviews',
          // component: SpaceReviews,
        },
        {
          path: 'news',
          name: 'TvSpaceNews',
          // component: SpaceNews,
        }
      ]
    },
    {
      path: '/tv_space/:space_id',
      props: true,
      component: SpaceTop,
      beforeEnter: guardMyroute,
      children: [
        {
          path: 'chats',
          name: 'subscribedTvSpace',
          component: SpaceChats,
        },
        {
          path: 'members',
          name: 'subscribedTvSpaceMembers',
          component: SpaceUsers,
        },
        {
          path: 'reviews',
          name: 'subscribedTvSpaceReviews',
          // component: SpaceReviews,
        },
        {
          path: 'news',
          name: 'subscribedTvSpaceNews',
          // component: SpaceNews,
        }
      ]
    },
    {
      path: '/users/:id/followings',
      name: 'Followings',
      component: UserFollowings,
      meta: {
        title: 'フォロー'
      }
    },
    {
      path: '/users/:id/followers',
      name: 'Followers',
      component: UserFollowers,
      meta: {
        title: 'フォロワー '
      }
    },
    {
      path: '/settings',
      name: 'Settings',
      beforeEnter: guardMyroute,
      component: UserSettings,
      meta: {
        title: 'アカウント設定'
      }
    },
    {
      path: '/search',
      name: 'Search',
      component: Search,
      meta: {
        title: '気になる作品を探す'
      }
    },
    {
      path: '/trending',
      name: 'trending',
      component: SearchList,
      meta: {
        title: '注目の作品'
      }
    },
    {
      path: '/popular',
      name: 'popular',
      component: SearchList,
      meta: {
        title: '人気の作品'
      }
    },
    {
      path: '/top-rated',
      name: 'topRated',
      component: SearchList,
      meta: {
        title: '評価の高い作品'
      }
    },
    {
      path: '/upcoming',
      name: 'upcoming',
      component: SearchList,
      meta: {
        title: '公開・配信予定の作品'
      }
    },
    {
      path: '/results/:query',
      name: 'multi',
      props: true,
      component: Results,
      meta: {
        title: '検索結果'
      },
      children: [
        {
          path: "person",
          name: "person",
          component: Results,
          props: (route) => ({
            query: route.query.status
          })
        },
        {
          path: "tv",
          name: "tv",
          component: Results,
          props: (route) => ({
            query: route.query.status
          })
        },
        {
          path: "movie",
          name: "movie",
          component: Results,
          props: (route) => ({
            query: route.query.status
          })
        },
        {
          path: "Company",
          name: "Company",
          component: Results,
          props: (route) => ({
            query: route.query.status
          })
        }
      ]
    }
  ]
})

router.beforeEach((to, from ,next) => {
  document.title = to.meta.title + ' - Devio' || 'Devio';
  next();
});

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