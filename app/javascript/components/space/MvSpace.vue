<template>
</template>

<script>
import { secureAxios } from '../../backend/axios';
const SPACE_ENDPOINT = `/api/v1/spaces/enter`;

export default {
  name: 'MvSpace',
  created(){
    this.setSpace()
  },
  data(){
    return {
      space_name: null,
      space_description: null,
      space_image: null,
      space_data: null,
      comments: [],
      members: [],
      media: 'mv'
    }
  },
  methods:{
    setSpace(){
      secureAxios.get(SPACE_ENDPOINT, { params: {
        name: this.$route.params.name,
        media: this.media
    }}).then(res => console.log(res.data.data))
    },
  }
}
</script>

<style scoped>
</style>