<template>
  <v-container>
     <v-row :style="$vuetify.breakpoint.width < 600 ? topPartMobile : topPartStyle">
      <v-col cols=12 sm=12 md=12 lg=12 xl=12 />
    </v-row>
     <v-row>
      <v-col cols=2 sm=1 md=2 lg=2 xl=3 :class="gridLeft" v-if="$vuetify.breakpoint.width > 600" />
      <v-col cols=11 sm=8 md=8 lg=5 xl=5 :class="gridCard">
        <v-card :color="card.color" :class="card.position" :elevation="card.elevation" outlined
          :height="card.height" :width="card.width">
          <v-row class="mt-4">
            <v-col cols=3 sm=3 md=3 lg=3 xl=3 />
            <v-col cols=9 sm=9 md=9 lg=9 xl=9 :class="$vuetify.breakpoint.width < 600 ? 'ml-n5' : 'ml-n3'">
              <div :style="card.headerStyle" v-text="card.headerText" />
            </v-col>
          </v-row>
          <v-row class="mt-n1">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-text-field v-model="email" :background-color="card.textFieldColor" dense outlined
                :placeholder="card.emailText" />
            </v-col>
          </v-row>
          <v-row class="mt-n7">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
            <v-col cols=10 sm=10 md=10 lg=10 xl=10>
              <v-btn @click="resetPassword()" :color="card.btnColor"
                 dark elevation=0 block>
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
  import { RepositoryFactory } from '../../repositories/RepositoryFactory';
  const authRepository = RepositoryFactory.get('auth');

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
        counter: 235,
        topPartStyle: {
          height: '155px'
        },
        topPartMobile: {
          height: '135px'
        },
        card: {
          headerText: 'パスワードの再設定',
          textFieldColor: '#ffffff',
          btnColor: '#000000',
          emailText: 'Eメール',
          sendText: 'メールを送信する',
          policyText: 'プライバシーポリシーと利用規約について',
          color: "#ffffff",
          height: '230px',
          width: '380px',
          position: 'rounded-lg',
          elevation: 0,
          headerStyle: {
            color: '#111111',
            fontWeight: 'bold',
            fontSize: '23px',
          },
          textStyle: {
            fontWeight: 'bold',
            fontSize: '11px',
          },
          policyStyle: {
            color: '#6c757d',
            fontSize: '8px',
          }
        }
      }
    },
    computed:{
      gridLeft(){
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
          case 'sm':
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
            return 'ml-4'
          case 'sm':
          case 'md':
          case 'lg':
          case 'xl':
            return 'ml-16'
        }
      }
    },
    methods: {
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
        　authRepository.forgot({email: this.email})
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
  .v-text-field--outlined>>>fieldset {
    border-color: #e9ecef;
  }

  .theme--light.v-divider {
    border-color: rgba(0, 1, 1, .06);
  }
</style>