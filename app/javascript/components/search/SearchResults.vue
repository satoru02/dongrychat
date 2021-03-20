<template>
  <v-container>
    <v-row>
      <v-col md=3 lg=3 xl=3 v-for="(item, index) in items" :key="index" @click="showContents(item)">
       <base-content-sheet :img="base_tmdb_img_url + item.backdrop_path" :round="'rounded-xl'" :height="250" />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
  import { tmdbAxios } from '../../backend/axios';
  import BaseContentSheet from '../base/BaseContentSheet';

  export default {
    name: 'SearchResults',
    components: {
      'base-content-sheet': BaseContentSheet
    },
    data(){
      return {
        items: [],
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w500`,
      }
    },
    created(){
      tmdbAxios.get(`https://api.themoviedb.org/3/search/multi?api_key=${process.env.TMDB_API_KEY}&language=en-US&query=${this.$route.params.query}&page=1&include_adult=false`)
        .then(res => this.searchSuccessful(res))
        .catch(err => this.searchFailed(err))
    },
    updated(){
      tmdbAxios.get(`https://api.themoviedb.org/3/search/multi?api_key=${process.env.TMDB_API_KEY}&language=en-US&query=${this.$route.params.query}&page=1&include_adult=false`)
        .then(res => this.searchSuccessful(res))
        .catch(err => this.searchFailed(err))
    },
    methods: {
      searchSuccessful(res){
        this.items = res.data.results
      },
      searchFailed(err){
        this.error = (err.response && err.response.data && err.response.data.error) || ''
      },
      showContents(item){
        if(item.media_type === 'tv'){
          this.$router.push({name: 'TvDetails', params:{ id: item.id, number: 1, tv_name: item.name } })
        } else if(item.media_type === 'movie') {
          this.$router.push({name: 'MvDetails', params:{ id: item.id, mv_name: item.name } })
        }
      }
    }
  }
</script>

<style scoped>
</style>