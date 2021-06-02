<template>
  <user-relationships :relationships="followings" />
</template>

<script>
  import { RepositoryFactory } from '../../repositories/RepositoryFactory';
  const usersRepository = RepositoryFactory.get('users');

  export default {
    name: "Followings",
    components: {
      'user-relationships': () => import(/* webpackPrefetch: true */ './UserRelationships')
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
        usersRepository.getFollowings(this.$route.params.user_name)
          .then(res => this.getSuccessful(res))
          .catch(error => this.getFailed(error))
      },
      getSuccessful(res) {
        this.followings = res.data.data
      },
      getFailed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      }
    }
  }
</script>