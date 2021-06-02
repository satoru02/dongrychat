<template>
  <user-relationships :relationships="followers" />
</template>

<script>
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const usersRepository = RepositoryFactory.get('users');

  export default {
    name: "Followers",
    components: {
      'user-relationships': () => import(/* webpackPrefetch: true */ './UserRelationships')
    },
    data() {
      return {
        followers: [],
        error: null,
      }
    },
    created() {
      this.getFollowers()
    },
    methods: {
      getFollowers() {
        usersRepository.getFollowers(this.$route.params.user_name)
          .then(res => this.getSuccessful(res))
          .catch(error => this.getFailed(error))
      },
      getSuccessful(res) {
        this.followers = res.data.data
      },
      getFailed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      }
    }
  }
</script>