<template>
  <v-container>
    <v-app-bar elevation=1 outlined app color="#ffffff">

      <v-app-bar-nav-icon @click="drawer = !drawer" v-if="$vuetify.breakpoint.width < 600">
        <icon-base :width="'20'" :height="'20'" icon-name="icon-user" :iconColor="'#000000'" :viewBox="'0 0 124 124'">
          <icon-menu />
        </icon-base>
      </v-app-bar-nav-icon>

      <v-spacer v-if="$vuetify.breakpoint.width > 600" />
      <v-toolbar-title v-if="$vuetify.breakpoint.width > 600">
        <v-btn text color="#657482" style="font-size: 14px; font-weight: bold; color: #657482"
          @click="movePath('/trend')">
          <icon-new class="mr-3" />新着</v-btn>
      </v-toolbar-title>
      <v-toolbar-title v-if="$vuetify.breakpoint.width > 600">
        <v-btn @click="movePath('/popular')" text color="#ffffff"
          style="font-size: 14px; font-weight: bold; color: #657482">
          人気
        </v-btn>
      </v-toolbar-title>
      <v-toolbar-title v-if="$vuetify.breakpoint.width > 600">
        <v-btn @click="movePath('/top_rated')" text color="#ffffff"
          style="font-size: 14px; font-weight: bold; color: #657482">
          高評価
        </v-btn>
      </v-toolbar-title>
      <v-text-field placeholder="検索" @keypress="setQuery()" @keydown.enter="search(query)" v-model="query"
        :full-width="true" v-if="$vuetify.breakpoint.width > 600" dense
        background-color="#f0f5fa" solo flat class="rounded-lg mt-7" />
      <v-spacer />
      <v-menu left nudge-bottom="35" nudge-height="800">
        <template v-slot:activator="{on, attrs}">
          <div v-bind="attrs" v-on="on" @click="infiniteHandler()">
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
      <v-menu flat open-on-hover offset-y left nudge-bottom="3" nudge-height="800">
        <template v-slot:activator="{on, attrs}">
          <div v-bind="attrs" v-on="on">
            <v-avatar v-if="$store.state.user.currentUser.avatar_url" size="35">
              <v-img :src="$store.state.user.currentUser.avatar_url" />
            </v-avatar>
            <v-avatar v-else size="25">
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
      <v-btn v-if="(this.checkAuthorization()) && !$store.state.user.signedIn" @click="movePath('/login')"
        color="#ffffff" elevation=0 class="login mr-4" style="color: #000000">ログイン</v-btn>
      <v-btn v-if="(this.checkAuthorization()) && !$store.state.user.signedIn" @click="movePath('/signup')"
        color="#00bbf9" elevation=0 class="signup">
        <span style="color: #ffffff;">アカウント登録</span></v-btn>
    </v-app-bar>

    <v-navigation-drawer temporary v-model="drawer" class="" width=235 app dark style="background-color: #ffffff;">
      <v-text-field placeholder="検索" @keypress="setQuery()" @keydown.enter="search(query)" v-model="query"
        :full-width="true" dense background-color="#f0f5fa" solo flat class="rounded-lg mt-16" />
      <v-list dense nav class="rounded-lg">
        <v-subheader :style="category" class="">メニュー</v-subheader>
        <v-list-item-group color="primary" class="mt-1" min-width="200">
          <v-hover v-for="(item, index) in menus" :key="index">
            <v-list-item @click="changeRoute(item.path_name)" class="ml-1">
              <v-list-item-icon>
                <v-list-item-subtitle class="mt-1" :size="icon.size">
                  <icon-base v-if="item.text === 'ホーム'" :iconColor="'#000000'" icon-name="icon-home" :width="'17'"
                    :height="'17'" :viewBox="'0 0 512.05 512.05'">
                    <icon-home />
                  </icon-base>
                  <icon-base v-if="item.text === 'チャット'" :iconColor="'#000000'" icon-name="icon-following" :width="'17'"
                    :height="'17'" :viewBox="'0 0 511.996 511.996'">
                    <icon-following />
                  </icon-base>
                  <icon-base v-if="item.text === 'レビュー'" :iconColor="'#000000'" icon-name="icon-pen" :width="'17'"
                    :height="'17'" :viewBox="'0 0 512 512'">
                    <icon-pen />
                  </icon-base>
                  <icon-base v-if="item.text === 'コミュニティ'" :iconColor="'#000000'" icon-name="icon-bookmark"
                    :width="'17'" :height="'17'" :viewBox="'0 0 512 512'">
                    <icon-bookmark />
                  </icon-base>
                  <icon-base v-if="item.text === 'ランキング'" :iconColor="'#000000'" icon-name="icon-bookmark" :width="'17'"
                    :height="'17'" :viewBox="'0 0 512 512'">
                    <icon-bookmark />
                  </icon-base>
                </v-list-item-subtitle>
              </v-list-item-icon>
              <v-list-item-content class="ml-n4">
                <v-list-item-title :style="list_item_title.style">
                  {{item.text}}
                </v-list-item-title>
              </v-list-item-content>
              <v-list-item-action class="mt-5" v-if="(item.text === 'チャット') && new_comments">
                <v-badge color="#008dd5" dot />
              </v-list-item-action>
            </v-list-item>
          </v-hover>
        </v-list-item-group>
      </v-list>
      <v-subheader :style="category" class="mt-4 mb-2">注目のカテゴリー</v-subheader>
      <v-row justify="center" class="mt-n4">
        <v-col cols="12" class="ml-4">
          <v-chip-group column>
            <v-chip small outlined active-class="blue--text" class="mb-2 rounded-xl"
              style="width: auto; font-weight: bold;" @click="goTagPage(tag.attributes)" color="#000000" label
              v-for="(tag) in tags" :key="tag.attributes.name">
              {{tag.attributes.name}}
            </v-chip>
          </v-chip-group>
        </v-col>
      </v-row>
      <v-row no-gutters class="mt-1">
        <v-hover v-slot="{hover}">
          <v-col class="ml-4" cols=4 :style="hover ? hoverlink : unhoverlink" @click="changeRoute('Terms')">
            利用規約
          </v-col>
        </v-hover>
        <v-hover v-slot="{hover}">
          <v-col cols=6 :style="hover ? hoverlink : unhoverlink" class="ml-n4" @click="changeRoute('Privacy')">
            プライバシーポリシー
          </v-col>
        </v-hover>
      </v-row>
      <v-row no-gutters class="">
        <v-hover v-slot="{hover}">
          <v-col class="ml-4" cols=4 :style="hover ? hoverlink : unhoverlink">
            お問い合わせ
          </v-col>
        </v-hover>
        <v-hover v-slot="{hover}">

          <v-col cols=6 :style="hover ? hoverlink : unhoverlink">
            © 2021 Devio
          </v-col>
        </v-hover>
      </v-row>
    </v-navigation-drawer>

    <!-- <v-dialog v-model="loginDialog" width="400" transition="dialog-top-transition">
      <v-card color="#ffffff" height="250" class="rounded-lg">
        <v-row>
          <v-col lg=3 />
          <v-col lg=7>
            <div class="mt-9 ml-6" :style="dialog.headerStyle">Devioを使ってみる</div>
          </v-col>
        </v-row>
        <v-row>
          <v-col lg=1 />
          <v-col lg=10>
            <v-btn @click="goLogin()" block　:style="dialog.btnStyle" color="black" outlined elevation=0
              v-text="'ログイン'" />
          </v-col>
        </v-row>
        <v-row>
          <v-col lg=1 />
          <v-col lg=10>
            <v-btn block @click="goSignup()" :style="dialog.btnStyle" color="#016aff" elevation=0 v-text="'アカウント作成'" />
          </v-col>
        </v-row>
        <v-row>
          <v-col cols=3 sm=3 md=3 lg=3 xl=3 />
          <v-col cols=8 sm=8 md=8 lg=9 xl=8>
            <div class="ml-1" :style="dialog.policyStyle" v-text="'利用規約とプライバシーポリシーはこちら'" />
          </v-col>
        </v-row>
      </v-card>
    </v-dialog> -->
    <v-spacer />

  </v-container>
