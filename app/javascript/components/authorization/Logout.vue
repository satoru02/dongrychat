<template>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios';

  export default {
    name: 'Logout',
    data(){
      return {
        logout_url: '/api/v1/login'
      }
    },
    created() {
      this.logout()
    },
    methods: {
      logout() {
        secureAxios.delete(this.logout_url + `/` + `${this.$store.state.currentUser.id}`)
          .then(res => this.logoutSuccessful())
          .catch(error => this.setError(error, 'Cannot log out.'))
      },
      logoutSuccessful() {
        localStorage.removeItem('vuex')
        this.$store.commit('unsetCurrentUser')
        this.$router.replace('/')
      }
    }
  }
</script>