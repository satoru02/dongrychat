<template>
  <div>
  <v-row :class="[$vuetify.breakpoint.smAndUp ? 'mt-0': 'mt-4']">
    <v-col lg=1 xl=1 class="hidden-xs-only hidden-sm-only hidden-md-only" />
    <v-col cols=9 sm=10 md=10 lg=12 xl=12 :class="[$vuetify.breakpoint.smAndUp ? 'ml-0': 'ml-1 mt-2']">
      <div class="streaming-title">{{ streaming_title }}</div></v-col>
  </v-row>
  <v-row :class="[$vuetify.breakpoint.smAndUp ? 'mt-n3': 'mt-n10']">
    <!-- <v-col cols=0 lg=1 /> -->
    <v-col cols=3 lg=2 v-for="(n,index) in items" :key="index">
      <v-avatar size=110 height=170 tile class="rounded-lg">
        <base-content-sheet :img="n.pic" :height="200" />
      </v-avatar>
    </v-col>
  </v-row>
  </div>
</template>

<script>
import BaseContentSheet from '../base/BaseContentSheet';

export default {
  name: 'TopContentsRow',
  components: {
    'base-content-sheet': BaseContentSheet
  },
  props:{
    streaming_title:{
      type: String,
    }
  },
  data(){
    return {
       items: [
         {
            title: 'The Mandalorian S1-EP4',
            pic: 'https://freeclassicimages.com/images/under-the-tonto-rim-1933-movie-poster.jpg',
            count: "1"
          },
          {
            title: 'Queens Gambit S1-EP8',
            pic: 'https://freeclassicimages.com/images/untouchables-1987-movie-poster.jpg',
            count: "2"
          },
          {
            title: 'Game of the thrones',
            pic: 'https://freeclassicimages.com/images/MAD-MAX-2-movie-poster.jpg',
            count: "3"
          },
          {
            title: 'Game of the thrones',
            pic: 'https://freeclassicimages.com/images/MAD-MAX-2-movie-poster.jpg',
            count: "4"
          }
        ]
    }
  }
}
</script>

<style scoped>
.streaming-title{
  font-family: 'Helvetica Neue', sans-serif;
  font-weight: bold;
  font-size: 12px;
  color: #000000;
  letter-spacing: 1.24px;
}

.scrollmenu {
  overflow: auto;
  white-space: nowrap;
}
</style>