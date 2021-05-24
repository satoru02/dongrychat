import Vue from 'vue';
import VueRouter from 'vue-router';
import { store } from '../stores/index';
import ChartTop from '../components/Chart/ChartTop';

Vue.use(VueRouter);

function guardMyroute(to, from, next){
  if(store.state.user.signedIn){
    next();
  } else {
    next('/login');
  }
}
function guardMultiLogin(to, from, next){
  if(!store.state.user.signedIn){
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
      component: () => import('../components/Authorization/Signup'),
      beforeEnter: guardMultiLogin,
      meta: {
        title: 'アカウント登録'
      }
    },
    {
      path: '/login',
      name: 'Login',
      component: () => import('../components/Authorization/Login'),
      beforeEnter: guardMultiLogin,
      meta: {
        title: 'ログイン'
      }
    },
    {
      path: "/account_activations/:token",
      name: "AccountActivation",
      component: () => import('../components/Authorization/AccountActivation'),
      beforeEnter: guardMultiLogin
    },
    {
      path: '/forgot_password',
      name: 'ForgotPassword',
      component: () => import('../components/Authorization/ForgotPassword'),
      beforeEnter: guardMultiLogin,
      meta: {
        title: 'パスワードを忘れた'
      }
    },
    {
      path: "/password_resets/:token",
      name: "ResetPassword",
      component: () => import('../components/Authorization/ResetPassword'),
      beforeEnter: guardMultiLogin,
      meta: {
        title: 'パスワードの再設定'
      }
    },
    {
      path: '/logout',
      name: 'Logout',
      component: () => import('../components/Authorization/Logout'),
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
      component: () => import('../components/Home/HomeTop'),
      meta: {
        title: 'ホーム',
        keepAlive: true,
      }
    },
    {
      path: '/tv/:id/:tv_name/season/:number',
      name: 'TvDetails',
      component: () => import('../components/Detail/DetailsTop'),
    },
    {
      path: '/mv/:id/:mv_name',
      name: 'MvDetails',
      component: () => import('../components/Detail/DetailsTop'),
    },
    {
      path: '/mv_space/m/:name',
      props: true,
      component: () => import('../components/Space/SpaceTop'),
      beforeEnter: guardMyroute,
      children: [
        {
          path: 'chats',
          name: 'MvSpace',
          component: () => import('../components/Space/SpaceChats'),
        },
        {
          path: 'members',
          name: 'MvSpaceMembers',
          component: () => import('../components/Space/SpaceUsers'),
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
      component: () => import('../components/Space/SpaceTop'),
      beforeEnter: guardMyroute,
      children: [
        {
          path: 'chats',
          name: 'subscribedMvSpace',
          component: () => import('../components/Space/SpaceChats'),
        },
        {
          path: 'members',
          name: 'subscribedMvSpaceMembers',
          component: () => import('../components/Space/SpaceUsers'),
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
      component: () => import('../components/Space/SpaceTop'),
      beforeEnter: guardMyroute,
      children: [
        {
          path: 'chats',
          name: 'TvSpace',
          component: () => import('../components/Space/SpaceChats'),
        },
        {
          path: 'members',
          name: 'TvSpaceMembers',
          component: () => import('../components/Space/SpaceUsers'),
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
      component: () => import('../components/Space/SpaceTop'),
      beforeEnter: guardMyroute,
      children: [
        {
          path: 'chats',
          name: 'subscribedTvSpace',
          component: () => import('../components/Space/SpaceChats'),
        },
        {
          path: 'members',
          name: 'subscribedTvSpaceMembers',
          component: () => import('../components/Space/SpaceUsers'),
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
      component: () => import('../components/User/UserTop'),
      beforeEnter: guardMyroute,
      children: [
        {
          path: '',
          name: 'UserTop',
          component: () => import('../components/User/UserProfile'),
        },
        {
          path: 'posts',
          name: 'UserPosts',
          component: () => import('../components/User/UserPosts'),
        },
        {
          path: 'followings',
          name: 'UserFollowings',
          component: () => import('../components/User/UserFollowings'),
        },
        {
          path: 'followers',
          name: 'UserFollowers',
          component: () => import('../components/User/UserFollowers'),
        },
      ]
    },
    {
      path: '/settings',
      name: 'Settings',
      beforeEnter: guardMyroute,
      component: () => import('../components/User/UserSettings'),
      meta: {
        title: 'アカウント設定'
      }
    },
    {
      path: '/search',
      name: 'Search',
      component: () => import('../components/Search/Search'),
      meta: {
        title: '気になる作品を探す'
      }
    },
    {
      path: '/trending',
      name: 'trending',
      component: () => import('../components/Search/SearchList'),
      meta: {
        title: '注目の作品'
      }
    },
    {
      path: '/popular',
      name: 'popular',
      component: () => import('../components/Search/SearchList'),
      meta: {
        title: '人気の作品'
      }
    },
    {
      path: '/top-rated',
      name: 'topRated',
      component: () => import('../components/Search/SearchList'),
      meta: {
        title: '評価の高い作品'
      }
    },
    {
      path: '/upcoming',
      name: 'upcoming',
      component: () => import('../components/Search/SearchList'),
      meta: {
        title: '公開・配信予定の作品'
      }
    },
    {
      path: '/results/:query',
      name: 'multi',
      props: true,
      component: () => import('../components/Search/SearchResults'),
      meta: {
        title: '検索結果'
      },
      children: [
        {
          path: "person",
          name: "person",
          component: () => import('../components/Search/SearchResults'),
          props: (route) => ({
            query: route.query.status
          })
        },
        {
          path: "tv",
          name: "tv",
          component: () => import('../components/Search/SearchResults'),
          props: (route) => ({
            query: route.query.status
          })
        },
        {
          path: "movie",
          name: "movie",
          component: () => import('../components/Search/SearchResults'),
          props: (route) => ({
            query: route.query.status
          })
        },
        {
          path: "Company",
          name: "Company",
          component: () => import('../components/Search/SearchResults'),
          props: (route) => ({
            query: route.query.status
          })
        }
      ]
    },
    {
      path: "/privacy",
      name: "Privacy",
      component: () => import('../components/Overview/Privacy'),
      meta: {
        title: 'プライバシーポリシー',
        keepAlive: true
      }
    },
    {
      path: "/terms",
      name: "Terms",
      component: () => import('../components/Overview/Terms'),
      meta: {
        title: '利用規約',
        keepAlive: true
      }
    },
    {
      path: "/notifications",
      name: "NotificationTop",
      component: () => import('../components/Notification/NotificationTop'),
      meta: {
        title: '通知',
        keepAlive: true
      }
    },
    {
      path: "/tag/:name",
      name: "Tag",
      component: () => import('../components/Tag/TagTop'),
      meta: {
        keepAlive: true
      }
    }
  ]
});

router.beforeEach((to, from ,next) => {
  document.title = to.meta.title + ' - Devio' || 'Devio';
  next();
});

export { router };