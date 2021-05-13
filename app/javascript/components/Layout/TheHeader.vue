<template>
  <v-app-bar flat outlined app color="#ffffff" v-if="$vuetify.breakpoint.width > 600">
    <div class="ml-5"></div>
    <v-toolbar-title style="cursor: pointer" @click="goTop()" class="ml-16" :style="logoStyle">Devio</v-toolbar-title>
    <v-spacer></v-spacer>
    <v-text-field @keypress="setQuery()" @keydown.enter="search(query)" v-model="query" height="10"
      v-if="this.checkAuthorization()" :prepend-inner-icon="'mdi-magnify'" dense background-color="#f6f6f9" solo flat
      :class="textField.round" />
    <v-spacer></v-spacer>
    <v-avatar size="36" class="mr-16">
      <v-img :src="$store.state.currentUser.avatar_url" />
    </v-avatar>
    <v-btn v-if="(this.checkAuthorization()) && !$store.state.signedIn" @click="goLogin()" outlined small color="#f6f6f9"
      elevation=0 class="mr-4" :style="loginStyle">ログイン</v-btn>
    <v-btn v-if="(this.checkAuthorization()) && !$store.state.signedIn" @click="goSignup()" small color="#016aff"
      elevation=0 class="" :style="signupStyle">アカウント登録</v-btn>
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
        round: 'rounded-lg mt-7 ml-13 mr-16',
        width: 150,
      },
      logoStyle: {
        fontWeight: 'bold',
        fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
        fontSize: '25px',
        color: '#016aff'
      },
      loginStyle: {
        fontWeight: 'bold',
        fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
        fontSize: '12px',
        color: '#111111'
      },
      signupStyle: {
        fontWeight: 'bold',
        fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
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