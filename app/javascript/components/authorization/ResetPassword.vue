<template>
  <v-container>
    <v-row :style="$vuetify.breakpoint.width < 600 ? topPartMobile : topPartStyle">
      <v-col cols=12 sm=12 md=12 lg=12 xl=12 />
    </v-row>
    <v-row>
      <v-col cols=2 sm=2 md=2 lg=2 xl=4 />
      <v-col cols=8 sm=8 md=8 lg=5 xl=5 class="ml-13">
        <v-card :color="card.color" :class="card.position" :elevation="card.elevation" outlined :height="card.height"
          :width="card.width">
          <v-row class="mt-4">
            <v-col cols=3 sm=3 md=3 lg=3 xl=3 />
            <v-col cols=9 sm=9 md=9 lg=9 xl=9 :class="$vuetify.breakpoint.width < 600 ? 'ml-n5' : 'ml-n3'">
              <div :style="card.headerStyle" v-text="card.headerText" />
            </v-col>
          </v-row>
          <v-row class="mt-n1">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-text-field :type="visible ? 'text' : 'password'" v-model="password"
                :background-color="card.textFieldColor" dense outlined :placeholder="card.emailText" />
            </v-col>
          </v-row>
          <v-row class="mt-n1">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-text-field :type="visible ? 'text' : 'password'" v-model="password_confirmation"
                :background-color="card.textFieldColor" dense outlined :placeholder="card.emailText" />
            </v-col>
          </v-row>
          <v-row class="mt-n7">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-btn @click="resetPassword()" :color="card.btnColor" dark elevation=0 block>
                <div :style="card.textStyle" v-text="card.sendText" />
              </v-btn>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols=3 sm=3 md=3 lg=3 xl=3 />
            <v-col :class="$vuetify.breakpoint.width < 600 ? 'mt-n1 ml-n5' : 'ml-n1 mt-1'" cols=8 sm=8 md=8 lg=8 xl=8>
              <div :style="card.policyStyle" v-text="card.policyText" />
            </v-col>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          </v-row>
        </v-card>
      </v-col>
      <v-col cols=1 sm=2 md=2 lg=3 xl=3 />
    </v-row>

    <v-snackbar top v-model="errorbar" color="black">
      <li v-for="error in errors" :key="error.id">{{error}}</li>
      <template v-slot:action="{attrs}">
        <v-btn color="white" text v-bind="attrs" @click="errorbar = false">
          閉じる
        </v-btn>
      </template>
    </v-snackbar>
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
  import {
    simpleAxios
  } from '../../backend/axios.js'

  export default {
    name: 'ResetPassword',
    data() {
      return {
        password_reset_url: '/api/v1/password_resets',
        password: null,
        password_confirmation: null,
        errors: [],
        error: null,
        snackbar: false,
        errorbar: false,
        counter: 235,
        notify_text: null,
        visible: false,
        topPartStyle: {
          height: '155px'
        },
        topPartMobile: {
          height: '135px'
        },
        card: {
          headerText: 'パスワードの再設定',
          textFieldColor: '#ffffff',
          btnColor: '#016aff',
          emailText: 'Eメール',
          sendText: 'メールを送信する',
          policyText: 'プライバシーポリシーと利用規約について',
          color: "#edf2f4",
          height: '230px',
          width: '380px',
          position: 'rounded-lg',
          elevation: 0,
          headerStyle: {
            color: '#111111',
            fontWeight: 'bold',
            fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
            fontSize: '23px',
          },
          textStyle: {
            fontWeight: 'bold',
            fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
            fontSize: '11px',
          },
          policyStyle: {
            color: '#6c757d',
            fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
            fontSize: '8px',
          }
        }
      }
    },
    created() {
      this.checkPasswordToken()
    },
    methods: {
      checkPasswordValidation() {
        this.errors = [];

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
      resetPassword() {
        this.checkPasswordValidation()
        if (!this.errors.length) {
          simpleAxios.patch(this.password_reset_url + `/` + `${this.$route.params.token}`, {
              password: this.password,
              password_confirmation: this.password_confirmation
            })
            .then(response => this.resetSuccessful(response))
            .catch(error => this.resetFailed(error))
        }
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
  .v-text-field--outlined>>>fieldset {
    border-color: #e9ecef;
  }

  .theme--light.v-divider {
    border-color: rgba(0, 1, 1, .06);
  }
</style>