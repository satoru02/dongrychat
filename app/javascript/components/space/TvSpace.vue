<template>
  <v-btn @click="subscribe()">Subscribe</v-btn>
</template>

<script>
  import { secureAxios } from '../../backend/axios';
  // setting space
  const SPACE_ENDPOINT = `/api/v1/spaces/enter`;
  // subscribe space
  const SUBSCRIBE_ENDPOINT = `/api/v1/subscriptions`;

  export default {
    name: 'TvSpace',
    created(){
      this.setSpace()
    },
    data(){
      return {
        space_data: null,
        comments: [],
        members: [],
        media: 'tv'
      }
    },
    methods: {
      setSpace(){
        secureAxios.get(SPACE_ENDPOINT, { params: {
          name: this.$route.params.name,
          season: this.$route.params.season_number,
          episode: this.$route.params.episode_number,
          media: this.media
      }}).then(res => this.space_data = res.data.data)
      },
      subscribe(){
        secureAxios.post(SUBSCRIBE_ENDPOINT, {
          user_id: this.$store.state.currentUser.data.id,
          space_id: this.space_data.id
        })
        .then(res => this.subscribeSuccessful(res))
        .catch(err => this.subscribeFailed(err))
      },
      subscribeSuccessful(res){
        console.log(res)
      },
      subscribeFailed(err){
        console.log(err)
      }
    }
  }
</script>

<style scoped>
</style>