<template>
  <div style="background-color: #fafafa">
    <v-row>
      <v-col lg=2></v-col>
      <v-col lg=2>
        <v-list dense style="background-color: #fafafa">
          <v-subheader class="setting-title ml-2">設定</v-subheader>
          <v-list-item-group color="primary">
            <v-list-item v-for="(n,i) in lists" :key="i">
              <v-list-item-content>
                <v-list-item-title v-text="n"></v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </v-list-item-group>
        </v-list>
      </v-col>
      <v-col lg=6 class="mt-5">
        <v-sheet height="1000px;" class="rounded-lg">
          <v-row dense>
            <v-col lg=3>
              <h3 class="setting-title mt-5 ml-5">アカウント設定</h3>
            </v-col>
            <v-col lg=7 md=8 xl=8 class="mt-1">
            </v-col>
            <v-col lg=2>
            </v-col>
          </v-row>
          <v-row dense>
            <v-col lg=11 class="ml-5 mt-3">
              <v-divider />
            </v-col>
            <v-col lg=1></v-col>
          </v-row>
          <v-row dense>
            <v-col lg=3>
              <h3 class="setting-title mt-3 ml-5">名前</h3>
            </v-col>
            <v-col lg=8 md=8 xl=8 class="mt-1 ml-5">
              <v-text-field class="rounded-lg" outlined :rules="[rules.minName]" background-color="#ffffff" color="red"
                :placeholder="this.$store.state.currentUser.name" solo filled dense flat v-model="name" />
            </v-col>
          </v-row>
          <v-row dense>
            <v-col lg=3>
              <h3 class="setting-title mt-3 ml-5">アイコン</h3>
            </v-col>
            <v-col lg=8 md=8 xl=8 class="mt-1 ml-5">
              <v-file-input background-color="#ffffff" outlined filled dense flat solo v-model="picture" @change="getPresignedURI()" />
            </v-col>
          </v-row>
          <v-row dense>
            <v-col lg=11 class="ml-5 mt-n3">
              <v-divider />
            </v-col>
            <v-col lg=1></v-col>
          </v-row>
          <v-row dense>
            <v-col lg=3>
              <h3 class="setting-title mt-3 ml-5">プロフィール</h3>
            </v-col>
            <v-col lg=8 md=8 xl=8 class="mt-1 ml-5">
              <v-textarea class="rounded-lg" outlined background-color="#ffffff" solo flat
                :placeholder="this.$store.state.currentUser.about" filled dense v-model="about" />
            </v-col>
          </v-row>
          <v-row dense>
            <v-col lg=11 class="ml-5 mt-n3">
              <v-divider />
            </v-col>
            <v-col lg=1></v-col>
          </v-row>
          <v-row dense>
            <v-col lg=3>
              <h3 class="setting-title mt-3 ml-5">メール</h3>
            </v-col>
            <v-col lg=8 md=8 xl=8 class="mt-1 ml-5">
              <v-text-field class="rounded-lg" outlined background-color="#ffffff" solo flat :rules="[rules.testMail]"
                :placeholder="this.$store.state.currentUser.email" filled dense v-model="email" />
            </v-col>
          </v-row>
          <v-row dense>
            <v-col lg=11 class="ml-5 mt-n3">
              <v-divider />
            </v-col>
            <v-col lg=1></v-col>
          </v-row>
          <v-row dense>
            <v-col lg=3>
              <h3 class="setting-title mt-3 ml-5">住所</h3>
            </v-col>
            <v-col lg=8 md=8 xl=8 class="mt-1 ml-5">
              <v-text-field class="rounded-lg" background-color="#ffffff" outlined solo flat
                :placeholder="this.$store.state.currentUser.location" filled dense v-model="location" />
            </v-col>
          </v-row>
          <v-row dense>
            <v-col lg=11 class="ml-5 mt-n3">
              <v-divider />
            </v-col>
            <v-col lg=1></v-col>
          </v-row>
          <v-row dense>
            <v-col lg=3>
              <h3 class="setting-title mt-3 ml-5">Youtube</h3>
            </v-col>
            <v-col lg=8 md=8 xl=8 class="mt-1 ml-5">
              <v-text-field class="rounded-lg" background-color="#ffffff" outlined solo flat :rules="[rules.testURL]"
                :placeholder="sns_links[0] == '' ? 'https://youtube.com/username' : sns_links[0]" filled dense
                v-model="sns_links[0]" />
            </v-col>
          </v-row>
          <v-row dense>
            <v-col lg=11 class="ml-5 mt-n3">
              <v-divider />
            </v-col>
            <v-col lg=1></v-col>
          </v-row>
          <v-row dense>
            <v-col lg=3>
              <h3 class="setting-title mt-3 ml-5">Instagram</h3>
            </v-col>
            <v-col lg=8 md=8 xl=8 class="mt-1 ml-5">
              <v-text-field class="rounded-lg" background-color="#ffffff" outlined solo flat :rules="[rules.testURL]"
                :placeholder="sns_links[1] == '' ? 'https://instagram.com/username' : sns_links[1]" filled dense
                v-model="sns_links[1]" />
            </v-col>
          </v-row>
          <v-row dense>
            <v-col lg=11 class="ml-5 mt-n3">
              <v-divider />
            </v-col>
            <v-col lg=1></v-col>
          </v-row>
          <v-row dense>
            <v-col lg=3>
              <h3 class="setting-title mt-3 ml-5">Twitter</h3>
            </v-col>
            <v-col lg=8 md=8 xl=8 class="mt-1 ml-5">
              <v-text-field class="rounded-lg" background-color="#ffffff" outlined solo flat :rules="[rules.testURL]"
                :placeholder="sns_links[2] == '' ? 'https://twitter.com/username' : sns_links[2]" filled dense
                v-model="sns_links[2]" />
            </v-col>
          </v-row>
          <v-row dense>
            <v-col lg=11 class="ml-5 mt-n3">
              <v-divider />
            </v-col>
            <v-col lg=1></v-col>
          </v-row>
          <v-row dense>
            <v-col lg=3>
              <h3 class="setting-title mt-3 ml-5">Facebook</h3>
            </v-col>
            <v-col lg=8 md=8 xl=8 class="mt-1 ml-5">
              <v-text-field class="rounded-lg" background-color="#ffffff" outlined solo flat :rules="[rules.testURL]"
                :placeholder="sns_links[3] == '' ? 'https://facebook.com/username' : sns_links[3]" filled dense
                v-model="sns_links[3]" />
            </v-col>
          </v-row>
          <v-row dense class="mt-n5">
            <v-col lg=9 class="ml-5 mt-n3">
            </v-col>
            <v-col lg=1 class="ml-8 mt-4">
              <v-btn elevation=0 class="btn-title" small block color="primary" @click="updateProfile()">変更する</v-btn>
            </v-col>
          </v-row>
          <v-row dense>
            <v-col lg=11 class="ml-5 mt-n3">
              <!-- <v-divider /> -->
            </v-col>
            <v-col lg=1></v-col>
          </v-row>
          <v-row dense>
            <v-col lg=11 class="ml-5 mt-n3">
              <!-- <v-divider /> -->
            </v-col>
            <v-col lg=1></v-col>
          </v-row>
        </v-sheet>
      </v-col>
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
  </div>
