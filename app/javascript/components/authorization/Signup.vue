<template>
  <v-container>
    <v-row class="top-part" />
    <v-row>
      <v-col cols=1 />
      <v-col cols=10>
        <v-text-field v-model="email" :type="'email'" background-color="#ffffff" class="rounded-xl inp-text"
          label="Eメール" outlined />
      </v-col>
    </v-row>
    <v-row class="mt-n6">
      <v-col cols=1 />
      <v-col cols=10>
        <v-text-field v-model="password" @click="visible = false" :type="visible ? 'text' : 'password'"
          background-color="#ffffff" class="rounded-xl inp-text" label="パスワード" outlined />
      </v-col>
    </v-row>
    <v-row class="mt-n6">
      <v-col cols=1 />
      <v-col cols=10>
        <v-text-field v-model="password_confirmation" @click="visible = false" :type="visible ? 'text': 'password'"
          background-color="#ffffff" class="rounded-xl inp-text" label="パスワードの確認" outlined />
      </v-col>
    </v-row>
    <v-row class="mt-n7">
      <v-col cols=1 />
      <v-col cols=10>
        <v-btn @click="signup()" x-large class="rounded-xl" color="#000000" dark block>
          <div class="reg-text">アカウント登録</div>
        </v-btn>
      </v-col>
    </v-row>
    <v-row class="mt-5">
      <v-col cols=1 />
      <v-col cols=4>
        <v-divider />
      </v-col>
      <v-col cols=3>
        <div class="setting-text mt-n2">snsで会員登録</div>
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
      <v-col cols=9 />
      <v-col cols=3>
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
  } from '../../backend/axios'
  const SIGNUP_URL = '/api/v1/signup'

  export default {
    name: 'Signup',
    data() {
      return {
        email: null,
        password: null,
        password_confirmation: null,
        errorbar: false,
        snackbar: false,
        errors: [],
        error: null,
        visible: true,
        // email_rules: [v => v.length <= 235 || 'メールは最大235文字までです。'],
        // password_rules: [v => v.length >= 6 && v.length <=100],
        counter: 235,
        notify_text: 'アカウント登録のメールを送信しました！メールボックスを確認ください。'
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
        return reg.test(email)
      },
      checkFormValidation() {
        this.errors = [];

        if (!this.email) {
          this.errors.push('メールアドレスが入力されていません。')
        } else if (!this.validEmail(this.email)) {
          this.errors.push('メールアドレスが有効な形式ではありません。')
        }

        if (!this.password) {
          this.errors.push('パスワードが入力されていません。')
        }
        if (!this.password_confirmation) {
          this.errors.push('パスワード確認の項目が入力されていません。')
        }
        if (this.errors.length) {
          return this.errorbar = true
        }
      },
      signup() {
        this.checkFormValidation()
        if (!this.errors.length) {
          simpleAxios.post(SIGNUP_URL, {
              email: this.email,
              password: this.password,
              password_confirmation: this.password_confirmation
            })
            .then(res => this.signupSuccessful(res))
            .catch(err => this.signupFailed(err))
        }
      },
      signupSuccessful(res) {
        this.snackbar = true
      },
      signupFailed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ''
      },
      haveAccount() {
        this.$router.push({
          name: 'login'
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

  .reg-text {
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

  .inp-text {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 17px;
    color: #dee2e6;
  }

  .bottom-part {
    height: 70px;
  }

  .sns-btn {
    background-color: #000000;
    font-weight: bold;
  }
</style>