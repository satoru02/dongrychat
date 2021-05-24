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
        usersRepository.getFollowers(this.$route.params.id)
          .then(res => this.Successful(res))
          .catch(error => this.Failed(error))
      },
      Successful(res) {
        this.followers = res.data.data
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      }
    }
  }
</script>