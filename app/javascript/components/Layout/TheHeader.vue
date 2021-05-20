<template>
  <v-app-bar elevation=1 outlined app color="#ffffff" v-if="$vuetify.breakpoint.width > 600">
    <div class="ml-11"></div>
    <v-toolbar-title class="logo ml-10" @click="goTop()">devio</v-toolbar-title>
    <v-divider vertical inset class="ml-3" />
    <v-toolbar-title @click="goTop()" class="beta-logo ml-3 mt-1">
      β 0.5
    </v-toolbar-title>
    <v-spacer></v-spacer>
    <v-text-field placeholder="検索..." @keypress="setQuery()" @keydown.enter="search(query)" v-model="query" height="10"
      :full-width="true" v-if="this.checkAuthorization()" :prepend-inner-icon="'mdi-magnify'" dense
      background-color="#e9ecef" solo flat class="text-field rounded-lg mt-7 ml-3 mr-8" />
    <v-avatar size="30" class="mr-5">
      <v-img :src="$store.state.currentUser.avatar_url" />
    </v-avatar>
    <v-btn v-if="(this.checkAuthorization()) && !$store.state.signedIn" @click="goLogin()" outlined small
      color="#f6f6f9" elevation=0 class="login mr-4">ログイン</v-btn>
    <v-btn v-if="(this.checkAuthorization()) && !$store.state.signedIn" @click="goSignup()" small color="#016aff"
      elevation=0 class="signup">アカウント登録</v-btn>
  </v-app-bar>
</template>

<script>
  export default {
    name: 'TheHeader',
    data() {
      return {
        query: '',
        canSubmit: false,
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
    font-size: 22px;
    color: #011627;
    cursor: pointer;
  }

  .beta-logo {
    font-weight: bold;
    font-size: 12px;
    color: #657786;
    cursor: pointer;
  }

  .text-field {
    max-width: 232px;
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
</style>