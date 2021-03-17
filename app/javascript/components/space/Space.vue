<template>
</template>

<script>
import { secureAxios } from '../../backend/axios';
const SPACE_ENDPOINT = `/api/v1/spaces/enter`;

export default {
  name: 'Space',
  created(){
    console.log(this.$route.params.value)
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
      space_name: null,
      space_description: null,
      space_image: null,
      space_data: null,
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
    //     media: media,
    //   }})}

    setSpace(){
      secureAxios.get(SPACE_ENDPOINT, { params: {
        name: 'malio',
        season: this.$route.params.season_number,
        episode: this.$route.params.episode_number,
        media: 'tv'
    }}).then(res => console.log(res.data.data))
    },
  }
}
</script>

<style scoped>
</style>