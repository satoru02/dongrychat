<template>
  <v-container>
    <v-progress-linear v-if="sendingMail == true" color="deep-purple accent-4" indeterminate rounded height="6" />
    <v-row :style="$vuetify.breakpoint.width < 600 ? topPartMobile : topPartStyle">
      <v-col cols=12 sm=12 md=12 lg=12 xl=12 />
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=2 lg=2 xl=3 :class="gridLeft" />
      <v-col cols=10 sm=8 md=8 lg=5 xl=5 :class="gridCard">
        <v-card :color="signupCard.color" :class="signupCard.position" :elevation="signupCard.elevation"
          :height="signupCard.height" :width="signupCard.width">
          <v-row class="mt-1">
            <v-col cols=2 sm=3 md=3 lg=3 xl=3 />
            <v-col cols=10 sm=9 md=9 lg=9 xl=9 :class="$vuetify.breakpoint.width < 600 ? 'ml-n5 mb-5' : 'ml-n8 mt-3 mb-4'">
              <!-- <div :style="signupCard.headerTitleStyle" v-text="signupCard.headerText" /> -->
                <icon-base icon-name="icon-logo"
                  :width="'28'" :height="'28'" :viewBox="'0 0 512 512'">
                  <icon-logo />
                </icon-base>
                <span class="ml-2" :style="signupCard.headerTitleStyle">{{signupCard.headerText}}</span>
            </v-col>
          </v-row>
          <v-row class="mt-1">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-btn @click="authenticate(signupCard.googleArg)" :color="signupCard.googleColor"
                :style="signupCard.btnStyle" elevation=0 block>
                <icon-base class="mr-5" :width="'15'" :height="'15'" icon-name="icon-google" :viewBox="'0 0 512 512'">
                  <icon-google />
                </icon-base>
                {{signupCard.googleBtn}}
              </v-btn>
            </v-col>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          </v-row>
          <v-row class="mt-n1">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-btn @click="authenticate(signupCard.facebookArg)" :color="signupCard.facebookColor"
                :style="signupCard.btnStyle" elevation=0 block>
                <icon-base class="ml-4 mr-6" :width="'15'" :height="'15'" icon-name="icon-facebook"
                  :viewBox="'0 0 512 512'">
                  <icon-facebook />
                </icon-base>
                {{signupCard.facebookBtn}}
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
              <v-text-field v-model="email" :background-color="signupCard.textFieldColor" dense outlined
                :placeholder="signupCard.emailText" :rules="[rules.requiredEmail, rules.testMail]" />
            </v-col>
          </v-row>
          <v-row class="mt-n7">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-text-field v-model="name" dense :background-color="signupCard.textFieldColor"
                :placeholder="signupCard.nameText" outlined :rules="[rules.requiredName, rules.minName]" />
            </v-col>
          </v-row>
          <v-row class="mt-n7">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-text-field :type="visible ? 'text' : 'password'" v-model="password" dense
                :background-color="signupCard.textFieldColor" :placeholder="signupCard.passwordText" outlined
                :rules="[rules.requiredPassword, rules.minPassword]" />
            </v-col>
          </v-row>
          <v-row class="mt-n7">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-text-field v-model="password_confirmation" :value="password_confirmation" @click="visible = false"
                :type="visible ? 'text' : 'password'" dense :background-color="signupCard.textFieldColor"
                :placeholder="signupCard.secondPasswordText" outlined :rules="[rules.matchPassword]" />
            </v-col>
          </v-row>
          <v-row class="mt-n7">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-btn v-if="inputComplete === false" disabled block elevation=0>
                <div :style="signupCard.signupTextStyle" v-text="signupCard.signupText" />
              </v-btn>
              <v-btn v-if="inputComplete === true" @click="signup()" :style="afterInput" dark elevation=0 block>
                <div :style="signupCard.signupTextStyle" v-text="signupCard.signupText" />
              </v-btn>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols=7 sm=8 md=8 lg=8 xl=8 />
            <v-col :class="$vuetify.breakpoint.width < 600 ? 'ml-2 mt-n3' : 'mt-n3 ml-n1'" cols=4 sm=4 md=4 lg=4 xl=4
              @click="haveAccount()">
              <div :style="signupCard.loginStyle" v-text="signupCard.loginText" />
            </v-col>
          </v-row>
          <v-row>
            <v-col cols=3 sm=3 md=3 lg=3 xl=3 />
            <v-col :class="$vuetify.breakpoint.width < 600 ? 'mt-n1 ml-n5' : 'ml-n1 mt-n3'" cols=9 sm=8 md=8 lg=8 xl=8>
              <div :style="signupCard.loginStyle" v-text="signupCard.policyText" />
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
          {{ close }}
        </v-btn>
      </template>
    </v-snackbar>

    <v-snackbar top v-model="snackbar" color="black">
      {{ notify_text }}
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
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const authRepository = RepositoryFactory.get('auth');

  export default {
    name: 'Signup',
    components: {
      'icon-base': () => import( /* webpackPrefetch: true */ '../Icon/IconBase'),
      'icon-logo': () => import( /* webpackPrefetch: true */ '../Icon/IconLogo.vue'),
      'icon-google': () => import( /* webpackPrefetch: true */ '../Icon/IconGoogle.vue'),
      'icon-facebook': () => import( /* webpackPrefetch: true */ '../Icon/IconFacebook.vue'),
    },
    data() {
      return {
        email: '',
        name: '',
        password: '',
        password_confirmation: '',
        errorbar: false,
        snackbar: false,
        errors: [],
        error: '',
        visible: true,
        sendingMail: false,
        close: '閉じる',
        reg: /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/,
        rules: {
          requiredEmail: (v) => !!v || `メールアドレスを入力してください。`,
          requiredName: (v) => !!v || '名前を入力してください。',
          requiredPassword: (v) => !!v || 'パスワードを入力してください。',
          minPassword: (v) => v.length >= 6 || '最低6文字以上のパスワードを入力してください。',
          minName: (v) => v.length >= 4 || '最低4文字以上の名前を入力してください。',
          matchPassword: (v) => v === this.password || `パスワードが一致しません。`,
          testMail: (v) => this.reg.test(v) || `メールの形式が正しくありません。`
        },
        inputValidation: {
          noMail: 'メールアドレスが入力されていません。',
          invalidMail: 'メールアドレスが有効な形式ではありません。',
          noName: '名前が入力されていません。',
          noPassword: 'パスワードが入力されていません。',
          noConfirmation: 'パスワード確認の項目が入力されていません。'
        },
        notify_text: 'アカウント登録のメールを送信しました！メールボックスを確認ください。',
        notify_account: '入力されたアドレスで登録されたユーザーがすでに存在します。',
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
          height: '85px'
        },
        signupCard: {
          headerText: 'DongryChat',
          googleArg: 'google',
          googleBtn: 'Googleで登録',
          googleColor: '#212121',
          googleIcon: 'mdi-google',
          facebookArg: 'facebook',
          facebookBtn: 'Facebookで登録',
          facebookColor: '#2962ff',
          facebookIcon: 'mdi-facebook',
          textFieldColor: '#ffffff',
          loginBtnColor: 'green',
          emailText: 'Eメール',
          nameText: 'ユーザーネーム',
          passwordText: 'パスワード',
          secondPasswordText: 'パスワードの確認',
          signupText: 'アカウント登録',
          loginText: 'ログインはこちら',
          policyText: 'プライバシーポリシーと利用規約について',
          color: "#ffffff",
          height: '530px',
          width: '380px',
          position: 'rounded-lg',
          elevation: 0,
          headerTitleStyle: {
            color: '#111111',
            fontWeight: 'bold',
            fontSize: '30px',
          },
          btnStyle: {
            color: '#ffffff',
            fontWeight: 'bold',
            fontSize: '12px',
          },
          forgotTextStyle: {
            fontWeight: 'bold',
            fontSize: '3px',
            color: '#adb5bd'
          },
          signupTextStyle: {
            fontWeight: 'bold',
            fontSize: '14px',
          },
          loginStyle: {
            color: '#adb5bd',
            fontWeight: 'bold',
            fontSize: '10px',
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
        if ((this.email) && (this.name.length >= 4) && (this.password.length > 6) && (this.password === this
            .password_confirmation)) {
          return true
        } else {
          return false
        }
      },
      gridLeft(){
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-n6'
          case 'sm':
            return 'ml-3'
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
            return 'ml-7'
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
        return this.reg.test(email)
      },
      checkFormValidation() {
        this.errors = [];
        if (!this.email) {
          this.errors.push(this.inputValidation.noPassword)
        } else if (!this.validEmail(this.email)) {
          this.errors.push(this.inputValidation.invalidMail)
        };
        if (!this.name) {
          this.errors.push(this.inputValidation.noName)
        };
        if (!this.password) {
          this.errors.push(this.inputValidation.noPassword)
        };
        if (!this.password_confirmation) {
          this.errors.push(this.inputValidation.noConfirmation)
        };
        if (this.errors.length) {
          return this.errorbar = true
        };
      },
      signup() {
        this.checkFormValidation()
        if (!this.errors.length) {
          authRepository.signup({
              name: this.name,
              email: this.email,
              password: this.password,
              password_confirmation: this.password_confirmation
            })
            .then(this.sendingMail = true)
            .then(res => this.signupSuccessful(res))
            .catch(err => this.signupFailed(err))
        }
      },
      signupSuccessful(res) {
        this.sendingMail = false,
          this.snackbar = true
      },
      signupFailed(err) {
        this.sendingMail = false,
          this.errors.push(this.notify_account)
        this.errorbar = true
        this.error = (err.response && err.response.data && err.response.data.error) || ''
      },
      haveAccount() {
        this.$router.push({
          name: 'Login'
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