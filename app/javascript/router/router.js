import Vue from 'vue';
import VueRouter from 'vue-router';
import ChartTop from '../components/Chart/ChartTop.vue';
import { store } from '../stores/index';
import NProgress from 'nprogress';
import 'nprogress/nprogress.css';
NProgress.configure({ easing: 'ease', speed: 300 });
Vue.use(VueRouter);

function guardMyroute(to, from, next) {
  if (store.state.user.signedIn) {
    next();
  } else {
    next('/login');
  }
}

function guardMultiLogin(to, from, next) {
  if (!store.state.user.signedIn) {
    next();
  } else {
    next('/');
  }
}

var router = new VueRouter({
  mode: 'history',
  routes: [{
      path: '/signup',
      name: 'Signup',
      beforeEnter: guardMultiLogin,
      meta: {
        title: 'アカウント登録'
      },
      component: () => import( /* webpackChunkName: "Signup" */ '../components/Authorization/Signup'),
    },
    {
      path: '/login',
      name: 'Login',
      beforeEnter: guardMultiLogin,
      meta: {
        title: 'ログイン'
      },
      component: () => import( /* webpackChunkName: "Login" */ '../components/Authorization/Login'),
    },
    {
      path: "/account_activations/:token",
      name: "AccountActivation",
      beforeEnter: guardMultiLogin,
      component: () => import( /* webpackChunkName: "AccountActivation" */ '../components/Authorization/AccountActivation'),
    },
    {
      path: '/forgot_password',
      name: 'ForgotPassword',
      beforeEnter: guardMultiLogin,
      meta: {
        title: 'パスワードを忘れた'
      },
      component: () => import( /* webpackChunkName: "ForgotPassword" */ '../components/Authorization/ForgotPassword'),
    },
    {
      path: "/password_resets/:token",
      name: "ResetPassword",
      beforeEnter: guardMultiLogin,
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
      name: 'Chart',
      component: ChartTop,
      meta: {
        title: '話題の作品',
        keepAlive: true,
      }
    },
    {
      path: '/home',
      name: 'Home',
      beforeEnter: guardMyroute,
      meta: {
        title: 'お気に入り',
        keepAlive: true,
        showProgressBar: true
      },
      component: () => import( /* webpackChunkName: "HomeTop" */ '../components/Home/HomeTop'),
    },
    {
      path: '/tv/:id/:tv_name/season/:number',
      name: 'TvDetails',
      component: () => import( /* webpackChunkName: "DetailsTop" */ '../components/Detail/DetailsTop'),
      meta: {
        keepAlive: false,
      }
    },
    {
      path: '/mv/:id/:mv_name',
      name: 'MvDetails',
      component: () => import( /* webpackChunkName: "DetailsTop" */ '../components/Detail/DetailsTop'),
      meta: {
        keepAlive: false,
      }
    },
    {
      path: '/mv_space/m/:name',
      props: true,
      beforeEnter: guardMyroute,
      component: () => import( /* webpackChunkName: "SpaceTop" */ '../components/Space/SpaceTop'),
      children: [{
          path: 'chats',
          name: 'MvSpace',
          component: () => import( /* webpackChunkName: "SpaceChats" */ '../components/Space/SpaceChats'),
          meta: {
            keepAlive: false,
          }
        },
        {
          path: 'members',
          name: 'MvSpaceMembers',
          component: () => import( /* webpackChunkName: "SpaceUsers" */ '../components/Space/SpaceUsers'),
          meta: {
            keepAlive: false,
          }
        },
        {
          path: 'reviews',
          name: 'MvSpaceReviews',
          component: () => import( /* webpackChunkName: "SpaceUsers" */ '../components/Space/SpaceReviews'),
          meta: {
            keepAlive: false,
          }
        },
      ]
    },
    {
      path: '/mv_space/:space_id',
      props: true,
      beforeEnter: guardMyroute,
      component: () => import( /* webpackChunkName: "SpaceTop" */ '../components/Space/SpaceTop'),
      children: [{
          path: 'chats',
          name: 'subscribedMvSpace',
          component: () => import( /* webpackChunkName: "SpaceChats" */ '../components/Space/SpaceChats'),
          meta: {
            keepAlive: false,
          }
        },
        {
          path: 'members',
          name: 'subscribedMvSpaceMembers',
          component: () => import( /* webpackChunkName: "SpaceUsers" */ '../components/Space/SpaceUsers'),
          meta: {
            keepAlive: false,
          }
        },
        {
          path: 'reviews',
          name: 'subscribedMvSpaceReviews',
          component: () => import( /* webpackChunkName: "SpaceUsers" */ '../components/Space/SpaceReviews'),
          meta: {
            keepAlive: false,
          }
        },
      ]
    },
    {
      path: '/tv_space/:name/:season_number/:episode_number',
      props: true,
      beforeEnter: guardMyroute,
      component: () => import( /* webpackChunkName: "SpaceTop" */ '../components/Space/SpaceTop'),
      children: [{
          path: 'chats',
          name: 'TvSpace',
          component: () => import( /* webpackChunkName: "SpaceChats" */ '../components/Space/SpaceChats'),
          meta: {
            keepAlive: false,
          }
        },
        {
          path: 'members',
          name: 'TvSpaceMembers',
          component: () => import( /* webpackChunkName: "SpaceUsers" */ '../components/Space/SpaceUsers'),
          meta: {
            keepAlive: false,
          }
        },
        {
          path: 'reviews',
          name: 'TvSpaceReviews',
          component: () => import( /* webpackChunkName: "SpaceUsers" */ '../components/Space/SpaceReviews'),
          meta: {
            keepAlive: false,
          }
        },
      ]
    },
    {
      path: '/tv_space/:space_id',
      props: true,
      beforeEnter: guardMyroute,
      component: () => import( /* webpackChunkName: "SpaceTop" */ '../components/Space/SpaceTop'),
      children: [{
          path: 'chats',
          name: 'subscribedTvSpace',
          component: () => import( /* webpackChunkName: "SpaceChats" */ '../components/Space/SpaceChats'),
          meta: {
            keepAlive: false,
          }
        },
        {
          path: 'members',
          name: 'subscribedTvSpaceMembers',
          component: () => import( /* webpackChunkName: "SpaceUsers" */ '../components/Space/SpaceUsers'),
          meta: {
            keepAlive: false,
          }
        },
        {
          path: 'reviews',
          name: 'subscribedTvSpaceReviews',
          component: () => import( /* webpackChunkName: "SpaceUsers" */ '../components/Space/SpaceReviews'),
          meta: {
            keepAlive: false,
          }
        },
      ]
    },
    {
      path: '/users/:user_id',
      beforeEnter: guardMyroute,
      props: true,
      component: () => import( /* webpackChunkName: "UserTop" */ '../components/User/UserTop'),
      children: [{
          path: '',
          name: 'UserTop',
          component: () => import( /* webpackChunkName: "UserProfile" */ '../components/User/UserProfile'),
          meta: {
            keepAlive: false,
          },
        },
        {
          path: 'reviews',
          name: 'UserReviews',
          component: () => import( /* webpackChunkName: "UserPosts" */ '../components/User/UserReviews'),
          meta: {
            keepAlive: false,
          },
        },
        {
          path: 'followings',
          name: 'UserFollowings',
          component: () => import( /* webpackChunkName: "UserFollowings" */ '../components/User/UserFollowings'),
          meta: {
            keepAlive: false,
          },
        },
        {
          path: 'followers',
          name: 'UserFollowers',
          component: () => import( /* webpackChunkName: "UserFollowers" */ '../components/User/UserFollowers'),
          meta: {
            keepAlive: false,
          },
        },
      ]
    },
    {
      path: '/settings',
      name: 'Settings',
      beforeEnter: guardMyroute,
      meta: {
        title: 'アカウント設定'
      },
      component: () => import( /* webpackChunkName: "UserSettings" */ '../components/User/UserSettings'),
    },
    // {
    //   path: '/latest',
    //   name: 'Latest',
    //   meta: {
    //     title: '新着の作品'
    //   },
    //   component: () => import( /* webpackChunkName: "Search" */ '../components/Content/Content'),
    // },
    {
      path: '/trend',
      name: 'Trend',
      meta: {
        title: '新着の作品'
      },
      component: () => import( /* webpackChunkName: "Search" */ '../components/Content/Content'),
    },
    {
      path: '/popular',
      name: 'Popular',
      meta: {
        title: '人気の作品'
      },
      component: () => import( /* webpackChunkName: "Search" */ '../components/Content/Content'),
    },
    {
      path: '/top-rated',
      name: 'TopRated',
      meta: {
        title: '評価の高い作品'
      },
      component: () => import( /* webpackChunkName: "Search" */ '../components/Content/Content'),
    },
    // {
    //   path: '/upcoming',
    //   name: 'Upcoming',
    //   meta: {
    //     title: '公開・配信予定の作品'
    //   },
    //   component: () => import( /* webpackChunkName: "Search" */ '../components/Content/Content'),
    // },
    {
      path: '/results/:query',
      name: 'multi',
      props: true,
      meta: {
        title: '検索結果'
      },
      component: () => import( /* webpackChunkName: "Multi" */ '../components/Search/SearchResults'),
      children: [{
          path: "person",
          name: "person",
          props: (route) => ({
            query: route.query.status
          }),
          component: () => import( /* webpackChunkName: "SearchPerson" */ '../components/Search/SearchResults'),
        },
        {
          path: "tv",
          name: "tv",
          props: (route) => ({
            query: route.query.status
          }),
          component: () => import( /* webpackChunkName: "SearchTv" */ '../components/Search/SearchResults'),
        },
        {
          path: "movie",
          name: "movie",
          props: (route) => ({
            query: route.query.status
          }),
          component: () => import( /* webpackChunkName: "SearchMv" */ '../components/Search/SearchResults'),
        },
        {
          path: "Company",
          name: "Company",
          props: (route) => ({
            query: route.query.status
          }),
          component: () => import( /* webpackChunkName: "SearchCompany" */ '../components/Search/SearchResults'),
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
      path: "/notifications",
      name: "NotificationTop",
      meta: {
        title: '通知',
        keepAlive: true
      },
      component: () => import( /* webpackChunkName: "Notifications" */ '../components/Notification/NotificationTop'),
    },
    {
      path: "/tag/:name",
      name: "Tag",
      meta: {
        // title: ':name',
        keepAlive: true
      },
      component: () => import /* webpackChunkName: "Tags" */('../components/Tag/TagTop'),
    }
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