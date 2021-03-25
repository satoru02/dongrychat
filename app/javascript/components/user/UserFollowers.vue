<template>
<user-relationships
  :relationships="followers"
  />
</template>

<script>
import { secureAxios } from '../../backend/axios';
import UserRelationships from './UserRelationships';
const FOLLOWERS_URL = `/api/v1/users/`;

export default {
  name: "Followers",
  components: {
    'user-relationships': UserRelationships
  },
  data(){
    return {
      followers: [],
      error: null,
    }
  },
  created(){
    this.getFollowers()
  },
  methods: {
    getFollowers(){
      secureAxios.get(FOLLOWERS_URL + `${this.$route.params.id}` + `/followers`)
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