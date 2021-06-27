<template>
    <v-container class="" dark app permanent style="background-color: #ffffff;">
      <v-list dense nav class="rounded-lg ">
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
                  <icon-base v-if="item.text === 'レビュー'" :iconColor="'#000000'" icon-name="icon-bookmark" :width="'17'"
                    :height="'17'" :viewBox="'0 0 512 512'">
                    <icon-bookmark />
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
      <v-subheader :style="category" class="mt-4 mb-2">カテゴリーから探す</v-subheader>
      <v-row justify="center" class="mt-n4">
        <v-col cols="12" sm="7" md="6" lg="11" class="ml-2">
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
        <v-col class="ml-4" lg=4 :style="hover ? hoverlink : unhoverlink" @click="changeRoute('Terms')">
          利用規約
        </v-col>
      </v-hover>
      <v-hover v-slot="{hover}">
        <v-col lg=8 :style="hover ? hoverlink : unhoverlink" class="ml-n4" @click="changeRoute('Privacy')">
          プライバシーポリシー
        </v-col>
      </v-hover>
    </v-row>
    <v-row no-gutters class="ml-16">
      <v-hover v-slot="{hover}">
        <v-col class="ml-4" lg=3 :style="hover ? hoverlink : unhoverlink">
          お問い合わせ
        </v-col>
      </v-hover>
      <v-hover v-slot="{hover}">

        <v-col lg=4 :style="hover ? hoverlink : unhoverlink">
          © 2021 Devio
        </v-col>
      </v-hover>
    </v-row>
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
      'icon-bookmark': () => import( /* webpackPrefetch: true */ '../Icon/IconBookmark.vue'),
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
            path_name: 'Trend'
          },
          {
            text: 'チャット',
            path_name: 'Following'
          },
          {
            text: 'ランキング',
            path_name: 'Ranking'
          },
          {
            text: 'レビュー',
            path_name: ''
          },
          {
            text: 'コミュニティ',
            path_name: 'Trend'
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
    color: #011627;
    font-size: 13px;
  }

  .v-application .elevation-1 {
    box-shadow: 0 0px 1px -1px rgba(0,0,-4,.2),0 1px 1px 0 rgba(0,0,0,.04),0 1px 0.3px 0 rgba(0,0,0,.02)!important;
}
</style>