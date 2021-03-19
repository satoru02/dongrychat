<template>
<div>
  <v-btn @click="subscribe()">Subscribe</v-btn>
        <v-text-field background-color="#212529" v-model="comment" @click:append-outer="sendComment(comment)" dense
      type="text" no-details outlined append-outer-icon="mdi-send" />
  </div>
</template>

<script>
  import { secureAxios } from '../../backend/axios';
  const SPACE_ENDPOINT_FROM_SEARCH = `/api/v1/spaces/enter`;
  const SPACE_ENDPOINT_FROM_SUBSCRIPTION = `/api/v1/spaces/enter_from_subscription`;
  const SUBSCRIBE_ENDPOINT = `/api/v1/subscriptions`;

  export default {
    name: 'MvSpace',
    created() {
      this.setSpace()
    },
    data() {
      return {
        space_data: null,
        comments: [],
        members: [],
        media: 'mv',
        comment: null
      }
    },
    channels: {
      SpaceChannel: {
        connected(){},
        rejected(){},
        received(data){
          console.log(data)
        },
        disconnected(){}
      }
    },
    methods: {
      setSpace() {
        if (this.$route.name === 'subscribedMvSpace') {
          secureAxios.get(SPACE_ENDPOINT_FROM_SUBSCRIPTION, {
            params: {
              space_id: this.$route.params.space_id
            }
          }).then(res => this.createCable(res.data.data))
        } else if (this.$route.name === 'MvSpace') {
          secureAxios.get(SPACE_ENDPOINT_FROM_SEARCH, {
            params: {
              name: this.$route.params.name,
              media: this.media,
              image_path: '',
              tmdb_mv_id: ''
            }
          }).then(res => this.createCable(res.data.data))
        }
      },
      subscribe() {
        secureAxios.post(SUBSCRIBE_ENDPOINT, {
            user_id: this.$store.state.currentUser.data.id,
            space_id: this.space_data.id
          })
          .then(res => this.subscribeSuccessful(res))
          .catch(err => this.subscribeFailed(err))
      },
      subscribeSuccessful(res) {
        console.log(res)
      },
      subscribeFailed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ''
      },
      createCable(space){
        this.space_data = space
        this.$cable.subscribe({
          channel: 'SpaceChannel',
          space: space.id
        })
      },
      getComments(){
      },
      sendComment(comment){
        if(comment) {
          this.$cable.perform({
            channel: 'SpaceChannel',
            action: 'speak',
            data: {
              comment: comment,
              user_id: this.$store.state.currentUser.data.id,
              space: this.space_data.id
            }
          })
        }
      }
    }
  }
</script>

<style scoped>
</style>