<template>
  <v-container fluid>
    <v-row>
      <v-col md=1 lg=1 xl=1>
        <div :style="switch1 === false ? active : inactive" v-text="tv.header" />
        <!-- <v-avatar :color="colors.blue" :size="5" v-if="switch1 === false" :class="tv.avatar" /> -->
      </v-col>
      <v-col md=1 lg=1 xl=1>
        <div :style="switch1 === true ? active : inactive" v-text="movie.header" />
        <!-- <v-avatar :color="colors.blue" :size="5" v-if="switch1 === true" :class="movie.avatar" /> -->
      </v-col>
      <v-col md=9 lg=9 xl=9 />
      <v-col md=1 lg=1 xl=1>
        <v-switch v-model="switch1" :color="colors.orange" inset :class="switchPosition" />
      </v-col>
    </v-row>

    <trend-part class="mt-n10" v-if="this.switch1 === false" :items="weekly_trend_tvs" :media="media.tv" :title="weekly_title"
      :endpoint="endpoint.trending" />
    <trend-part v-else :items="weekly_trend_mvs" :media="media.mv" :title="weekly_title"
      :endpoint="endpoint.trending" />
    <!-- <v-row :class="multiple_part.position">
      <v-col md=6 lg=6 xl=6 v-for="(n,index) in 2" :key="index">
        <v-card :elevation="multiple_part.elevation" :height="multiple_part.height" :class="multiple_part.round"
          outlined>
        </v-card>
      </v-col>
    </v-row> -->

    <upcoming-part v-if="this.switch1 === true" :items="upcoming_mvs" :media="media.mv" :title="upcoming_title"
      :endpoint="endpoint.upcoming" />
    <top-rated v-if="this.switch1 === false" :items="top_rated_tvs" :media="media.tv" :title="rated_title"
      :endpoint="endpoint.topRated" />
    <top-rated v-else :items="top_rated_mvs" :media="media.mv" :title="rated_title" :endpoint="endpoint.topRated" />
    <popular-part v-if="this.switch1 === false" :items="todays_popular_tvs" :media="media.tv" :title="popular_title"
      :endpoint="endpoint.popular" />
    <popular-part v-else :items="todays_popular_mvs" :media="media.mv" :title="popular_title"
      :endpoint="endpoint.popular" />
  </v-container>
</template>

<script>
  import {
    tmdbAxios
  } from '../../backend/axios';
  import SearchPopularPart from '../Search/SearchPart';
  import SearchTrendPart from '../Search/SearchPart';
  import SearchTopRatedPard from '../Search/SearchPart';
  import SearchUpcomingPart from '../Search/SearchPart';
  export default {
    name: 'Search',
    components: {
      'popular-part': SearchPopularPart,
      'top-rated': SearchTopRatedPard,
      'trend-part': SearchTrendPart,
      'upcoming-part': SearchUpcomingPart,
    },
    data() {
      return {
        weekly_trend_mvs: [],
        weekly_trend_tvs: [],
        todays_popular_mvs: [],
        todays_popular_tvs: [],
        top_rated_tvs: [],
        top_rated_mvs: [],
        upcoming_mvs: [],
        tmdb_api: {
          tv: {
            popular: `https://api.themoviedb.org/3/tv/popular?api_key=${process.env.TMDB_API_KEY}&language=ja&page=1`,
            trending: `https://api.themoviedb.org/3/trending/tv/week?api_key=${process.env.TMDB_API_KEY}&language=ja`,
            topRated: `https://api.themoviedb.org/3/tv/top_rated?api_key=${process.env.TMDB_API_KEY}&language=ja&page=1`
          },
          movie: {
            popular: `https://api.themoviedb.org/3/movie/popular?api_key=${process.env.TMDB_API_KEY}&language=ja&page=1`,
            trending: `https://api.themoviedb.org/3/trending/movie/week?api_key=${process.env.TMDB_API_KEY}&language=ja`,
            topRated: `https://api.themoviedb.org/3/movie/top_rated?api_key=${process.env.TMDB_API_KEY}&language=ja&page=1`,
            upcoming: `https://api.themoviedb.org/3/movie/upcoming?api_key=${process.env.TMDB_API_KEY}&language=en-US&page=1`
          }
        },
        switch1: false,
         // for css------------------------------------------
        media: {
          tv: 'tv',
          mv: 'mv'
        },
        endpoint: {
          trending: 'trending',
          popular: 'popular',
          topRated: 'topRated',
          upcoming: 'upcoming',
        },
        switchPosition: 'mt-1',
        weekly_title: '今週のおすすめ',
        popular_title: '人気の作品',
        rated_title: '評価の高い作品',
        upcoming_title: 'もうすぐ公開',
        multiple_part: {
          position: 'mt-n1',
          elevation: '0',
          height: '393',
          round: 'rounded-lg'
        },
        colors: {
          blue: 'blue',
          orange: 'orange'
        },
        tv: {
          header: 'TV',
          avatar: 'ml-4',
        },
        movie: {
          header: 'MOVIE',
          avatar: 'ml-10'
        },
        active: {
          fontFamily: 'Helvetica Neue, sans-serif',
          fontSize: '25px',
          fontWeight: 'bold',
          color: '#000000'
        },
        inactive: {
          fontFamily: 'Helvetica Neue, sans-serif',
          fontSize: '25px',
          fontWeight: 'bold',
          color: '#8f8f8f'
        }
         // ------------------------------------------
      }
    },
    created() {
      this.getTvContents()
    },
    watch: {
      switch1: function () {
        this.weekly_trend_mvs = []
        this.weekly_trend_tvs = []
        this.todays_popular_mvs = []
        this.todays_popular_tvs = []
        this.top_rated_tvs = []
        if (this.switch1 === false) {
          this.getTvContents()
        } else {
          this.getMvContents()
        }
      }
    },
    methods: {
      getTrendTvs() {
        return tmdbAxios.get(this.tmdb_api.tv.trending)
      },
      getTrendMvs() {
        return tmdbAxios.get(this.tmdb_api.movie.trending)
      },
      getPopularTvs() {
        return tmdbAxios.get(this.tmdb_api.tv.popular)
      },
      getPopularMvs() {
        return tmdbAxios.get(this.tmdb_api.movie.popular)
      },
      getTopratedTvs() {
        return tmdbAxios.get(this.tmdb_api.tv.topRated)
      },
      getTopratedMvs() {
        return tmdbAxios.get(this.tmdb_api.movie.topRated)
      },
      getUpcomingMvs() {
        return tmdbAxios.get(this.tmdb_api.movie.upcoming)
      },
      getTvContents() {
        Promise.all([this.getTrendTvs(), this.getPopularTvs(), this.getTopratedTvs()])
          .then((res) => {
            this.weekly_trend_tvs = res[0].data.results.slice(0, 5)
            this.todays_popular_tvs = res[1].data.results.slice(0, 5)
            this.top_rated_tvs = res[2].data.results.slice(0, 5)
          })
      },
      getMvContents() {
        Promise.all([this.getTrendMvs(), this.getPopularMvs(), this.getTopratedMvs(), this.getUpcomingMvs()])
          .then((res) => {
            this.weekly_trend_mvs = res[0].data.results.slice(0, 5)
            this.todays_popular_mvs = res[1].data.results.slice(0, 5)
            this.top_rated_mvs = res[2].data.results.slice(0, 5)
            this.upcoming_mvs = res[3].data.results.slice(0, 5)
          })
      },
    }
  }
</script>

<style scoped>
</style>