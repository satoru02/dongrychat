<template>
  <v-container>
    <v-row class="top-part" />
    <v-row>
      <v-col cols=1 />
      <v-col cols=10>
        <v-text-field v-model="email" background-color="#ffffff" class="rounded-xl inp-text" label="Eメール" outlined />
      </v-col>
    </v-row>
    <v-row class="mt-n8">
      <v-col cols=1 />
      <v-col cols=10>
        <v-btn @click="resetPassword()" x-large class="rounded-xl" color="#000000" dark block>
          <div class="login-text">Eメールを送信する</div>
        </v-btn>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=8 />
      <v-col cols=3 class="ml-7">
        <div @click="makeAccount()" class="switch-text">アカウント登録</div>
      </v-col>
    </v-row>
    <v-row class="mt-n2">
      <v-col cols=8 />
      <v-col cols=3 class="ml-7">
        <div @click="haveAccount()" class="switch-text">ログイン</div>
      </v-col>
    </v-row>
    <v-snackbar top v-model="errorbar" color="black">
      <li v-for="error in errors" :key="error.id">{{error}}</li>
      <template v-slot:action="{attrs}">
        <v-btn color="white" text v-bind="attrs" @click="errorbar = false">
          閉じる
        </v-btn>
      </template>
    </v-snackbar>
    <v-snackbar top v-model="snackbar" color="black">
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
  import {
    simpleAxios
  } from '../../backend/axios.js'
  const PASSWORD_RESET_URL = '/api/v1/password_resets';

  export default {
    name: 'ForgotPassword',
    data() {
      return {
        email: null,
        errors: [],
        error: null,
        notice: null,
        notify_text: null,
        snackbar: false,
        errorbar: false,
        // email_rules: [v => v.length <= 235 || 'メールは最大235文字までです。'],
        counter: 235
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
      validEmail(email) {
        var reg =
          /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return reg.test(email);
      },
      checkInputValidation() {
        this.errors = []

        if (!this.email) {
          this.errors.push('メールアドレスが入力されていません。')
        } else if (!this.validEmail(this.email)) {
          this.errors.push('メールアドレスが有効な形式ではありません。')
        }

        if (this.errors.length) {
          return this.errorbar = true
        }
      },
      resetPassword() {
        this.checkInputValidation()
        if (!this.errors.length) {
          simpleAxios.post(PASSWORD_RESET_URL, {
              email: this.email
            })
            .then(res => this.submitSuccessful(res))
            .catch(error => this.submitFailed(error))
        }
      },
      submitSuccessful(res) {
        this.notify_text = 'パスワード再設定のメールを送信しました！メールボックスを確認ください。'
        this.snackbar = true
        this.email = null
      },
      submitFailed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ''
        this.notify_text = '入力されたEメールで登録されたユーザーは存在しません。'
        this.snackbar = true
        this.email = null
      },
      makeAccount() {
        this.$router.replace('/signup')
      },
      haveAccount() {
        this.$router.replace('/login')
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