<template>
  <v-container>
    <popular-part v-if="this.mode === 'tv'" :weekly_trend_contents="weekly_trend_tvs" :media="this.mode"/>
    <popular-part v-else :weekly_trend_contents="weekly_trend_mvs" :media="this.mode" />
    <trend-part />
    <top-rated v-if="this.mode === 'tv'" :weekly_trend_contents="weekly_trend_tvs" />
    <top-rated v-else :weekly_trend_contents="weekly_trend_mvs" />
    <!-- <actors-part /> -->
  </v-container>
</template>

<script>
  import { tmdbAxios } from '../../backend/axios';
  import SearchPopularPart from '../search/SearchPopularPart';
  import SearchTrendPart from '../search/SearchTrendPart';
  import SearchTopRatedPard from '../search/SearchTopRatedPart';
  // import SearchActorsPart from '../search/SearchActorsPart';

  const WTV_ENDPOINT = `https://api.themoviedb.org/3/trending/tv/week?api_key=${process.env.TMDB_API_KEY}`;
  const WMV_ENDPOINT = `https://api.themoviedb.org/3/trending/mv/week?api_key=${process.env.TMDB_API_KEY}`;
  const TTV_ENDPOINT = `https://api.themoviedb.org/3/tv/popular?api_key=${process.env.TMDB_API_KEY}&language=ja&page=1`;
  const TMV_ENDPOINT = `https://api.themoviedb.org/3/movie/popular?api_key=${process.env.TMDB_API_KEY}&language=ja&page=1&region=JP`;
  const TRTV_ENDPOINT = `https://api.themoviedb.org/3/tv/top_rated?api_key=${process.env.TMDB_API_KEY}&language=ja&page=1`;

  export default {
    name: 'Search',
    components: {
      'popular-part': SearchPopularPart,
      'trend-part': SearchTrendPart,
      'top-rated': SearchTopRatedPard,
      // 'actors-part': SearchActorsPart,
    },
    data() {
      return {
        mode: 'tv',
        weekly_trend_mvs: [],
        weekly_trend_tvs: [],
        todays_popular_mvs: [],
        todays_popular_tvs: [],
        top_rated_tvs: [],
      }
    },
    created(){
      this.getContents()
    },
    methods:{
      getTrendTvs(){
        return tmdbAxios.get(WTV_ENDPOINT)
      },
      getTrendMvs(){
        return tmdbAxios.get(WMV_ENDPOINT)
      },
      getPopularTvs(){
        return tmdbAxios.get(TTV_ENDPOINT)
      },
      getPopularMvs(){
        return tmdbAxios.get(TMV_ENDPOINT)
      },
      getTopratedTvs(){
        return tmdbAxios.get(TRTV_ENDPOINT)
      },
      getContents(){
        Promise.all([this.getTrendTvs(), this.getTrendMvs(), this.getPopularTvs(), this.getPopularMvs(), this.getTopratedTvs()])
        .then((res) => {
          this.weekly_trend_tvs = res[0].data.results
          this.weekly_trend_mvs = res[1].data.results
          this.todays_popular_tvs = res[2].data.results
          this.todays_popular_mvs = res[3].data.results
          this.top_rated_tvs = res[4].data.results
        })
      }
    }
  }
</script>

<style scoped>
</style>