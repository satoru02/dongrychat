<template>
  <div>
    <v-row>
      <v-col cols=2></v-col>
      <v-col cols=8 class="ml-16">
        <v-text-field v-if="$vuetify.breakpoint.width < 600"
          @keypress="setQuery()" @keydown.enter="search(query)" v-model="query" height="10"
           :prepend-inner-icon="'mdi-magnify'"
            dense background-color="#242c37" solo flat width="250" class="rounded-lg"
           />
      </v-col>
    </v-row>
    <v-row :class="vRowHeader">
      <v-col cols=3 sm=1 md=1 lg=1 xl=1>
        <div :class="vColTvGrid" :style="switch1 === false ? active : inactive" v-text="tv.header" />
      </v-col>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1>
        <div :style="switch1 === true ? active : inactive" v-text="movie.header" />
      </v-col>
      <v-col cols=5 sm=7 md=9 lg=9 xl=9 />
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 :class="vColSwitchGrid">
        <v-switch dense v-model="switch1" :color="colors.blue" inset :class="switchPosition" />
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=12>
        <trend-part class="mt-n10" v-if="this.switch1 === false" :items="weekly_trend_tvs" :media="media.tv" :title="weekly_title"
          :endpoint="endpoint.trending" />
        <trend-part class="mt-n10" v-else :items="weekly_trend_mvs" :media="media.mv" :title="weekly_title"
          :endpoint="endpoint.trending" />
        <upcoming-part v-if="this.switch1 === true" :items="upcoming_mvs" :media="media.mv" :title="upcoming_title"
          :endpoint="endpoint.upcoming" />
        <top-rated v-if="this.switch1 === false" :items="top_rated_tvs" :media="media.tv" :title="rated_title"
          :endpoint="endpoint.topRated" />
        <top-rated v-else :items="top_rated_mvs" :media="media.mv" :title="rated_title" :endpoint="endpoint.topRated" />
        <popular-part v-if="this.switch1 === false" :items="todays_popular_tvs" :media="media.tv" :title="popular_title"
          :endpoint="endpoint.popular" />
        <popular-part v-else :items="todays_popular_mvs" :media="media.mv" :title="popular_title"
          :endpoint="endpoint.popular" />
      </v-col>
    </v-row>
  </div>
</template>

<script>
  import SearchPopularPart from '../Search/SearchPart';
  import SearchTrendPart from '../Search/SearchPart';
  import SearchTopRatedPard from '../Search/SearchPart';
  import SearchUpcomingPart from '../Search/SearchPart';
  import { RepositoryFactory } from '../../repositories/RepositoryFactory';

  const tmdbRepository = RepositoryFactory.get('tmdb');

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
        query: '',
        canSubmit: false,
        weekly_trend_mvs: [],
        weekly_trend_tvs: [],
        todays_popular_mvs: [],
        todays_popular_tvs: [],
        top_rated_tvs: [],
        top_rated_mvs: [],
        upcoming_mvs: [],
        switch1: false,
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
          green: 'green'
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
          fontSize: '20px',
          fontWeight: 'bold',
          color: '#000000'
        },
        inactive: {
          fontSize: '20px',
          fontWeight: 'bold',
          color: '#6c757d'
        }
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
      track(){
        this.$gtag.pageview({
          page_path: '/search',
        })
      },
      getTrendTvs() {
        tmdbRepository.getTrendTvs()
      },
      getTrendMvs() {
        tmdbRepository.getTrendMvs()
      },
      getPopularTvs() {
        tmdbRepository.getPopularTvs()
      },
      getPopularMvs() {
        tmdbRepository.getPopularMvs()
      },
      getTopratedTvs() {
        tmdbRepository.getTopratedTvs()
      },
      getTopratedMvs() {
        tmdbRepository.getTopratedMvs()
      },
      getUpcomingMvs() {
        tmdbRepository.getUpcomingMvs()
      },
      getTvContents() {
        Promise.all([this.getTrendTvs(), this.getPopularTvs(), this.getTopratedTvs()])
          .then((res) => {
            this.weekly_trend_tvs = res[0].data.results.slice(0, 20)
            this.todays_popular_tvs = res[1].data.results.slice(0, 20)
            this.top_rated_tvs = res[2].data.results.slice(0, 20)
          })
      },
      getMvContents() {
        Promise.all([this.getTrendMvs(), this.getPopularMvs(), this.getTopratedMvs(), this.getUpcomingMvs()])
          .then((res) => {
            this.weekly_trend_mvs = res[0].data.results.slice(0, 20)
            this.todays_popular_mvs = res[1].data.results.slice(0, 20)
            this.top_rated_mvs = res[2].data.results.slice(0, 20)
            this.upcoming_mvs = res[3].data.results.slice(0, 20)
          })
      },
      setQuery(){
        this.canSubmit = true
      },
      search(query) {
        if(!this.canSubmit){
          return
        }
        this.$router.replace({
          name: 'multi',
          params: {
            query: query
          }
        })
        this.query = ''
        this.canSubmit = false
      },
    },
    computed: {
      vColTvGrid(){
        switch(this.$vuetify.breakpoint.name){
          case 'xs' : return 'ml-16'
          case 'sm' : return ''
          case 'md' : return ''
          case 'lg' : return 'ml-10'
          case 'xl' : return ''
        }
      },
      vColSwitchGrid(){
        switch(this.$vuetify.breakpoint.name){
          case 'xs' : return 'ml-16'
          case 'sm' : return ''
          case 'md' : return ''
          case 'lg' : return 'ml-n7'
          case 'xl' : return ''
        }
      },
      vRowHeader(){
        switch(this.$vuetify.breakpoint.name){
          case 'xs' : return 'ml-9 mb-n8 mt-n7'
          case 'sm' : return ''
          case 'md' : return ''
          case 'lg' : return 'ml-3 mb-n5 mt-2'
          case 'xl' : return ''
        }
      }
    }
  }
</script>

<style scoped>
</style>