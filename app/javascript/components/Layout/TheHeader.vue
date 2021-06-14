<template>
  <v-app-bar elevation=0 outlined app color="#161b22">
    <div :class="headerL" />
    <v-toolbar-title style="font-weight: bold; color: #ffffff" :class="headerTitle" @click="goTop()">
      devio
    </v-toolbar-title>
    <v-toolbar-title style="font-size: 12px; font-weight: bold; color: #ffffff" class="ml-16" @click="goTop()">
    人気
    </v-toolbar-title>
    <v-toolbar-title style="font-size: 12px; font-weight: bold; color: #ffffff" class="ml-8" @click="goTop()">
    新着
    </v-toolbar-title>
    <v-toolbar-title style="font-size: 12px; font-weight: bold; color: #ffffff" class="ml-8" @click="goTop()">
    高評価
    </v-toolbar-title>
    <v-spacer></v-spacer>
    <v-text-field dark placeholder="気になる作品を検索" @keypress="setQuery()" @keydown.enter="search(query)" v-model="query"
      :full-width="true" v-if="this.checkAuthorization()" dense
      background-color="#0d1117" outlined solo flat class="text-field rounded-lg mt-6 ml-n16 mr-16" />
    <v-spacer></v-spacer>
    <v-menu left nudge-bottom="35" nudge-height="800">
      <template v-slot:activator="{on, attrs}">
        <div v-bind="attrs" v-on="on" @click="infiniteHandler()">
          <v-btn icon>
            <icon-base icon-name="icon-bell" :viewBox="'0 0 509.369 509.369'"><icon-bell /></icon-base>
          </v-btn>
        </div>
      </template>
      <v-list class="rounded-s list" v-if="$store.state.user.signedIn">
        <v-list-item v-for="(notification, index) in notifications" :key=index link :to='"/notifications"'>
          <v-list-item-icon>
            <v-avatar size=30>
              <v-img v-if="notification.attributes.sender.data.attributes.avatar_url" :src="notification.attributes.sender.data.attributes.avatar_url">
              </v-img>
              <v-img v-else src="https://gravatar.com/avatar/6ee07d61d8988eff9a020e93752680c4?s=400&d=robohash&r=x">
              </v-img>
            </v-avatar>
          </v-list-item-icon>
          <v-list-item-title class="list-title">
            {{notification.attributes.sender.data.attributes.name}}にフォローされました。
          </v-list-item-title>
        </v-list-item>
      </v-list>
      <base-loader :handler="infiniteHandler" :text="text.loading" />
    </v-menu>
    <v-menu flat open-on-hover offset-y left nudge-bottom="3" nudge-left="50" nudge-height="800">
      <template v-slot:activator="{on, attrs}">
        <div v-bind="attrs" v-on="on">
          <v-avatar size="25" class="ml-5 mr-16">
            <v-img :src="$store.state.user.currentUser.avatar_url" />
          </v-avatar>
        </div>
      </template>
      <v-list elevation=0 class="rounded-s list" v-if="$store.state.user.signedIn">
        <v-list-item v-for="(item, index) in items" :key="index" :to="item.link" :icon="item.icon" link>
          <v-list-item-icon>
            <v-icon v-text="item.icon" />
          </v-list-item-icon>
          <v-list-item-title class="list-title">{{ item.title }}
          </v-list-item-title>
        </v-list-item>
      </v-list>
    </v-menu>

    <v-btn v-if="(this.checkAuthorization()) && !$store.state.user.signedIn" @click="goLogin()" outlined small
      color="#f6f6f9" elevation=0 class="login mr-4">ログイン</v-btn>
    <v-btn v-if="(this.checkAuthorization()) && !$store.state.user.signedIn" @click="goSignup()" small color="#016aff"
      elevation=0 class="signup">アカウント登録</v-btn>
  </v-app-bar>
</template>

<script>

  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const notificationsFactory = RepositoryFactory.get('notifications');

  export default {
    name: 'TheHeader',
    components: {
      'icon-base': () => import( /* webpackPrefetch */ '../Icon/IconBase'),
      'icon-bell': () => import( /* webpackPrefetch */ '../Icon/IconBell'),
      'base-loader': () => import( /* webpackPrefetch: true */ '../Base/BaseInfiniteLoader'),
    },
    data() {
      return {
        query: '',
        canSubmit: false,
        notifications: [],
        page: 1,
        pageSize: 10,
        text: {
          loading: '通知はありません。'
        },
        items: [{
            icon: 'mdi-account-outline',
            title: 'プロフィール',
            name: 'Posts',
            link: '/users/' + `${this.$store.state.user.currentUser.id}`,
          },
          {
            icon: 'mdi-mailbox-outline',
            title: '通知',
            link: '/notifications'
          },
          {
            icon: 'mdi-wrench-outline',
            title: 'アカウント設定',
            link: '/settings'
          },
          {
            icon: 'mdi-help',
            title: 'ヘルプ',
            // link: '/posts/new'
          },
          {
            icon: 'mdi-exit-run',
            title: 'ログアウト',
            link: '/logout'
          }
        ]
      }
    },
    computed: {
      headerL() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return `ml-1`
          default:
            return `ml-14`
        }
      },
      headerTitle() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return `logo`
          default:
            return `logo ml-n10 mt-n1`
        }
      }

    },
    methods: {
      checkAuthorization() {
        let validationRouter = ['Login', 'Signup', 'Authorization', 'ResetPassword', 'ForgotPassword']
        if (validationRouter.includes(this.$route.name)) {
          return false
        } else {
          return true
        }
      },
      setQuery() {
        this.canSubmit = true
      },
      search(query) {
        if (!this.canSubmit) {
          return
        }
        this.$router.replace({
          name: 'multi',
          params: {
            query: query
          }
        })
        this.query = ''
        this.canSubmit = false
      },
      goLogin() {
        this.$router.replace('/login')
      },
      goSignup() {
        this.$router.replace('/signup')
      },
      goTop() {
        this.$router.replace('/')
      },
      infiniteHandler($state) {
        setTimeout(() => {
          notificationsFactory.get({
              page: this.page,
              per_page: this.pageSize
            })
            .then(res => {
              if (res.data.data.length) {
                this.page += 1
                this.notifications = res.data.data
                $state.loaded()
              } else {
                $state.complete();
              }
            })
        }, 50);
      }
    }
  }
</script>

<style scoped>
  .v-divider--vertical.v-divider--inset {
    margin-top: 8px;
    min-height: 0;
    max-height: calc(65% - 16px);
    margin-top: 19px;
  }

  .v-application .elevation-1 {
    box-shadow: 0 1px 1px -1px rgba(0, 0, 0, .2), 0 1px 1px 0 rgba(0, 0, 0, -1), 0 1px 3px 0 rgba(0, 0, 0, .02) !important;
  }

  .logo {
    cursor: pointer;
    color: #000000;
  }

  .beta-logo {
    font-weight: bold;
    font-size: 12px;
    color: #ffffff;
    cursor: pointer;
  }

  .text-field {
    max-width: 672px;
    color: #ffffff;
  }

  .login {
    font-weight: bold;
    font-size: 12px;
    color: #111111;
  }

  .signup {
    font-weight: bold;
    font-size: 12px;
    color: #ffffff;
  }

  .list {
    background-color: #f5f8fa;
  }

  .list-title {
    color: #011627;
    font-size: 13px;
    /* font-weight: bold */
  }

</style>

