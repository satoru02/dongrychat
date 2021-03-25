<template>
  <v-container>
    <h3 class="mb-5 ml-n1 head-title">Settings</h3>
    <v-text-field :placeholder="this.$store.state.currentUser.name" filled outlined dense v-model="name" />
    <v-textarea :placeholder="this.$store.state.currentUser.about" filled outlined dense v-model="about" />
    <v-text-field :placeholder="this.$store.state.currentUser.email" filled outlined dense v-model="email" />
    <v-text-field :placeholder="this.$store.state.currentUser.location" filled outlined dense v-model="location" />
    <v-text-field :placeholder="'新しいパスワード'"  filled outlined dense v-model="password" />
    <v-text-field :placeholder="'新しいパスワードの再入力'" filled outlined dense v-model="password_confirmation" />
    <v-btn outlined color="primary" @click="updateProfile()">更新</v-btn>
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
  import { secureAxios } from '../../backend/axios';
  const UPDATE_ENDPOINT = '/api/v1/users'

  export default {
    name: 'Settings',
    data(){
      return {
        name: null,
        email: null,
        password: null,
        password_confirmation: null,
        sns_link: null,
        location: null,
        about: null,
        error: null,
        snack_bar: false,
        error_bar: false,
        errors: [],
        notify_text: null
      }
    },
    created(){
      this.checkSignedIn()
    },
    methods: {
      updateProfile(){
        secureAxios.patch(UPDATE_ENDPOINT + `/` + `${this.$store.state.currentUser.id}`, {
          name: this.name,
          about: this.about,
          email: this.email,
          location: this.location,
          password: this.password,
          password_confirmation: this.password_confirmation
        })
        .then(res => this.updateSuccessful(res))
        .catch(err => this.updateFailed(err))
      },
      updateSuccessful(res){
        if(res.length){
          this.$router.replace('/settings')
        }
      },
      updateFailed(err){
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
    font-size: 32px;
    color: #000000;
  }
</style>