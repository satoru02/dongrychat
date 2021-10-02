<template>
  <v-container>
    <v-row :style="$vuetify.breakpoint.width < 600 ? topPartMobile : topPartStyle">
      <v-col cols=12 sm=12 md=12 lg=12 xl=12 />
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=2 lg=2 xl=3 :class="gridLeft" v-if="$vuetify.breakpoint.width > 600"  />
      <v-col cols=10 sm=8 md=8 lg=5 xl=5 :class="gridCard">
        <v-card :color="loginCard.color" :class="loginCard.position" :elevation="loginCard.elevation"
          :height="loginCard.height" :width="loginCard.width">
          <v-row class="mt-4">
            <v-col cols=2 sm=3 md=3 lg=3 xl=3 />
            <v-col cols=10 sm=9 md=9 lg=9 xl=9 :class="$vuetify.breakpoint.width < 600 ? 'ml-n5 mb-5' : 'ml-n8 mt-4 mb-4'">
              <div :style="loginCard.headerTitleStyle" v-text="loginCard.headerText" />
            </v-col>
          </v-row>
          <v-row class="mt-3">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-btn @click="authenticate(loginCard.googleArg)" :color="loginCard.googleColor"
                :style="loginCard.btnStyle" elevation=0 block>
                <icon-base class="mr-5" :width="'15'" :height="'15'" icon-name="icon-google" :viewBox="'0 0 512 512'">
                  <icon-google />
                </icon-base>
                {{loginCard.googleBtn}}
              </v-btn>
            </v-col>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          </v-row>
          <v-row class="mt-n1">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-btn @click="authenticate(loginCard.facebookArg)" :color="loginCard.facebookColor"
                :style="loginCard.btnStyle" elevation=0 block>
                <icon-base class="ml-4 mr-6" :width="'15'" :height="'15'" icon-name="icon-facebook"
                  :viewBox="'0 0 512 512'">
                  <icon-facebook />
                </icon-base>
                {{loginCard.facebookBtn}}
              </v-btn>
            </v-col>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          </v-row>
          <v-row class="mt-n1">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-divider />
            </v-col>
          </v-row>
          <v-row class="mt-n1">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-text-field v-model="email" :background-color="loginCard.textFieldColor" dense outlined
                :placeholder="loginCard.emailText" :rules="[rules.requiredEmail, rules.testMail]" />
            </v-col>
          </v-row>
          <v-row class="mt-n7">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-text-field :type="visible ? 'text' : 'password'" v-model="password" dense
                :background-color="loginCard.textFieldColor" :placeholder="loginCard.passwordText" outlined
                :rules="[rules.requiredPassword, rules.minPassword]" />
            </v-col>
          </v-row>
          <v-row :class="$vuetify.breakpoint.width < 600 ? 'mt-n9 mr-n16' : 'mt-n9 mr-n8'">
            <v-col cols=6 sm=7 md=7 lg=7 xl=7 />
            <v-col :class="$vuetify.breakpoint.width < 600 ? 'mt-n2 mb-3' : 'mt-n2 mb-3'" cols=6 sm=5 md=5 lg=5 xl=5>
              <div @click="forgetPassword()" :style="loginCard.signupStyle" v-text="loginCard.forgotPasswordText" />
            </v-col>
          </v-row>
          <v-row class="mt-n7">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-btn v-if="inputComplete === false" disabled block elevation=0>
                <div v-text="loginCard.loginText" />
              </v-btn>
              <v-btn :color="loginCard.loginBtnColor" v-if="inputComplete === true" @click="signIn()"
                :style="afterInput" elevation=0 block>
                <div :style="loginCard.loginTextStyle" v-text="loginCard.loginText" />
              </v-btn>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols=6 sm=7 md=7 lg=7 xl=7 />
            <v-col :class="$vuetify.breakpoint.width < 600 ? 'mt-n3' : 'mt-n4 ml-n1'" cols=6 sm=5 md=5 lg=5 xl=4
              @click="makeAccount()">
              <div :style="loginCard.signupStyle" v-text="loginCard.signupText" />
            </v-col>
          </v-row>
          <v-row>
            <v-col cols=3 sm=3 md=3 lg=3 xl=3 />
            <v-col :class="$vuetify.breakpoint.width < 600 ? 'mt-n1 ml-n5' : 'ml-n1 mt-n2'" cols=9 sm=8 md=8 lg=8 xl=8>
              <div :style="loginCard.signupStyle" v-text="loginCard.policyText" />
            </v-col>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          </v-row>
        </v-card>
      </v-col>
      <v-col cols=0 sm=2 md=2 lg=3 xl=3 />
    </v-row>
    <v-snackbar top color="black" v-model="snackbar">
      <li v-for="error in errors" :key="error.id">{{ error }}</li>
      <template v-slot:action="{attrs}">
        <v-btn color="white" text v-bind="attrs" @click="snackbar = false">
          {{ close }}
        </v-btn>
      </template>
    </v-snackbar>
  </v-container>
</template>

