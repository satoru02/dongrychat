<template>
  <v-app-bar elevation=0 outlined app color="#161a1d">
    <div :class="headerL" />
    <v-toolbar-title :class="headerTitle" @click="goTop()">devio</v-toolbar-title>
    <v-divider vertical inset class="ml-3" />
    <v-toolbar-title @click="goTop()" class="beta-logo ml-1 mt-1">
      β 0.5
    </v-toolbar-title>

    <!-- <v-toolbar-title @click="goTop()" class="beta-logo ml-16 mt-1">
      メニュー
    </v-toolbar-title>
    <v-toolbar-title @click="goTop()" class="beta-logo ml-10 mt-1">
      探す
    </v-toolbar-title> -->
    <!-- <v-toolbar-title @click="goTop()" class="beta-logo ml-10 mt-1">
      devioについて
    </v-toolbar-title> -->
    <v-spacer></v-spacer>

    <v-text-field placeholder="気になる作品を検索" @keypress="setQuery()" @keydown.enter="search(query)" v-model="query"
      :full-width="true" v-if="this.checkAuthorization()" :prepend-inner-icon="'mdi-magnify'" dense
      background-color="#ced4da" outlined class="text-field rounded-lg mt-6 ml-12 mr-16" />
    <v-spacer></v-spacer>
    <v-btn icon>
      <v-icon color="white">mdi-bell-outline</v-icon>
    </v-btn>
    <v-menu open-on-hover offset-y left nudge-top="5" nudge-right="0" nudge-width="130" nudge-height="800">
      <template v-slot:activator="{on, attrs}">
        <div v-bind="attrs" v-on="on">
          <v-avatar size="20" class="ml-5 mr-16">
            <v-img :src="$store.state.user.currentUser.avatar_url" />
          </v-avatar>
        </div>
      </template>
      <v-list class="rounded-s list" v-if="$store.state.user.signedIn">
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
  import '@mdi/font/css/materialdesignicons.css';

  export default {
    name: 'TheHeader',
    data() {
      return {
        query: '',
        canSubmit: false,
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
            return `ml-11`
        }
      },
      headerTitle() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return `logo`
          default:
            return `logo ml-10`
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
    font-weight: bold;
    font-size: 19px;
    color: #ffffff;
    cursor: pointer;
  }

  .beta-logo {
    font-weight: bold;
    font-size: 12px;
    color: #ffffff;
    cursor: pointer;
  }

  .text-field {
    max-width: 672px;
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
    font-weight: bold
  }
</style>