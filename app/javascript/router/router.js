// vue router
import Vue from 'vue';
import VueRouter from 'vue-router';
Vue.use(VueRouter);

import Home from '../components/Resources/Home.vue';

// vue store
import { store } from '../stores/index';

// loading bar
import NProgress from 'nprogress';
import 'nprogress/nprogress.css';
NProgress.configure({ easing: 'ease', speed: 300 });

// Check if a user already logged in.
function checkLoggedIn(to, from, next) {
  if (store.state.user.signedIn) {
    next();
  } else {
    next('/login');
  }
}

function guardAuthRoute(to, from, next) {
  if (!store.state.user.signedIn) {
    next();
  } else {
    next('/');
  }
}

var router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/signup',
      name: 'Signup',
      beforeEnter: guardAuthRoute,
      meta: {
        title: 'アカウント登録'
      },
      component: () => import( /* webpackChunkName: "Signup" */ '../components/Authorization/Signup'),
    },
    {
      path: '/login',
      name: 'Login',
      beforeEnter: guardAuthRoute,
      meta: {
        title: 'ログイン'
      },
      component: () => import( /* webpackChunkName: "Login" */ '../components/Authorization/Login'),
    },
    {
      path: "/account_activations/:token",
      name: "AccountActivation",
      beforeEnter: guardAuthRoute,
      component: () => import( /* webpackChunkName: "AccountActivation" */ '../components/Authorization/AccountActivation'),
    },
    {
      path: '/forgot_password',
      name: 'ForgotPassword',
      beforeEnter: guardAuthRoute,
      meta: {
        title: 'パスワードを忘れた'
      },
      component: () => import( /* webpackChunkName: "ForgotPassword" */ '../components/Authorization/ForgotPassword'),
    },
    {
      path: "/password_resets/:token",
      name: "ResetPassword",
      beforeEnter: guardAuthRoute,
      meta: {
        title: 'パスワードの再設定'
      },
      component: () => import( /* webpackChunkName: "ResetPassword" */ '../components/Authorization/ResetPassword'),
    },
    {
      path: '/logout',
      name: 'Logout',
      component: () => import( /* webpackChunkName: "Logout" */ '../components/Authorization/Logout'),
    },
    {
      path: '/',
      name: 'Home',
      component: Home,
      meta: {
        title: '話題の作品について語ろう！',
        keepAlive: true,
      }
    },
    {
      path: "/tag/:name",
      name: "Tag",
      meta: {
        keepAlive: true
      },
      component: () => import /* webpackChunkName: "Tags" */('../components/Resources/Tag'),
    },
    {
      path: '/following',
      name: 'Following',
      beforeEnter: checkLoggedIn,
      meta: {
        title: 'フォロー中の作品',
        keepAlive: false,
      },
      component: () => import( /* webpackChunkName: "HomeTop" */ '../components/Resources/Following'),
    },
    {
      path: '/tv/:id/:tv_name/season/:number',
      name: 'TvDetails',
      meta: {
        keepAlive: false,
      },
      component: () => import( /* webpackChunkName: "DetailsTop" */ '../components/Resources/Detail'),
    },
    {
      path: '/mv/:id/:mv_name',
      name: 'MvDetails',
      meta: {
        keepAlive: false,
      },
      component: () => import( /* webpackChunkName: "DetailsTop" */ '../components/Resources/Detail'),
    },
    {
      path: '/mv_space/m/:name',
      props: true,
      beforeEnter: checkLoggedIn,
      component: () => import( /* webpackChunkName: "SpaceTop" */ '../components/Space/SpaceTop'),
      children: [
        {
          path: 'chats',
          name: 'MvSpace',
          meta: {
            keepAlive: false,
          },
          component: () => import( /* webpackChunkName: "SpaceChats" */ '../components/Space/SpaceChats'),
        },
        {
          path: 'members',
          name: 'MvSpaceMembers',
          meta: {
            keepAlive: false,
          },
          component: () => import( /* webpackChunkName: "SpaceUsers" */ '../components/Space/SpaceUsers'),
        },
        {
          path: 'reviews',
          name: 'MvSpaceReviews',
          meta: {
            keepAlive: false,
          },
          component: () => import( /* webpackChunkName: "SpaceReviews" */ '../components/Space/SpaceReviews'),
        },
      ]
    },
    {
      path: '/mv_space/:space_id',
      props: true,
      beforeEnter: checkLoggedIn,
      component: () => import( /* webpackChunkName: "SpaceTop" */ '../components/Space/SpaceTop'),
      children: [
        {
          path: 'chats',
          name: 'registeredMvSpace',
          meta: {
            keepAlive: false,
          },
          component: () => import( /* webpackChunkName: "SpaceChats" */ '../components/Space/SpaceChats'),
        },
        {
          path: 'members',
          name: 'registeredMvSpaceMembers',
          meta: {
            keepAlive: false,
          },
          component: () => import( /* webpackChunkName: "SpaceUsers" */ '../components/Space/SpaceUsers'),
        },
        {
          path: 'reviews',
          name: 'registeredMvSpaceReviews',
          meta: {
            keepAlive: false,
          },
          component: () => import( /* webpackChunkName: "SpaceReviews" */ '../components/Space/SpaceReviews'),
        },
      ]
    },
    {
      path: '/tv_space/:name/:season_number/:episode_number',
      props: true,
      beforeEnter: checkLoggedIn,
      component: () => import( /* webpackChunkName: "SpaceTop" */ '../components/Space/SpaceTop'),
      children: [{
          path: 'chats',
          name: 'TvSpace',
          meta: {
            keepAlive: false,
          },
          component: () => import( /* webpackChunkName: "SpaceChats" */ '../components/Space/SpaceChats'),
        },
        {
          path: 'members',
          name: 'TvSpaceMembers',
          meta: {
            keepAlive: false,
          },
          component: () => import( /* webpackChunkName: "SpaceUsers" */ '../components/Space/SpaceUsers'),
        },
        {
          path: 'reviews',
          name: 'TvSpaceReviews',
          meta: {
            keepAlive: false,
          },
          component: () => import( /* webpackChunkName: "SpaceReviews" */ '../components/Space/SpaceReviews'),
        },
      ]
    },
    {
      path: '/tv_space/:space_id',
      props: true,
      beforeEnter: checkLoggedIn,
      component: () => import( /* webpackChunkName: "SpaceTop" */ '../components/Space/SpaceTop'),
      children: [{
          path: 'chats',
          name: 'registeredTvSpace',
          meta: {
            keepAlive: false,
          },
          component: () => import( /* webpackChunkName: "SpaceChats" */ '../components/Space/SpaceChats'),
        },
        {
          path: 'members',
          name: 'registeredTvSpaceMembers',
          meta: {
            keepAlive: false,
          },
          component: () => import( /* webpackChunkName: "SpaceUsers" */ '../components/Space/SpaceUsers'),
        },
        {
          path: 'reviews',
          name: 'registeredTvSpaceReviews',
          meta: {
            keepAlive: false,
          },
          component: () => import( /* webpackChunkName: "SpaceReviews" */ '../components/Space/SpaceReviews'),
        },
      ]
    },
    {
      path: '/users/:user_id',
      props: true,
      beforeEnter: checkLoggedIn,
      component: () => import( /* webpackChunkName: "UserTop" */ '../components/User/UserTop'),
      children: [
        {
          path: 'watchlists',
          name: 'watchlists',
          meta: {
            keepAlive: false,
          },
          component: () => import( /* webpackChunkName: "UserWatchLists" */ '../components/User/UserWatchLists'),
        },
        {
          path: 'watchlog',
          name: 'watchlog',
          meta: {
            keepAlive: false,
          },
          component: () => import( /* webpackChunkName: "UserWatchLog" */ '../components/User/UserWatchLists'),
        },
        {
          path: 'reviews',
          name: 'UserReviews',
          meta: {
            keepAlive: false,
          },
          component: () => import( /* webpackChunkName: "UserReviews" */ '../components/User/UserReviews'),
        },
        {
          path: 'followers',
          name: 'UserFollowers',
          meta: {
            keepAlive: false,
          },
          component: () => import( /* webpackChunkName: "UserWatchLog" */ '../components/User/UserFollowers'),
        },
        {
          path: 'following',
          name: 'UserFollowing',
          meta: {
            keepAlive: false,
          },
          component: () => import( /* webpackChunkName: "UserReviews" */ '../components/User/UserFollowing'),
        },
        {
          path: 'profile',
          name: 'UserProfile',
          meta: {
            keepAlive: false,
          },
          component: () => import( /* webpackChunkName: "UserReviews" */ '../components/User/UserProfile'),
        },
      ]
    },
    {
      path: '/settings',
      name: 'Settings',
      beforeEnter: checkLoggedIn,
      meta: {
        title: 'アカウント設定'
      },
      component: () => import( /* webpackChunkName: "UserSettings" */ '../components/User/UserSettings'),
    },
    {
      path: '/popular',
      name: 'Popular',
      meta: {
        title: '人気の作品'
      },
      component: () => import( /* webpackChunkName: "Search" */ '../components/Resources/Collection'),
    },
    {
      path: '/trend',
      name: 'Trend',
      meta: {
        title: '新着の作品'
      },
      component: () => import( /* webpackChunkName: "Search" */ '../components/Resources/Collection'),
    },
    {
      path: '/top_rated',
      name: 'TopRated',
      meta: {
        title: '評価の高い作品'
      },
      component: () => import( /* webpackChunkName: "Search" */ '../components/Resources/Collection'),
    },
    {
      path: '/results/:query',
      name: 'multi',
      props: true,
      meta: {
        title: '検索結果'
      },
      component: () => import( /* webpackChunkName: "Multi" */ '../components/Resources/SearchResults'),
      children: [
        {
          path: "person",
          name: "person",
          props: (route) => ({
            query: route.query.status
          }),
          component: () => import( /* webpackChunkName: "SearchPerson" */ '../components/Resources/SearchResults'),
        },
        {
          path: "tv",
          name: "tv",
          props: (route) => ({
            query: route.query.status
          }),
          component: () => import( /* webpackChunkName: "SearchTv" */ '../components/Resources/SearchResults'),
        },
        {
          path: "movie",
          name: "movie",
          props: (route) => ({
            query: route.query.status
          }),
          component: () => import( /* webpackChunkName: "SearchMv" */ '../components/Resources/SearchResults'),
        },
        {
          path: "Company",
          name: "Company",
          props: (route) => ({
            query: route.query.status
          }),
          component: () => import( /* webpackChunkName: "SearchCompany" */ '../components/Resources/SearchResults'),
        }
      ]
    },
    {
      path: "/privacy",
      name: "Privacy",
      meta: {
        title: 'プライバシーポリシー',
        keepAlive: true
      },
      component: () => import( /* webpackChunkName: "Privacy" */ '../components/Overview/Privacy'),
    },
    {
      path: "/terms",
      name: "Terms",
      meta: {
        title: '利用規約',
        keepAlive: true
      },
      component: () => import( /* webpackChunkName: "Terms" */ '../components/Overview/Terms'),
    },
    {
      path: "/notification",
      name: "Notification",
      meta: {
        title: '通知',
        keepAlive: true
      },
      component: () => import( /* webpackChunkName: "Notifications" */ '../components/Resources/Notification'),
    },
  ]
});

router.beforeEach((to, from, next) => {
  document.title = to.meta.title + ' |  Devio' || 'Devio';
  NProgress.start();
  NProgress.set(0.0);
  next();
});

router.afterEach(() => {
  NProgress.done();
});

export {
  router
};