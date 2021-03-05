<template>
  <v-container>
    <top-featured-contents />
    <div v-for="(n, index) in streaming_title" :key="index">
      <top-contents-row :streaming_title="n" />
    </div>
  </v-container>
</template>

<script>
import TopFeaturedContents from '../top/TopFeaturedContents'
import TopContentsRow from '../top/TopContentsRow'

export default {
  name: 'TopPage',
  components: {
    'top-contents-row': TopContentsRow,
    'top-featured-contents': TopFeaturedContents
  },
  data(){
    return {
      streaming_title:[
        'Spark ✨',
        'Netflix',
        'Amazon Prime',
        'Disney Plus'
      ]
    }
  }
}
</script>

<style scoped>
</style>