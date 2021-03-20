<template>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios';
  const LOGOUT_URL = '/api/v1/login';

  export default {
    name: 'Logout',
    created() {
      this.logout()
    },
    methods: {
      logout() {
        secureAxios.delete(LOGOUT_URL + `/` + `${this.$store.state.currentUser.id}`)
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