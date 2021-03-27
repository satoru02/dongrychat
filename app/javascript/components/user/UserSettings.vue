<template>
  <v-container>
    <h3 class="mb-5 ml-4 head-title">Settings</h3>
    <v-row>
      <v-col lg=1 md=1 xl=1 />
      <v-col lg=2 md=2 xl=2>
        <h3 class="setting-title mt-2">名前</h3>
      </v-col>
      <v-col lg=8 md=8 xl=8>
        <v-text-field :rules="[rules.minName]" :placeholder="this.$store.state.currentUser.name" filled outlined dense
          v-model="name" />
      </v-col>
    </v-row>
    <v-row class="mt-n8">
      <v-col lg=1 md=1 xl=1 />
      <v-col lg=2 md=2 xl=2>
        <h3 class="setting-title">自己紹介</h3>
      </v-col>
      <v-col lg=8 md=8 xl=8>
        <v-textarea :placeholder="this.$store.state.currentUser.about" filled outlined dense v-model="about" />
      </v-col>
    </v-row>
    <v-row class="mt-n8">
      <v-col lg=1 md=1 xl=1 />
      <v-col lg=2 md=2 xl=2>
        <h3 class="setting-title mt-3">メールアドレス</h3>
      </v-col>
      <v-col lg=8 md=8 xl=8>
        <v-text-field :rules="[rules.testMail]" :placeholder="this.$store.state.currentUser.email" filled outlined dense
          v-model="email" />
      </v-col>
    </v-row>
    <v-row class="mt-n8">
      <v-col lg=1 md=1 xl=1 />
      <v-col lg=2 md=2 xl=2>
        <h3 class="setting-title mt-3">住所</h3>
      </v-col>
      <v-col lg=8 md=8 xl=8>
        <v-text-field :placeholder="this.$store.state.currentUser.location" filled outlined dense v-model="location" />
      </v-col>
    </v-row>
    <v-row class="mt-n8">
      <v-col lg=1 md=1 xl=1 />
      <v-col lg=2 md=2 xl=2>
        <h3 class="setting-title mt-3">Youtube</h3>
      </v-col>
      <v-col lg=8 md=8 xl=8>
        <v-text-field :rules="[rules.testURL]"
          :placeholder="sns_links[0] == '' ? 'https://youtube.com/username' : sns_links[0]" filled outlined dense
          v-model="sns_links[0]" />
      </v-col>
    </v-row>
    <v-row class="mt-n8">
      <v-col lg=1 md=1 xl=1 />
      <v-col lg=2 md=2 xl=2>
        <h3 class="setting-title mt-3">Instagram</h3>
      </v-col>
      <v-col lg=8 md=8 xl=8>
        <v-text-field :rules="[rules.testURL]"
          :placeholder="sns_links[1] == '' ? 'https://instagram.com/username' : sns_links[1]" filled outlined dense
          v-model="sns_links[1]" />
      </v-col>
    </v-row>
    <v-row class="mt-n8">
      <v-col lg=1 md=1 xl=1 />
      <v-col lg=2 md=2 xl=2>
        <h3 class="setting-title mt-3">Twitter</h3>
      </v-col>
      <v-col lg=8 md=8 xl=8>
        <v-text-field :rules="[rules.testURL]"
          :placeholder="sns_links[2] == '' ? 'https://twitter.com/username' : sns_links[2]" filled outlined dense
          v-model="sns_links[2]" />
      </v-col>
    </v-row>
    <v-row class="mt-n8">
      <v-col lg=1 md=1 xl=1 />
      <v-col lg=2 md=2 xl=2>
        <h3 class="setting-title mt-3">Facebook</h3>
      </v-col>
      <v-col lg=8 md=8 xl=8>
        <v-text-field :rules="[rules.testURL]"
          :placeholder="sns_links[3] == '' ? 'https://facebook.com/username' : sns_links[3]" filled outlined dense
          v-model="sns_links[3]" />
      </v-col>
    </v-row>
    <v-row class="mt-n4">
      <v-col lg=1 />
      <v-col lg=10 class="mt-n2">
        <v-btn block outlined color="primary" @click="updateProfile()">更新</v-btn>
      </v-col>
      <v-col lg=1 />
    </v-row>
    <v-snackbar top color="black" v-model="error_bar">
      <li v-for="error in errors" :key="error.id">{{ error }}</li>
      <template v-slot:action="{attrs}">
        <v-btn color="white" text v-bind="attrs" @click="error_bar = false">
          閉じる
        </v-btn>
      </template>
    </v-snackbar>
    <v-snackbar top v-model="snack_bar" color="black">
      {{ notify_text }}
      <template v-slot:action="{attrs}">
        <v-btn color="white" text v-bind="attrs" @click="snack_bar = false">
          閉じる
        </v-btn>
      </template>
    </v-snackbar>
  </v-container>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios';
  const UPDATE_ENDPOINT = '/api/v1/users'

  export default {
    name: 'Settings',
    data() {
      return {
        name: this.$store.state.currentUser.name,
        email: this.$store.state.currentUser.email,
        about: this.$store.state.currentUser.about,
        location: this.$store.state.currentUser.location,
        sns_links: this.$store.state.currentUser.sns_links,
        error: '',
        errors: [],
        snack_bar: false,
        error_bar: false,
        notify_text: '設定が更新されました！',
        mail_reg: /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/,
        url_reg: /(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})/gi,
        rules: {
          minName: (v) => v.length >= 4 || `最低4文字以上の名前を入力してください。`,
          testMail: (v) => this.mail_reg.test(v) || `メールの形式が正しくありません。`,
          testURL: (v) => this.url_reg.test(v) || `URLの形式が正しくありません。`
        },
      }
    },
    created() {
      this.checkSignedIn()
    },
    methods: {
      validURL(url) {
        return this.url_reg.test(url)
      },
      validEmail(email) {
        return this.mail_reg.test(email)
      },
      checkFormValidation() {

        this.errors = [];

        if (!this.email) {
          this.errors.push('メールアドレスが入力されていません。')
        };
        if (!this.validEmail(this.email)) {
          this.errors.push('メールアドレスが有効な形式ではありません。')
        };
        if (!this.name) {
          this.errors.push('名前が入力されていません。')
        };
        if (this.name.length <= 4) {
          this.errors.push('4文字以上の名前を入力してください。')
        };
        // if (this.sns_links[0] != "") {
        //   if (!this.validURL(this.sns_links[0])) {
        //     this.errors.push('YoutubeのURLが有効な形式ではありません。')
        //   } else if (this.sns_links[0] === "") {};
        // };
        // if (this.sns_links[1] != "") {
        //   if (!this.validURL(this.sns_links[1])) {
        //     this.errors.push('InstagramのURLが有効な形式ではありません。')
        //   } else if (this.sns_links[1] === "") {};
        // };
        // if (this.sns_links[2] != "") {
        //   if (!this.validURL(this.sns_links[2])) {
        //     this.errors.push('TwitterのURLが有効な形式ではありません。')
        //   } else if (this.sns_links[2] === "") {};
        // }
        // if (this.sns_links[3] != "") {
        //   if (!this.validURL(this.sns_links[3])) {
        //     this.errors.push('FacebookのURLが有効な形式ではありません。')
        //   } else if (this.sns_links[3] === "") {};
        // }
      },
      updateProfile() {
        this.checkFormValidation()
        if (!this.errors.length) {
          secureAxios.patch(UPDATE_ENDPOINT + `/` + `${this.$store.state.currentUser.id}`, {
              name: this.name,
              about: this.about,
              email: this.email,
              location: this.location,
              sns_links: this.sns_links
            })
            .then(res => this.updateSuccessful(res))
            .catch(err => this.updateFailed(err))
        } else {
          this.error_bar = true
        }
      },
      updateSuccessful(res) {
        this.$store.commit('setCurrentUser', {
          currentUser: res.data.data.attributes,
          csrf: this.$store.state.csrf,
          token: this.$store.state.token
        })
        this.snack_bar = true
      },
      updateFailed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ''
        this.error_bar = true
      },
      checkSignedIn() {
        if (!this.$store.state.signedIn) {
          this.$router.replace('/')
        }
      },
    }
  }
</script>

<style scoped>
  .head-title {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 26px;
    color: #000000;
  }

  .setting-title {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 13px;
    color: #3f3f3f;
  }
</style>