<script>
  import {
    simpleAxios
  } from '../../backend/axios';
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const authRepository = RepositoryFactory.get('auth');

  export default {
    name: 'Login',
    components: {
      'icon-base': () => import( /* webpackPrefetch: true */ '../Icon/IconBase'),
      'icon-google': () => import( /* webpackPrefetch: true */ '../Icon/IconGoogle.vue'),
      'icon-facebook': () => import( /* webpackPrefetch: true */ '../Icon/IconFacebook.vue'),
    },
    data() {
      return {
        login_url: '/api/v1/login',
        user_info_url: '/api/v1/users/me',
        email: '',
        password: '',
        errors: [],
        error: '',
        visible: false,
        snackbar: false,
        notify_text: null,
        close: '閉じる',
        reg: /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/,
        rules: {
          requiredEmail: (v) => !!v || `Eメールを入力してください。`,
          requiredPassword: (v) => !!v || 'パスワードを入力してください。',
          minPassword: (v) => v.length >= 6 || '最低6文字以上のパスワードを入力してください。',
          testMail: (v) => this.reg.test(v) || `メールの形式が正しくありません。`
        },
        inputValidation: {
          noMail: 'メールアドレスが入力されていません。',
          invalidMail: 'メールアドレスが有効な形式ではありません。',
          noPassword: 'パスワードが入力されていません。'
        },
        beforeInput: {
          backgroundColor: "#134563"
        },
        afterInput: {
          backgroundColor: "#000000"
        },
        topPartStyle: {
          height: '105px'
        },
        topPartMobile: {
          height: '115px'
        },
        loginCard: {
          headerText: 'DongryChatにようこそ！',
          googleArg: 'google',
          googleBtn: 'Googleでログイン',
          googleColor: '#212121',
          googleIcon: 'mdi-google',
          facebookArg: 'facebook',
          facebookBtn: 'Facebookでログイン',
          facebookColor: '#2962ff',
          facebookIcon: 'mdi-facebook',
          textFieldColor: '#ffffff',
          loginBtnColor: '#06d6a0',
          emailText: 'Eメール',
          passwordText: 'パスワード',
          forgotPasswordText: 'パスワードを忘れた',
          loginText: 'ログイン',
          signupText: 'アカウント登録はこちら',
          policyText: 'プライバシーポリシーと利用規約について',
          color: "#ffffff",
          height: '430px',
          width: '380px',
          position: 'rounded-lg',
          elevation: 0,
          headerTitleStyle: {
            color: '#111111',
            fontWeight: 'bold',
            fontSize: '26px',
          },
          btnStyle: {
            color: '#ffffff',
            fontWeight: 'bold',
            fontSize: '12px',
          },
          forgotTextStyle: {
            fontWeight: 'bold',
            fontSize: '3px',
            color: '#adb5bd',
            cursor: 'pointer'
          },
          loginTextStyle: {
            fontWeight: 'bold',
            fontSize: '14px',
            color: '#ffffff'
          },
          signupStyle: {
            color: '#adb5bd',
            fontWeight: 'bold',
            fontSize: '3px',
            cursor: 'pointer'
          },
          policyStyle: {
            color: '#6c757d',
            fontSize: '8px',
          }
        }
      }
    },
    computed: {
      inputComplete() {
        if ((this.email) && (this.password.length > 6)) {
          return true
        } else {
          return false
        }
      },
      gridLeft(){
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-n3'
          case 'sm':
            return 'mt-2'
          case 'md':
            return 'ml-5'
          case 'lg':
          case 'xl':
            return 'ml-7'
        }
      },
      gridCard(){
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-8'
          case 'sm':
          case 'md':
          case 'lg':
            return 'ml-16'
          case 'xl':
            return 'ml-7'
        }
      }
    },
    methods: {
      validEmail(email) {
        return this.reg.test(email);
      },
      checkInputValidation() {
        this.errors = [];
        if (!this.email) {
          this.errors.push(this.inputValidation.noMail)
        } else if (!this.validEmail(this.email)) {
          this.errors.push(this.inputValidation.invalidMail)
        }
        if (!this.password) {
          this.errors.push(this.inputValidation.noPassword)
        }
        if (this.errors.length) {
          return this.snackbar = true
        }
      },
      signIn() {
        this.checkInputValidation()
        if (!this.errors.length) {
          authRepository.login({
              email: this.email,
              password: this.password
            })
            .then(res => this.signinSuccessful(res))
            .catch(err => this.signinFailed(err))
        }
      },
      signinSuccessful(res) {
        if (!res.data.csrf) {
          this.signInFailed()
          return
        }
        simpleAxios.defaults.headers.common['Authorization'] = `Bearer ${res.data.access_token}`
        simpleAxios.get(this.user_info_url)
          .then(me_response => {
            this.$store.commit('user/setCurrentUser', {
              currentUser: me_response.data.data.attributes,
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
        this.$store.commit('user/unsetCurrentUser')
      },
      makeAccount() {
        this.$router.push({
          name: 'Signup'
        })
      },
      forgetPassword() {
        this.$router.push({
          name: "ForgotPassword"
        })
      },
      authenticate: function (provider) {
        this.$auth.authenticate(provider).then(res => {
          this.$store.commit('user/setCurrentUser', {
            currentUser: res.data.user.data.attributes,
            csrf: res.data.csrf,
            token: res.data.access_token
          })
          this.$router.replace('/')
        })
      }
    }
  }
</script>

<style scoped>
  * {
    text-transform: none !important;
  }

  .v-text-field--outlined>>>fieldset {
    border-color: #e9ecef;
  }
</style>