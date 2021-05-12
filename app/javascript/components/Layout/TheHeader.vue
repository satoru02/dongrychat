<template>
  <v-app-bar flat app color="#ffffff" v-if="$vuetify.breakpoint.width > 600">
    <v-toolbar-title style="cursor: pointer" @click="goTop()" class="ml-16" :style="logoStyle">Devio</v-toolbar-title>
    <v-spacer></v-spacer>
    <v-text-field @keypress="setQuery()" @keydown.enter="search(query)" v-model="query" height="10"
      v-if="this.checkAuthorization()" :prepend-inner-icon="'mdi-magnify'" dense background-color="#f6f6f9" solo flat
      :class="textField.round" />
    <v-spacer></v-spacer>
    <v-btn v-if="(this.checkAuthorization()) && !$store.state.signedIn" @click="goLogin()" outlined small color="blue"
      elevation=0 class="mt-11" :style="loginStyle">ログイン</v-btn>
    <v-btn v-if="(this.checkAuthorization()) && !$store.state.signedIn" @click="goSignup()" small color="blue"
      elevation=0 class="mt-11" :style="loginStyle">アカウント登録</v-btn>
    <v-avatar size="36" class="mr-16">
      <v-img :src="$store.state.currentUser.avatar_url" />
    </v-avatar>
  </v-app-bar>
</template>

<script>
export default {
  name: 'TheHeader',
  data(){
    return{
      query: '',
      canSubmit: false,
      textField: {
        placeholder: '検索',
        round: 'rounded-lg mt-7',
        width: 150,
      },
      logoStyle: {
        fontWeight: 'bold',
        fontFamily: 'Helvetica Neue, sans-serif',
        fontSize: '25px',
        color: '#000000'
      },
      loginStyle: {
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