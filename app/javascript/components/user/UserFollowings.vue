<template>
  <user-relationships :relationships="followings" />
</template>

<script>
  import UserRelationships from './UserRelationships';
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const usersRepository = RepositoryFactory.get('users');

  export default {
    name: "Followings",
    components: {
      'user-relationships': UserRelationships
    },
    data() {
      return {
        followings: [],
        error: null,
      }
    },
    created() {
      this.getFollowings()
    },
    methods: {
      getFollowings() {
        usersRepository.getFollowers(this.$route.params.id)
          .then(res => this.Successful(res))
          .catch(error => this.Failed(error))
      },
      Successful(res) {
        this.followings = res.data.data
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      }
    }
  }
</script>