<template>
  <!-- <div class="mt-7">
   <v-row>
     <v-col cols=12>
       <h3 class="mb-2 head-title">トレンド</h3>
     </v-col>
   </v-row>
   <v-row>
     <v-col cols=4 v-for="(item, index) in weekly_trend_contents" :key="index" @click="showContents(item)">
       <base-content-sheet :img="pic" :height="200" />
       コンテンツタイトル
     </v-col>
   </v-row>
 </div> -->
  <v-container>
    <v-avatar v-for="(item, index) in weekly_trend_contents" :key="index" @click="showContents(item)"
     class="rounded-xl ml-5 mt-4" color="primary" tile size=100 width=140
      height=230>
      <v-row>
        <v-col lg=12>
          <base-content-sheet :img="base_tmdb_img_url + item.poster_path" :height="230" />
        </v-col>
      </v-row>
    </v-avatar>
  </v-container>
</template>

<script>
  import BaseContentSheet from '../base/BaseContentSheet';

  export default {
    name: 'SearchTopRatedPart',
    components: {
      'base-content-sheet': BaseContentSheet
    },
    props: {
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
    data() {
      return {
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w200`,
      }
    },
    methods: {
      showContents(item) {
        if (this.media == 'tv') {
          this.$router.push({
            name: 'TvDetails',
            params: {
              id: item.id,
              number: 1,
              tv_name: item.name
            }
          })
        } else if (this.media == 'mv') {
          this.$router.push({
            name: 'MvDetails',
            params: {
              id: item.id,
              mv_name: item.title
            }
          })
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