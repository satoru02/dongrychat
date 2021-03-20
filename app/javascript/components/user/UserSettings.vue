<template>
  <v-container>
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
        username: null,
        email: null,
        password: null,
        password_confirmation: null,
        sns_link: null,
        location: null,
        about: null,
        error: null,
        snack_bar: null
      }
    },
    created(){
      this.checkSignedIn()
    },
    methods: {
      updateProfile(){
      },
      updateSuccessful(){
      },
      updateFailed(){
      },
      checkSignedIn() {
        if (!this.$store.state.signedIn) {
          this.$router.replace('/')
        }
      },
    }
  }
</script>