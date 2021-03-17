<template>
</template>

<script>
import { secureAxios } from '../../backend/axios';
const SPACE_ENDPOINT = `/api/v1/spaces/enter`;

export default {
  name: 'Space',
  created(){
    this.setSpace()
  },
  props: {
    name: {
      type: String,
      // required: true
    },
    media: {
      type: String,
      // required: true
    }
  },
  data(){
    return {
      comments: [],
      members: [],
    }
  },
  methods:{
    // setSpace(name, media){
    //   secureAxios.get(SP_ENDPOINT, { params: {
    //     name: this.$route.params.name,
    //     season: this.$route.params.value.season_number,
    //     episode: this.$route.params.value.episode_number,
    //     media: this.$route.params.media,
    //   }})}

    setSpace(){
      secureAxios.get(SPACE_ENDPOINT, { params: {
        name: 'test',
        season: this.$route.params.value.season_number,
        episode: this.$route.params.value.episode_number,
        media: 'tv',
    }})
     .then(res => this.enterSuccessful(res))
     .cacth(err => this.enterFailed())
    },
    enterSuccessful(res){
      console.log(res)
    },
    enterFailed(err){
      console.log(err)
    }
  }
}
</script>

<style scoped>
</style>