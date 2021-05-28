<template>
  <v-container :key="componentKey">
    <v-row :class="vRowHeader">
      <v-col cols=3 sm=1 md=1 lg=2 xl=1>
        <div :class="vColTvGrid" :style="switch1 === false ? active : inactive" v-text="'シリーズ'" />
      </v-col>
      <v-col cols=1 sm=1 md=1 lg=2 xl=1>
        <div :style="switch1 === true ? active : inactive" v-text="'映画'" />
      </v-col>
      <v-col cols=5 sm=7 md=9 lg=7 xl=9 />
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 :class="vColSwitchGrid">
        <v-switch dense v-model="switch1" :color="colors.blue" inset :class="switchPosition" />
      </v-col>
    </v-row>
    <base-list :items="items" :media="media" />
  </v-container>
</template>

<script>
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const tmdbRepository = RepositoryFactory.get('tmdb');

  export default {
    name: 'Content',
    components: {
      'base-list': () => import( /* webpackPrefetch: true */ '../Base/BaseList')
    },
    data() {
      return {
        items: [],
        componentKey: 0,
        endpoint: '',
        switch1: false,
        media: '',
        switchPosition: 'mt-1',
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
      this.switchContents()
    },
    watch: {
      '$route.name'() {
        this.items = []
        this.switchContents()
        this.forceRerender()
      },
      'switch1'(){
        this.items = []
        this.switchContents()
        this.forceRerender()
      }
    },
    methods: {
      switchContents() {
        if (this.switch1 === false) {
          this.media = 'tv';
          switch (this.$route.name) {
            case 'Popular':
              return tmdbRepository.getPopularTvs()
                .then(res => this.searchSuccessful(res))
                .catch(err => this.searchFailed(err))
            case 'Trend':
              return tmdbRepository.getTrendTvs()
                .then(res => this.searchSuccessful(res))
                .catch(err => this.searchFailed(err))
            case 'TopRated':
              return tmdbRepository.getTopRatedTvs()
                .then(res => this.searchSuccessful(res))
                .catch(err => this.searchFailed(err))
          }
        } else if (this.switch1 === true) {
          this.media = 'movie';
          switch (this.$route.name) {
            case 'Popular':
              return tmdbRepository.getPopularMvs()
                .then(res => this.searchSuccessful(res))
                .catch(err => this.searchFailed(err))
            case 'Trend':
              return tmdbRepository.getTrendMvs()
                .then(res => this.searchSuccessful(res))
                .catch(err => this.searchFailed(err))
            case 'TopRated':
              return tmdbRepository.getTopRatedMvs()
                .then(res => this.searchSuccessful(res))
                .catch(err => this.searchFailed(err))
            // case 'Upcoming':
            //   return tmdbRepository.getUpcomingMvs()
            //     .then(res => this.searchSuccessful(res))
            //     .catch(err => this.searchFailed(err))
          }
        }
      },
      track() {
        this.$gtag.pageview({
          page_path: '/search',
        })
      },
      forceRerender() {
        this.componentKey += 1
      },
      searchSuccessful(res) {
        console.log(res)
        this.items = res.data.results
      },
      showContents(item) {
        if (this.media == this.tv.type) {
          this.$router.push({
            name: this.tv.details,
            params: {
              id: item.id,
              number: 1,
              tv_name: item.name
            }
          })
        } else if (this.media == this.movie.type) {
          this.$router.push({
            name: this.movie.details,
            params: {
              id: item.id,
              mv_name: item.title
            }
          })
        }
      }
    },
    computed: {
      vColTvGrid() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-16'
          case 'sm':
            return ''
          case 'md':
            return ''
          case 'lg':
            return ''
          case 'xl':
            return ''
        }
      },
      vColSwitchGrid() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-16'
          case 'sm':
            return ''
          case 'md':
            return ''
          case 'lg':
            return 'ml-n1'
          case 'xl':
            return ''
        }
      },
      vRowHeader() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-9 mb-n8 mt-n7'
          case 'sm':
            return ''
          case 'md':
            return ''
          case 'lg':
            return 'mb-n5'
          case 'xl':
            return ''
        }
      }
    }
  }
</script>

<style scoped>
</style>