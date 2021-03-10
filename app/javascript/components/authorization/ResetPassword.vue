<template>
  <v-container>
    <v-row class="top-part" />
    <v-row>
      <v-col cols=1 />
      <v-col cols=10>
        <v-text-field :type="visible ? 'text' : 'password'" v-model="password" background-color="#ffffff" class="rounded-xl inp-text" label="パスワード"
          outlined />
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=1 />
      <v-col cols=10>
        <v-text-field :type="visible ? 'text' : 'password'" v-model="password_confirmation" background-color="#ffffff" class="rounded-xl inp-text"
          label="パスワードの再入力" outlined />
      </v-col>
    </v-row>
    <v-row class="mt-n8">
      <v-col cols=1 />
      <v-col cols=10>
        <v-btn @click="resetPassword()" x-large class="rounded-xl" color="#000000" dark block>
          <div class="login-text">再設定する</div>
        </v-btn>
      </v-col>
    </v-row>
    <v-snackbar top color="black" v-model="snackbar">
      {{ notify_text }}
      <template v-slot:action="{attrs}">
        <v-btn color="white" text v-bind="attrs" @click="snackbar = false">
          閉じる
        </v-btn>
      </template>
    </v-snackbar>
  </v-container>
</template>

<script>
  import { simpleAxios } from '../../backend/axios.js'
  const PASSWORD_RESET_URL = '/api/v1/password_resets'

  export default {
    name: 'ResetPassword',
    data() {
      return {
        password: null,
        password_confirmation: null,
        error: null,
        snackbar: false,
        notify_text: null,
        visible: false,
      }
    },
    created() {
      this.checkPasswordToken()
      this.checkSignedIn()
    },
    updated(){
      this.checkSignedIn()
    },
    methods: {
      checkSignedIn(){
        if(this.$store.state.signedIn){
          this.$router.replace('/')
        }
      },
      resetPassword() {
        simpleAxios.patch(PASSWORD_RESET_URL + `/` + `${this.$route.params.token}`, {
            password: this.password,
            password_confirmation: this.password_confirmation
          })
          .then(response => this.resetSuccessful(response))
          .catch(error => this.resetFailed(error))
      },
      resetSuccessful(response) {
        this.notify_text = 'パスワードがリセットされました。'
        this.error = null
        this.password = null
        this.password_confirmation = null
        this.snackbar = true
        this.$router.replace('/')
      },
      resetFailed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || 'Something went wrong'
      },
      checkPasswordToken() {
        simpleAxios.get(PASSWORD_RESET_URL, {
            token: this.$route.params.token
          })
          .catch(error => {
            this.resetFailed(error)
            this.$router.replace('/')
        })
      }
    }
  }
</script>

<style scoped>
  .top-part {
    height: 320px;
  }

  .login-text {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 11px;
  }

  .switch-text {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 8px;
    color: #4361ee;
  }
</style>