</template>

<script>
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const notificationsFactory = RepositoryFactory.get('notifications');
  const tagsRepository = RepositoryFactory.get('tags');
  const usersRepository = RepositoryFactory.get('users');

  export default {
    name: 'TheHeader',
    components: {
      'icon-base': () => import( /* webpackPrefetch */ '../Icon/IconBase'),
      'icon-user': () => import( /* webpackPrefetch */ '../Icon/IconUser'),
      'icon-new': () => import( /* webpackPrefetch */ '../Icon/IconNew'),
      'icon-menu': () => import( /* webpackPrefetch */ '../Icon/IconMenu'),
      'base-loader': () => import( /* webpackPrefetch: true */ '../Base/BaseInfiniteLoader'),
      'icon-home': () => import( /* webpackPrefetch: true */ '../Icon/IconHome.vue'),
      'icon-pen': () => import( /* webpackPrefetch: true */ '../Icon/IconPen.vue'),
      'icon-following': () => import( /* webpackPrefetch: true */ '../Icon/IconFollowing.vue')
    },
    data() {
      return {
        canSubmit: false,
        drawer: false,
        group: null,
        notifications: [],
        page: 1,
        pageSize: 10,
        loginDialog: false,
        new_comments: '',
        error: '',
        query: '',
        tags: [],
        text: {
          loading: '通知はありません。'
        },
        items: [{
            icon: 'mdi-account-outline',
            title: 'プロフィール',
            name: 'Posts',
            link: '/users/' + `${this.$store.state.user.currentUser.id}` + '/watchlists',
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
          },
          {
            icon: 'mdi-exit-run',
            title: 'ログアウト',
            link: '/logout'
          }
        ],
        menus: [{
            text: 'ホーム',
            path_name: 'Home'
          },
          {
            text: 'チャット',
            path_name: 'Following'
          },
          {
            text: 'レビュー',
            path_name: ''
          },
          {
            text: '新着の作品',
            path_name: ''
          },
          {
            text: '人気の作品',
            path_name: ''
          },
          {
            text: '評価の高い作品',
            path_name: ''
          },
        ],
        list_item: {
          position: 'mt-1'
        },
        icon: {
          size: 14,
          color: '#6c757d'
        },
        category: {
          fontWeight: 'bold',
          fontSize: '16px',
          color: '#657482',
        },
        list_item_title: {
          color: '#011627',
          style: {
            fontWeight: '600',
            fontSize: '14px',
            color: '#000000'
          }
        },
        dialog: {
          headerStyle: {
            color: '#111111',
            fontWeight: 'bold',
            fontSize: '17px',
          },
          btnStyle: {
            color: '#ffffff',
            fontWeight: 'bold',
            fontSize: '12px',
          },
          policyStyle: {
            color: '#6c757d',
            fontSize: '4px',
          }
        },
        hoverlink: {
          fontWeight: 'bold',
          fontSize: '9px',
          color: '#374151',
          cursor: 'pointer',
        },
        unhoverlink: {
          fontWeight: 'bold',
          fontSize: '9px',
          color: '#6c757d',
          cursor: 'pointer',
        }
      }
    },
    created() {
      this.fetchTags()
      this.fetchComments()
    },
    watch: {
      group() {
        this.drawer = false
      },
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
      },
      fetchTags() {
        tagsRepository.get()
          .then(res => this.fetchTagsSuccessful(res))
          .catch(err => this.fetchFailed(err))
      },
      fetchComments() {
        usersRepository.getNewComments(this.$store.state.user.currentUser.id)
          .then(res => this.fetchUsersSuccessful(res))
          .catch(err => this.fetchFailed(err))
      },
      fetchUsersSuccessful(res) {
        this.new_comments = res.data.new_comments
      },
      fetchTagsSuccessful(res) {
        this.tags = res.data.data
      },
      fetchFailed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      },
      changeRoute(path) {
        if ((path === 'Home') || (path === 'Settings')) {
          if (!this.$store.state.user.signedIn) {
            this.loginDialog = true
            return
          } else {
            this.$router.push({
              name: path
            }).catch(() => {});
          }
        } else {
          this.$router.push({
            name: path
          }).catch(() => {});
        }
      },
      goLogin() {
        this.$router.replace('/login')
      },
      goSignup() {
        this.$router.replace('/signup')
      },
      goTagPage(tag) {
        this.$router.replace({
          name: 'Tag',
          params: {
            name: tag.name,
          }
        })
      }
    }
  }
</script>

<style scoped>
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
    color: #515f6d;
    font-size: 13px;
  }

  .v-application .elevation-1 {
    box-shadow: 0 0px 1px -1px rgba(0, 0, -4, .2), 0 1px 1px 0 rgba(0, 0, 0, .04), 0 1px 0.3px 0 rgba(0, 0, 0, .02) !important;
  }
</style>