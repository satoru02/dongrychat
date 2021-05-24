import Vue from 'vue';
import VueRouter from 'vue-router';
import ChartTop from '../components/Chart/ChartTop.vue';
import {
  store
} from '../stores/index';

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
        title: 'チャート',
        keepAlive: true,
      }
    },
    {
      path: '/home',
      name: 'Home',
      beforeEnter: guardMyroute,
      meta: {
        title: 'ホーム',
        keepAlive: true,
      },
      component: () => import( /* webpackChunkName: "HomeTop" */ '../components/Home/HomeTop'),
    },
    {
      path: '/tv/:id/:tv_name/season/:number',
      name: 'TvDetails',
      component: () => import( /* webpackChunkName: "DetailsTop" */ '../components/Detail/DetailsTop'),
    },
    {
      path: '/mv/:id/:mv_name',
      name: 'MvDetails',
      component: () => import( /* webpackChunkName: "DetailsTop" */ '../components/Detail/DetailsTop'),
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
        },
        {
          path: 'members',
          name: 'MvSpaceMembers',
          component: () => import( /* webpackChunkName: "SpaceUsers" */ '../components/Space/SpaceUsers'),
        },
        {
          path: 'reviews',
          name: 'MvSpaceReviews',
        },
        {
          path: 'news',
          name: 'MvSpaceNews',
        }
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
        },
        {
          path: 'members',
          name: 'subscribedMvSpaceMembers',
          component: () => import( /* webpackChunkName: "SpaceUsers" */ '../components/Space/SpaceUsers'),
        },
        {
          path: 'reviews',
          name: 'subscribedMvSpaceReviews',
        },
        {
          path: 'news',
          name: 'subscribedMvSpaceNews',
        }
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
        },
        {
          path: 'members',
          name: 'TvSpaceMembers',
          component: () => import( /* webpackChunkName: "SpaceUsers" */ '../components/Space/SpaceUsers'),
        },
        {
          path: 'reviews',
          name: 'TvSpaceReviews',
        },
        {
          path: 'news',
          name: 'TvSpaceNews',
        }
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
        },
        {
          path: 'members',
          name: 'subscribedTvSpaceMembers',
          component: () => import( /* webpackChunkName: "SpaceUsers" */ '../components/Space/SpaceUsers'),
        },
        {
          path: 'reviews',
          name: 'subscribedTvSpaceReviews',
        },
        {
          path: 'news',
          name: 'subscribedTvSpaceNews',
        }
      ]
    },
    {
      path: '/users/:user_name',
      beforeEnter: guardMyroute,
      component: () => import( /* webpackChunkName: "UserTop" */ '../components/User/UserTop'),
      children: [{
          path: '',
          name: 'UserTop',
          component: () => import( /* webpackChunkName: "UserProfile" */ '../components/User/UserProfile'),
        },
        {
          path: 'posts',
          name: 'UserPosts',
          component: () => import( /* webpackChunkName: "UserPosts" */ '../components/User/UserPosts'),
        },
        {
          path: 'followings',
          name: 'UserFollowings',
          component: () => import( /* webpackChunkName: "UserFollowings" */ '../components/User/UserFollowings'),
        },
        {
          path: 'followers',
          name: 'UserFollowers',
          component: () => import( /* webpackChunkName: "UserFollowers" */ '../components/User/UserFollowers'),
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
    {
      path: '/search',
      name: 'Search',
      meta: {
        title: '気になる作品を探す'
      },
      component: () => import( /* webpackChunkName: "Search" */ '../components/Search/Search'),
    },
    {
      path: '/trending',
      name: 'trending',
      meta: {
        title: '注目の作品'
      },
      component: () => import( /* webpackChunkName: "Trending" */ '../components/Search/SearchList'),
    },
    {
      path: '/popular',
      name: 'popular',
      meta: {
        title: '人気の作品'
      },
      component: () => import( /* webpackChunkName: "Popular" */ '../components/Search/SearchList'),
    },
    {
      path: '/top-rated',
      name: 'topRated',
      meta: {
        title: '評価の高い作品'
      },
      component: () => import( /* webpackChunkName: "TopRated" */ '../components/Search/SearchList'),
    },
    {
      path: '/upcoming',
      name: 'upcoming',
      meta: {
        title: '公開・配信予定の作品'
      },
      component: () => import( /* webpackChunkName: "Upcoming" */ '../components/Search/SearchList'),
    },
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
        keepAlive: true
      },
      component: () => import /* webpackChunkName: "Tags" */('../components/Tag/TagTop'),
    }
  ]
});



router.beforeEach((to, from, next) => {
  document.title = to.meta.title + ' - Devio' || 'Devio';
  next();
});

export {
  router
};