</template>

<script>
  import { simpleAxios } from '../../backend/axios';
  import TheSubHeader from '../Layout/TheSubHeader';
  import { RepositoryFactory } from '../../repositories/RepositoryFactory';
  const usersRepository = RepositoryFactory.get('users');
  const avatarRepository = RepositoryFactory.get('avatar');

  export default {
    name: 'Settings',
    components: {
      'sub-header': TheSubHeader
    },
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
        lists: ['プロフィール','退会']
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
      },
      getPresignedURI() {
        avatarRepository.get({
          filename: this.picture.name,
          filetype: this.picture.type
        })
        .then(response => {
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
            .then((response) => {})
        })
      },
      updateProfile() {
        this.checkFormValidation()
        if (!this.errors.length) {
          usersRepository.update(this.$store.state.currentUser.id, {
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
    font-size: 15px;
    color: #111111;
  }

  .v-divider {
    border-color: rgba(84, 90, 90, 0.137);
  }

  .setting-title {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 14px;
    color: #374151;
  }

  .btn-title {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 11px;
    color: #ffffff;
  }

  .theme--light.v-sheet--outlined {
    border: thin solid rgba(240, 238, 238, 0.959);
  }

  .theme--light.v-text-field--outlined:not(.v-input--is-focused):not(.v-input--has-state)>.v-input__control>.v-input__slot fieldset {
    color: rgba(0, 0, 0, .08);
  }
</style>