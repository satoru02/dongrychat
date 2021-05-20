<template>
  <user-relationships :relationships="followers" />
</template>

<script>
  import UserRelationships from './UserRelationships';
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const usersRepository = RepositoryFactory.get('users');

  export default {
    name: "Followers",
    components: {
      'user-relationships': UserRelationships
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