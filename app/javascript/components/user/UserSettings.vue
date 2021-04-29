<template>
  <v-container>
    <h2 class="mb-3 mr-n3 head-title">アカウント設定</h2>
    <v-row class="mt-n2 ml-n11">
      <v-col lg=1 md=1 xl=1 />
      <v-col lg=1 md=2 xl=2>
        <h3 class="setting-title mt-2 ml-1">名前</h3>
      </v-col>
      <v-col lg=7 md=8 xl=8>
        <v-text-field dark :rules="[rules.minName]" background-color="#242c37" color="red"
         :placeholder="this.$store.state.currentUser.name" solo filled dense flat
          v-model="name" />
      </v-col>
    </v-row>
    <v-row class="mt-n8 ml-n11">
      <v-col lg=1 md=1 xl=1 />
      <v-col lg=1 md=2 xl=2>
        <h3 class="setting-title ml-1">自己紹介</h3>
      </v-col>
      <v-col lg=7 md=8 xl=8>
        <v-textarea dark background-color="#242c37" solo flat :placeholder="this.$store.state.currentUser.about" filled dense v-model="about" />
      </v-col>
    </v-row>
    <v-row class="mt-n8 ml-n11">
      <v-col lg=2></v-col>
      <v-col lg=7 md=12 xl=8>
        <v-file-input dark background-color="#242c37" filled dense flat solo v-model="picture" @change="getPresignedURI()" />
      </v-col>
    </v-row>

    <v-row class="mt-n8 ml-n11">
      <v-col lg=1 md=1 xl=1 />
      <v-col lg=1 md=2 xl=2>
        <h3 class="setting-title mt-3 ml-1">Eメール</h3>
      </v-col>
      <v-col lg=7 md=8 xl=8>
        <v-text-field dark background-color="#242c37" solo flat :rules="[rules.testMail]" :placeholder="this.$store.state.currentUser.email" filled dense
          v-model="email" />
      </v-col>
    </v-row>
    <v-row class="mt-n8 ml-n11">
      <v-col lg=1 md=1 xl=1 />
      <v-col lg=1 md=2 xl=2>
        <h3 class="setting-title mt-3 ml-1">住所</h3>
      </v-col>
      <v-col lg=7 md=8 xl=8>
        <v-text-field dark background-color="#242c37" solo flat :placeholder="this.$store.state.currentUser.location" filled dense v-model="location" />
      </v-col>
    </v-row>
    <v-row class="mt-n8 ml-n11">
      <v-col lg=1 md=1 xl=1 />
      <v-col lg=1 md=2 xl=2>
        <h3 class="setting-title mt-3 ml-1">Youtube</h3>
      </v-col>
      <v-col lg=7 md=8 xl=8>
        <v-text-field dark background-color="#242c37" solo flat :rules="[rules.testURL]"
          :placeholder="sns_links[0] == '' ? 'https://youtube.com/username' : sns_links[0]" filled dense
          v-model="sns_links[0]" />
      </v-col>
    </v-row>
    <v-row class="mt-n8 ml-n11">
      <v-col lg=1 md=1 xl=1 />
      <v-col lg=1 md=2 xl=2>
        <h3 class="setting-title mt-3 ml-1">Instagram</h3>
      </v-col>
      <v-col lg=7 md=8 xl=8>
        <v-text-field dark background-color="#242c37" solo flat :rules="[rules.testURL]"
          :placeholder="sns_links[1] == '' ? 'https://instagram.com/username' : sns_links[1]" filled dense
          v-model="sns_links[1]" />
      </v-col>
    </v-row>
    <v-row class="mt-n8 ml-n11">
      <v-col lg=1 md=1 xl=1 />
      <v-col lg=1 md=2 xl=2>
        <h3 class="setting-title mt-3 ml-1">Twitter</h3>
      </v-col>
      <v-col lg=7 md=8 xl=8>
        <v-text-field dark background-color="#242c37" solo flat :rules="[rules.testURL]"
          :placeholder="sns_links[2] == '' ? 'https://twitter.com/username' : sns_links[2]" filled dense
          v-model="sns_links[2]" />
      </v-col>
    </v-row>
    <v-row class="mt-n8 ml-n11">
      <v-col lg=1 md=1 xl=1 />
      <v-col lg=1 md=2 xl=2>
        <h3 class="setting-title mt-3 ml-1">Facebook</h3>
      </v-col>
      <v-col lg=7 md=8 xl=8>
        <v-text-field dark background-color="#242c37" solo flat :rules="[rules.testURL]"
          :placeholder="sns_links[3] == '' ? 'https://facebook.com/username' : sns_links[3]" filled dense
          v-model="sns_links[3]" />
      </v-col>
    </v-row>
    <v-row class="mt-n6 ml-n10">
      <v-col lg=1 />
      <v-col lg=8>
        <v-btn block color="primary" @click="updateProfile()">更新</v-btn>
      </v-col>
      <!-- <v-col lg=1 /> -->
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
    secureAxios,
    simpleAxios
  } from '../../backend/axios';
  const UPDATE_ENDPOINT = '/api/v1/users'
  const GET_PRESIGNED_URL = '/api/v1/avatar'

  export default {
    name: 'Settings',
    data() {
      return {
        name: this.$store.state.currentUser.name,
        email: this.$store.state.currentUser.email,
        about: this.$store.state.currentUser.about,
        location: this.$store.state.currentUser.location,
        sns_links: this.$store.state.currentUser.sns_links,
        picture: null,
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
      getPresignedURI() {
        secureAxios.get(GET_PRESIGNED_URL + `/` + `presigned_url`, {
          params: {
            filename: this.picture.name,
            filetype: this.picture.type
          }
        }).then(response => {
          var formdata = new FormData()
          formdata.append("Content-Type", response.data.fields['Content-Type'])
          formdata.append("key", response.data.fields['key'])
          formdata.append("acl", response.data.fields['acl'])
          formdata.append("policy", response.data.fields['policy'])
          formdata.append("x-amz-algorithm", response.data.fields['x-amz-algorithm'])
          formdata.append("x-amz-credential", response.data.fields['x-amz-credential'])
          formdata.append("x-amz-date", response.data.fields['x-amz-date'])
          formdata.append("x-amz-meta-original-filename", response.data.fields['x-amz-meta-original-filename'])
          formdata.append("x-amz-signature", response.data.fields['x-amz-signature'])
          formdata.append("file", this.picture, "file.txt")

          simpleAxios.post(response.data.url, formdata, {
              headers: {
                'Content-Type': 'multipart/form-data'
              }
            })
            .then((response) => {
              // console.log(response)
            })
        })
      },
      updateProfile() {
        this.checkFormValidation()
        if (!this.errors.length) {
          secureAxios.patch(UPDATE_ENDPOINT + `/` + `${this.$store.state.currentUser.id}`, {
              name: this.name,
              about: this.about,
              email: this.email,
              location: this.location,
              sns_links: this.sns_links,
              file_name: this.setPicture()
            })
            .then(res => this.updateSuccessful(res))
            .catch(err => this.updateFailed(err))
        } else {
          this.error_bar = true
        }
      },
      setPicture() {
        if (this.picture) {
          return this.picture.name
        } else {
          return null
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
        this.errors.push('入力内容に間違いがあります。')
        this.error_bar = true
      }
    }
  }
</script>

<style scoped>
  .head-title {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 18px;
    color: #ced4da;
  }

  .setting-title {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 13px;
    color: #ced4da;
  }

</style>