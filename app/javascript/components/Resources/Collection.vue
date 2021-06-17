<template>
  <v-container fluid class="mt-3">
    <v-tabs height="40" class="mt-n1 ml-5" background-color='#ffffff'>
      <v-tabs-slider color="#111111"></v-tabs-slider>
      <v-tab @click="changeContents(tab)" class="tab-name" active-class="black--text" v-for="(tab, index) in tabs"
        :key="index">
        <icon-base v-if="tab === 'ドラマ'" class="ml-n2 mr-2" :iconColor="'#606770'" :width="'14'" :height="'14'" icon-name="icon-tv" :viewBox="'0 0 64 64'"><icon-tv /></icon-base>
        <icon-base v-if="tab === '映画'" class="ml-n2 mr-2" :iconColor="'#606770'" :width="'14'" :height="'14'" icon-name="icon-movie" :viewBox="'0 0 511.81 511.81'"><icon-movie /></icon-base>
        {{tab}}
      </v-tab>
    </v-tabs>
    <v-divider class="ml-5" />
    <base-list class="mt-3 ml-2" :key="componentKey" :items="items" :media="media" />
  </v-container>
</template>

<script>
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const tmdbRepository = RepositoryFactory.get('tmdb');

  export default {
    name: 'Collection',
    components: {
      'base-list': () => import( /* webpackPrefetch: true */ '../Base/BaseList'),
      'icon-base': () => import( /* webpackPrefetch */ '../Icon/IconBase'),
      'icon-tv': () => import( /* webpackPrefetch: true */ '../Icon/IconTv.vue'),
      'icon-movie': () => import( /* webpackPrefetch: true */ '../Icon/IconMovie.vue'),
    },
    data() {
      return {
        items: [],
        componentKey: 0,
        tabs: [
          'ドラマ',
          '映画',
        ],
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
      changeContents(tab) {
        if (tab === 'ドラマ') {
          this.switch1 = false
        } else if (tab === '映画') {
          this.switch1 = true
        }
      },
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
      vColSwitchGrid() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-16'
          case 'sm':
            return ''
          case 'md':
            return ''
          case 'lg':
            return 'ml-n5'
          case 'xl':
            return ''
        }
      },
      vRowHeader() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'mb-n7 mt-1'
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
  .tab-name {
    font-weight: bold;
    font-size: 14px;
    color: #24292e;
  }
</style>