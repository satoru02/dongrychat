import Vue from 'vue';
import VueRouter from 'vue-router';
import { store } from './store';
import HomeTop from '../components/Home/HomeTop';
import DetailTop from '../components/Detail/DetailsTop';
import SpaceTop from '../components/Space/SpaceTop';
import SpaceChats from '../components/Space/SpaceChats';
import SpaceUsers from '../components/Space/SpaceUsers';
import ChartTop from '../components/Chart/ChartTop';
import AccountActivation from '../components/Authorization/AccountActivation';
import ResetPassword from '../components/Authorization/ResetPassword';
import Login from '../components/Authorization/Login';
import Logout from '../components/Authorization//Logout';
import Signup from '../components/Authorization/Signup';
import ForgotPassword from '../components/Authorization/ForgotPassword';
import Search from '../components/Search/Search';
import Results from '../components/Search/SearchResults';
import UserFollowings from '../components/User/UserFollowings';
import UserFollowers from '../components/User/UserFollowers';
import UserTop from '../components/User/UserTop';
import UserPosts from '../components/User/UserPosts';
import UserProfile from '../components/User/UserProfile';
import UserSettings from '../components/User/UserSettings';
import SearchList from '../components/Search/SearchList';
import Privacy from '../components/Overview/Privacy';
import Terms from '../components/Overview//Terms';
import NotificationTop from '../components/Notification/NotificationTop';
import TagTop from '../components/Tag/TagTop';

Vue.use(VueRouter);

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

var router = new VueRouter({
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
        title: 'チャート',
        keepAlive: true,
      }
    },
    {
      path: '/home',
      name: 'Home',
      beforeEnter: guardMyroute,
      component: HomeTop,
      meta: {
        title: 'ホーム',
        keepAlive: true,
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
        },
        {
          path: 'news',
          name: 'subscribedTvSpaceNews',
        }
      ]
    },
    {
      path: '/:user_name',
      component: UserTop,
      beforeEnter: guardMyroute,
      children: [
        {
          path: '',
          name: 'UserTop',
          component: UserProfile,
        },
        {
          path: 'posts',
          name: 'UserPosts',
          component: UserPosts,
        },
        {
          path: 'followings',
          name: 'UserFollowings',
          component: UserFollowings,
        },
        {
          path: 'followers',
          name: 'UserFollowers',
          component: UserFollowers,
        },
      ]
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
    },
    {
      path: "/privacy",
      name: "Privacy",
      component: Privacy,
      meta: {
        title: 'プライバシーポリシー',
        keepAlive: true
      }
    },
    {
      path: "/terms",
      name: "Terms",
      component: Terms,
      meta: {
        title: '利用規約',
        keepAlive: true
      }
    },
    {
      path: "/notifications",
      name: "NotificationTop",
      component: NotificationTop,
      meta: {
        title: '通知',
        keepAlive: true
      }
    },
    {
      path: "/tag/:name",
      name: "Tag",
      component: TagTop,
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