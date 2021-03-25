<template>
  <user-relationships
    :relationships="followings"
   />
</template>

<script>
  import { secureAxios } from '../../backend/axios';
  import UserRelationships from './UserRelationships';
  const  FOLLOWINGS_URL = '/api/v1/users/';

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
      getFollowings(){
        secureAxios.get(FOLLOWINGS_URL + `${this.$route.params.id}` + `/following`)
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