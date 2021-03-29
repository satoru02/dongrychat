<template>
 <div class="mt-7">
   <v-row>
     <v-col cols=12>
       <h3 class="mb-2 head-title">トレンド</h3>
     </v-col>
   </v-row>
   <v-row>
     <v-col cols=4 v-for="(item, index) in weekly_trend_contents" :key="index" @click="showContents(item)">
     <!-- <v-col cols=3 v-for="(item, index) in 4" :key="index"> -->
       <base-content-sheet :img="pic" :height="200" />
       コンテンツタイトル
     </v-col>
   </v-row>
 </div>
</template>

<script>
import BaseContentSheet from '../base/BaseContentSheet';

export default {
  name: 'SearchTopRatedPart',
  components: {
    'base-content-sheet': BaseContentSheet
  },
  props:{
    media: {
      type: String,
      default: 'tv',
      required: true
    },
    weekly_trend_contents: {
      type: Array,
      default: Array,
      required: true,
    }
  },
  data(){
    return{
      pic: "https://freeclassicimages.com/images/7th-Heaven-1927-1A3-movie-poster.jpg"
    }
  },
  methods: {
    showContents(item){
      if(this.media == 'tv'){
        this.$router.push({name: 'TvDetails', params:{ id: item.id, number: 1, tv_name: item.name } })
      } else if(this.media == 'mv') {
        this.$router.push({name: 'MvDetails', params:{ id: item.id, mv_name: item.title } })
      }
    }
  }
}
</script>

<style scoped>
  .head-title {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 20px;
    color: #000000;
  }
</style>