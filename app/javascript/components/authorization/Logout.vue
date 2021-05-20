<template>
</template>

<script>
  import { RepositoryFactory } from '../../repositories/RepositoryFactory';
  const authRepository = RepositoryFactory.get('auth');

  export default {
    name: 'Logout',
    data(){
      return {
      }
    },
    created() {
      this.logout()
    },
    methods: {
      logout() {
        authRepository.logout(this.$store.state.currentUser.id)
          .then(res => this.logoutSuccessful(res))
          .catch(error => this.setError(error, 'Cannot log out.'))
      },
      logoutSuccessful(res) {
        localStorage.removeItem('vuex')
        this.$store.commit('unsetCurrentUser')
        this.$router.replace('/')
      }
    }
  }
</script>