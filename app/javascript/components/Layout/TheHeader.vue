<template>
  <v-app-bar flat outlined app color="#ffffff" v-if="$vuetify.breakpoint.width > 600">
    <div class="ml-5"></div>
    <v-toolbar-title style="cursor: pointer" @click="goTop()" class="ml-16" :style="logoStyle">Devio</v-toolbar-title>
    <v-divider vertical inset class="ml-3" />
    <v-toolbar-title style="cursor: pointer" @click="goTop()" class="ml-3 mt-2" :style="logoTextStyle">
      β 0.5
    </v-toolbar-title>
    <!-- <v-toolbar-title style="cursor: pointer" @click="goTop()" class="ml-3 mt-2" :style="logoTextStyle">
      映画の話が出来る場所
    </v-toolbar-title> -->
    <v-spacer></v-spacer>
    <v-spacer></v-spacer>

    <!-- <v-img class="rounded-lg ml-16 mt-1" elevation="0" height="45" width="635" src="https://picsum.photos/510/300?random"></v-img> -->

    <v-spacer></v-spacer>
    <v-text-field placeholder="検索..." @keypress="setQuery()" @keydown.enter="search(query)" v-model="query" height="10"
      :full-width="true" v-if="this.checkAuthorization()" :prepend-inner-icon="'mdi-magnify'" dense
      background-color="#f6f6f9" solo flat :class="textField.round" style="max-width: 165px;" />
    <!-- <v-spacer></v-spacer> -->
    <!-- <v-btn icon>
      <v-icon class="ml-n4" color="#000000">mdi-bell-outline</v-icon>
    </v-btn> -->
    <v-avatar size="30" class="mr-16">
      <v-img :src="$store.state.currentUser.avatar_url" />
    </v-avatar>
    <v-btn v-if="(this.checkAuthorization()) && !$store.state.signedIn" @click="goLogin()" outlined small
      color="#f6f6f9" elevation=0 class="mr-4" :style="loginStyle">ログイン</v-btn>
    <v-btn v-if="(this.checkAuthorization()) && !$store.state.signedIn" @click="goSignup()" small color="#016aff"
      elevation=0 class="" :style="signupStyle">アカウント登録</v-btn>
  </v-app-bar>
</template>

<script>
  export default {
    name: 'TheHeader',
    data() {
      return {
        query: '',
        canSubmit: false,
        textField: {
          placeholder: '検索',
          round: 'rounded-lg mt-7 ml-10 mr-5',
          width: 50,
        },
        logoStyle: {
          fontWeight: 'bold',
          fontFamily: 'Helvetica Neue, sans-serif',
          fontSize: '25px',
          color: '#016aff'
        },
        logoTextStyle: {
          fontWeight: 'bold',
          fontFamily: '',
          fontSize: '12px',
          color: '#5d666e'
        },
        loginStyle: {
          fontWeight: 'bold',
          fontFamily: 'Helvetica Neue, sans-serif',
          fontSize: '12px',
          color: '#111111'
        },
        signupStyle: {
          fontWeight: 'bold',
          fontFamily: 'Helvetica Neue, sans-serif',
          fontSize: '12px',
          color: '#ffffff'
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
</style>