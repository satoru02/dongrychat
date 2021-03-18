<template>
 <div class="scrollmenu">
   <v-row>
     <v-col cols=12>
       <h3>今週のピックアップ</h3>
     </v-col>
   </v-row>
   <v-row>
     <v-col cols=4 v-for="(item, index) in weekly_trend_contents" :key="index" @click="showContents(item)">
     <!-- <v-col cols=4 v-for="(item, index) in 3" :key="index" @click="showContents()"> -->
       <base-content-sheet :img="pic" :height="230" :elevation="2" />
       コンテンツタイトル
     </v-col>
   </v-row>
 </div>
</template>

<script>
import BaseContentSheet from '../base/BaseContentSheet';

export default {
  name: 'SearchPopularPart',
  components: {
    'base-content-sheet': BaseContentSheet
  },
  props:{
    weekly_trend_contents: {
      type: Array,
      default: Array,
      required: true,
    },
    media: {
      type: String,
      default: 'tv',
      required: true
    },
  },
  data(){
    return{
      pic: "https://freeclassicimages.com/images/7th-Heaven-1927-1A3-movie-poster.jpg"
    }
  },
  methods: {
    showContents(item){
      if(this.media === 'tv'){
        this.$router.push({name: 'TvDetails', params:{ id: item.id, number: 1, tv_name: item.name } })
      } else if(this.media === 'mv') {
        this.$router.push({name: 'MvDetails', params:{ id: item.id, mv_name: item.name } })
      }
    }
  }
}
</script>

<style scoped>
</style>