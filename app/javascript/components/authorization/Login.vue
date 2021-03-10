<template>
  <v-container>
    <v-row class="top-part" />
    <v-row>
      <v-col cols=1 />
      <v-col cols=10>
        <v-text-field v-model="email" background-color="#ffffff" class="rounded-xl inp-text" label="Eメール" outlined />
      </v-col>
    </v-row>
    <v-row class="mt-n10">
      <v-col cols=1 />
      <v-col cols=10>
        <v-text-field :type="visible ? 'text' : 'password'" v-model="password" background-color="#ffffff"
          class="rounded-xl inp-text" label="パスワード" outlined />
      </v-col>
    </v-row>
    <v-row class="mt-n9">
      <v-col cols=6 />
      <v-col cols=5 class="ml-7">
        <div @click="forgetPassword()" class="setting-text">パスワードを忘れた場合はこちら</div>
      </v-col>
    </v-row>
    <v-row class="mt-n2">
      <v-col cols=1 />
      <v-col cols=10>
        <v-btn @click="signIn()" x-large class="rounded-xl" color="#000000" dark block>
          <div class="login-text">ログイン</div>
        </v-btn>
      </v-col>
    </v-row>
    <v-row class="mt-5">
      <v-col cols=1 />
      <v-col cols=4>
        <v-divider />
      </v-col>
      <v-col cols=3>
        <div class="setting-text mt-n2">snsでログイン</div>
      </v-col>
      <v-col cols=4 class="ml-n10">
        <v-divider />
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=2 class="ml-2" />
      <v-col cols=3>
        <v-btn class="sns-btn rounded-s" dark icon x-large>
          <v-icon>mdi-google</v-icon>
        </v-btn>
      </v-col>
      <v-col cols=3>
        <v-btn class="sns-btn rounded-s" dark icon x-large>
          <v-icon>mdi-apple</v-icon>
        </v-btn>
      </v-col>
      <v-col cols=2>
        <v-btn class="sns-btn rounded-s" dark icon x-large>
          <v-icon>mdi-facebook</v-icon>
        </v-btn>
      </v-col>
    </v-row>
    <v-row class="bottom-part" />
    <v-row>
      <v-col cols=8 />
      <v-col cols=3 class="ml-7">
        <div @click="makeAccount()" class="switch-text">アカウント登録</div>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
  import {
    simpleAxios,
    secureAxios
  } from '../../backend/axios';
  const LOGIN_URL = '/api/v1/login'
  const USER_INFO_URL = '/api/v1/users/me'

  export default {
    name: 'Login',
    data() {
      return {
        email: null,
        password: null,
        error: null,
        visible: false,
      }
    },
    created() {
      this.checkSignedIn()
    },
    updated() {
      this.checkSignedIn()
    },
    methods: {
      checkSignedIn() {
        if (this.$store.state.signedIn) {
          this.$router.replace('/')
        }
      },
      signIn() {
        simpleAxios.post(LOGIN_URL, {
            email: this.email,
            password: this.password
          })
          .then(res => this.signinSuccessful(res))
          .catch(err => this.signinFailed(err))
      },
      signinSuccessful(res) {
        if (!res.data.csrf) {
          this.signInFailed()
          return
        }
        simpleAxios.defaults.headers.common['Authorization'] = `Bearer ${res.data.access_token}`
        simpleAxios.get(USER_INFO_URL)
          .then(me_response => {
            this.$store.commit('setCurrentUser', {
              currentUser: me_response.data,
              csrf: res.data.csrf,
              token: res.data.access_token
            })
            this.error = ''
            this.$router.replace('/')
          })
          .catch(error => this.signinFailed(error))
      },
      signinFailed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ""
        this.$store.commit('unsetCurrentUser')
      },
      makeAccount() {
        this.$router.push({
          name: 'signup'
        })
      },
      forgetPassword() {
        this.$router.push({
          name: "ForgotPassword"
        })
      }
    }
  }
</script>

<style scoped>
  .top-part {
    height: 320px;
  }

  .theme--light.v-text-field>.v-input__control>.v-input__slot:before {
    border-color: orange;
  }

  .v-text-field--outlined>>>fieldset {
    border-color: #e9ecef;
  }

  .login-text {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 11px;
  }

  .setting-text {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 3px;
    color: #adb5bd;
  }

  .switch-text {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 8px;
    color: #4361ee;
  }

  .bottom-part {
    height: 70px;
  }

  .sns-btn {
    background-color: #000000;
    font-weight: bold;
  }
</style>