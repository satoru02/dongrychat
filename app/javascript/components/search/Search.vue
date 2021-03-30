<template>
    <v-container class="mt-n3">
      <v-row no-gutters dense class="mb-n16">
        <v-col lg=11 />
        <v-col lg=1>
          <v-switch v-model="switch1" color="orange" inset />
        </v-col>
      </v-row>
      <!-- <popular-part v-if="this.switch1 === true" :weekly_trend_contents="weekly_trend_tvs" :media="'tv'"/>
    <popular-part v-else :weekly_trend_contents="weekly_trend_mvs" :media="'mv'" />
    <trend-part /> -->
    <keep-alive>
      <top-rated v-if="this.switch1 === true" :weekly_trend_contents="weekly_trend_tvs" :media="'tv'" />
      <top-rated v-else :weekly_trend_contents="weekly_trend_mvs" :media="'mv'" />
    </keep-alive>
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
  const WMV_ENDPOINT = `https://api.themoviedb.org/3/trending/movie/week?api_key=${process.env.TMDB_API_KEY}`;
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
        weekly_trend_mvs: [],
        weekly_trend_tvs: [],
        todays_popular_mvs: [],
        todays_popular_tvs: [],
        top_rated_tvs: [],
        switch1: false,
      }
    },
    created() {
      this.getMvContents()
    },
    watch: {
      switch1: function () {
        this.weekly_trend_mvs = []
        this.weekly_trend_tvs = []
        this.todays_popular_mvs = []
        this.todays_popular_tvs = []
        this.top_rated_tvs = []
        if (this.switch1 === true) {
          this.getTvContents()
        } else {
          this.getMvContents()
        }
      }
    },
    methods: {
      getTrendTvs() {
        return tmdbAxios.get(WTV_ENDPOINT)
      },
      getTrendMvs() {
        return tmdbAxios.get(WMV_ENDPOINT)
      },
      getPopularTvs() {
        return tmdbAxios.get(TTV_ENDPOINT)
      },
      getPopularMvs() {
        return tmdbAxios.get(TMV_ENDPOINT)
      },
      getTopratedTvs() {
        return tmdbAxios.get(TRTV_ENDPOINT)
      },
      getTvContents() {
        Promise.all([this.getTrendTvs(), this.getPopularTvs(), this.getTopratedTvs()])
          .then((res) => {
            this.weekly_trend_tvs = res[0].data.results
            this.todays_popular_tvs = res[1].data.results
            this.top_rated_tvs = res[2].data.results
          })
      },
      getMvContents() {
        Promise.all([this.getTrendMvs(), this.getPopularMvs()])
          .then((res) => {
            this.weekly_trend_mvs = res[0].data.results
            this.todays_popular_mvs = res[1].data.results
          })
      }
    }
  }
</script>

<style scoped>
</style>