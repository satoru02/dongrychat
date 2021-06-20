<template>
  <!-- <v-app-bar dense elevation=0 app color="#ffffff" style="opacity: 0.71; backdrop-filter: saturate(180%) blur(10px);"> -->
  <v-app-bar elevation=0 outlined dense app color="#000000">

    <v-toolbar-title class="ml-1">
      <v-btn text color="#657482" style="font-size: 14px; font-weight: bold; color: #657482"
        @click="movePath('/trend')">
        <icon-new class="mr-3" />新着</v-btn>
    </v-toolbar-title>
    <v-toolbar-title class="ml-6">
      <v-btn @click="movePath('/popular')" text color="#ffffff"
        style="font-size: 14px; font-weight: bold; color: #657482">
        人気
      </v-btn>
    </v-toolbar-title>
    <v-toolbar-title class="ml-6">
      <v-btn @click="movePath('/top_rated')" text color="#ffffff"
        style="font-size: 14px; font-weight: bold; color: #657482">
        高評価
      </v-btn>
    </v-toolbar-title>
    <v-spacer />
    <!-- <v-text-field placeholder="気になる作品を検索" @keypress="setQuery()" @keydown.enter="search(query)" v-model="query"
      :full-width="true" v-if="this.checkAuthorization()" dense background-color="#161b22" solo flat
      class="rounded-lg mt-7 ml-16 mr-16 " /> -->
    <v-menu left nudge-bottom="35" nudge-height="800">
      <template v-slot:activator="{on, attrs}">
        <div v-bind="attrs" v-on="on" @click="infiniteHandler()">
          <!-- <v-btn icon>
            <icon-base icon-name="icon-bell" :iconColor="'#606770'" :viewBox="'-42 0 512 512.001'">
              <icon-bell />
            </icon-base>
          </v-btn> -->
        </div>
      </template>
      <v-list class="rounded-s list" v-if="$store.state.user.signedIn">
        <v-list-item v-for="(notification, index) in notifications" :key=index link :to='"/notifications"'>
          <v-list-item-icon>
            <v-avatar size=35 color="blue">
              <v-img v-if="notification.attributes.sender.data.attributes.avatar_url"
                :src="notification.attributes.sender.data.attributes.avatar_url">
              </v-img>
              <span v-else>
                <icon-base :width="'20'" :height="'20'" icon-name="icon-user" :iconColor="'#ffffff'"
                  :viewBox="'-42 0 512 512.002'">
                  <icon-user />
                </icon-base>
              </span>
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
          <v-avatar v-if="$store.state.user.currentUser.avatar_url" size="25" class="ml-5 mr-16">
            <v-img :src="$store.state.user.currentUser.avatar_url" />
          </v-avatar>
          <v-avatar v-else size="25" class="ml-5 mr-16">
            <icon-base :width="'20'" :height="'20'" icon-name="icon-user" :iconColor="'#ffffff'"
              :viewBox="'-42 0 512 512.002'">
              <icon-user />
            </icon-base>
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
    <v-btn v-if="(this.checkAuthorization()) && !$store.state.user.signedIn" @click="movePath('/login')" outlined small
      color="#f6f6f9" elevation=0 class="login mr-4">ログイン</v-btn>
    <v-btn v-if="(this.checkAuthorization()) && !$store.state.user.signedIn" @click="movePath('/singup')" small
      color="#016aff" elevation=0 class="signup">アカウント登録</v-btn>
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
      'icon-user': () => import( /* webpackPrefetch */ '../Icon/IconUser'),
      'icon-new': () => import( /* webpackPrefetch */ '../Icon/IconNew'),
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
            return `ml-3`
        }
      },
      headerTitle() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return ``
          default:
            return `ml-16 mt-n1`
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
      movePath(path) {
        this.$router.replace(path)
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
        }, 0);
      }
    }
  }
</script>

<style scoped>
  .v-application .elevation-1 {
    box-shadow: 0 1px 1px -1px rgba(0, 0, 0, .2), 0 1px 1px 0 rgba(0, 0, 0, -1), 0 1px 3px 0 rgba(0, 0, 0, .02) !important;
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
  }
</style>