<template>
  <v-btn @click="subscribe()">Subscribe</v-btn>
</template>

<script>
  import { secureAxios } from '../../backend/axios';
  const SPACE_ENDPOINT_FROM_SEARCH = `/api/v1/spaces/enter`;
  const SPACE_ENDPOINT_FROM_SUBSCRIPTION = `/api/v1/spaces/enter_from_subscription`;
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
        media: 'tv',
      }
    },
    methods: {
      setSpace(){
        if(this.$route.params.from === 'subscription'){
          secureAxios.get(SPACE_ENDPOINT_FROM_SUBSCRIPTION, { params: {
            space_id: this.$route.params.space_id
          }}).then(res => this.space_data = res.data.data)
        } else if(this.$route.params.from === 'detailsPage') {
          secureAxios.get(SPACE_ENDPOINT_FROM_SEARCH, { params: {
            name: this.$route.params.name,
            season: this.$route.params.season_number,
            episode: this.$route.params.episode_number,
            episode_title: this.$route.params.value.name,
            media: this.media,
            tmdb_tv_id: this.$route.params.tmdb_tv_id,
            image_path: this.$route.params.image_path
          }}).then(res => this.space_data = res.data.data)
        }
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
        this.error = (err.response && err.response.data && err.response.data.error) || ''
      }
    }
  }
</script>

<style scoped>
</style>