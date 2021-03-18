<template>
   <v-row>
     <v-col cols=4 v-for="(content, index) in passed_contents" :key="index">
       <base-content-sheet :img="pic" :height="230" :elevation="2" />
       コンテンツタイトル
     </v-col>
   </v-row>
</template>

<script>
  import { tmdbAxios } from '../../backend/axios';

  export default {
    name: 'ContentsList',
    props: {
      passed_contents: {
        type: Array,
        default: null,
      }
    },
    data(){
      return {
        mode: 'tv',
        contents: null,
        tmdb_endpoint: null,
        tmdb: {
          weekly_tv: `https://api.themoviedb.org/3/trending/tv/week?api_key=${process.env.TMDB_API_KEY}`,
          weekly_mv: `https://api.themoviedb.org/3/trending/mv/week?api_key=${process.env.TMDB_API_KEY}`,
          popular_tv: `https://api.themoviedb.org/3/tv/popular?api_key=${process.env.TMDB_API_KEY}&language=ja&page=1`,
          popular_mv: `https://api.themoviedb.org/3/movie/popular?api_key=${process.env.TMDB_API_KEY}&language=ja&page=1&region=JP`,
          rated_tv: `https://api.themoviedb.org/3/tv/top_rated?api_key=${process.env.TMDB_API_KEY}&language=ja&page=1`,
          streaming: ``
        }
      }
    },
    created(){
      this.endpointSwitcher()
      this.getContents()
    },
    methods: {
      endpointSwitcher(){
        if(this.$route.name === 'Streaming'){
          this.tmdb_endpoint = this.tmdb.streaming
        } else if(this.$route.name === 'TopRated'){
          this.tmdb_endpoint = this.tmdb.rated_tv
        } else if(this.$route.name === 'Popular'){
          this.tmdb_endpoint = this.tmdb.popular_tv
        }
      },
      getContents(){
        // tmdbAxios.get(this.tmdb_endpoint)
      },
    }
  }
</script>

<style scoped>
</style>