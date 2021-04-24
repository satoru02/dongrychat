<template>
</template>

<script>
  import {
    simpleAxios
  } from '../../backend/axios';
  const ACTIVATION_URL = '/api/v1/account_activations';
  const USER_INFO_URL = '/api/v1/users/me';

  export default {
    name: 'AccountActivation',
    created() {
      simpleAxios.post(ACTIVATION_URL, {
          token: this.$route.params.token
        })
        .then(response => this.activationSuccessful(response))
        .catch(err => this.activationFailed(err))
    },
    methods: {
      activationSuccessful(response) {
        if (!response.data.csrf) {
          this.activationFailed()
          return
        }
        simpleAxios.defaults.headers.common['Authorization'] = `Bearer ${response.data.access_token}`
        simpleAxios.get(USER_INFO_URL)
          .then(me_response => {
            this.$store.commit('setCurrentUser', {
              currentUser: me_response.data.data.attributes,
              csrf: response.data.csrf,
              token: response.data.access_token
            })
            this.$router.replace('/')
          })
          .catch(err => this.missedUserInfo(err))
      },
      missedUserInfo(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ''
      },
      activationFailed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
        this.$store.commit('unsetCurrentUser')
      },
    }
  }
</script>