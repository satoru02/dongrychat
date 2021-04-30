<template>
</template>

<script>
  import {
    simpleAxios
  } from '../../backend/axios';

  export default {
    name: 'AccountActivation',
    data(){
      return {
        activation_url: '/api/v1/account_activations',
        user_info_url: '/api/v1/users/me'
      }
    },
    created() {
      simpleAxios.post(this.activation_url, {
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
        simpleAxios.get(this.user_info_url)
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