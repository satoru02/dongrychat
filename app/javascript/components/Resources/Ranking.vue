<template>
  <v-container fluid class="ml-10">
    <!-- <base-banner class="ml-14" /> -->

    <!-- <sub-header class="ml-2 mt-n3">
      <template v-slot:popular_header="subHeaderProps">
        <h3 :class="gridSubHeader">
          {{subHeaderProps.sub_header}}
        </h3>
      </template>
    </sub-header> -->

    <!-- <v-tabs height="40" class="mt-n1 ml-5">
      <v-tabs-slider color="#111111"></v-tabs-slider>
      <v-tab @click="changeContents(tab)" class="tab-name" active-class="black--text" v-for="(tab, index) in tabs"
        :key="index">
        <icon-base v-if="tab === 'ドラマ'" class="ml-n2 mr-2" :iconColor="'#606770'" :width="'14'" :height="'14'" icon-name="icon-tv" :viewBox="'0 0 64 64'"><icon-tv /></icon-base>
        <icon-base v-if="tab === '映画'" class="ml-n2 mr-2" :iconColor="'#606770'" :width="'14'" :height="'14'" icon-name="icon-movie" :viewBox="'0 0 511.81 511.81'"><icon-movie /></icon-base>
        {{tab}}
      </v-tab>
    </v-tabs> -->

    <!-- <v-divider class="ml-6" /> -->

    <!-- <v-row no-gutters class="mt-2 mb-2">
      <v-col lg=1></v-col>
      <v-col lg=5 class="ml-13" style="font-size: 11px; font-weight: bold; color: #606770;">タイトル</v-col>
      <v-col lg=4 class="" style="font-size: 11px; font-weight: bold; color: #606770;">詳細</v-col>
      <v-col lg=1 class="ml-5" style="font-size: 11px; font-weight: bold; color: #606770;">
        フィルタ
        <icon-base icon-name="icon-filter" :width="'7'" :height="'7'" :viewBox="'0 0 451.847 451.847'" :iconColor="'#606770'"><icon-filter /></icon-base>
      </v-col>
    </v-row> -->

    <!-- <v-divider class="ml-5" /> -->

    <base-card class="mt-n3" :items="items" :loading="loading" />
    <base-loader :infiniteId="componentKey" :handler="infiniteHandler" :wrapper="true" :text="loaderText" />
  </v-container>
</template>

<script>
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const spacesRepository = RepositoryFactory.get('spaces');

  export default {
    name: 'Ranking',
    components: {
      'base-banner': () => import( /* webpackPrefetch: true */ '../Base/BaseBanner'),
      'sub-header': () => import( /* webpackPrefetch: true */ '../Layout/TheSubHeader'),
      'base-card': () => import( /* webpackPrefetch: true */ '../Base/BaseCard'),
      'base-loader': () => import( /* webpackPrefetch: true */ '../Base/BaseInfiniteLoader'),
      'icon-base': () => import( /* webpackPrefetch */ '../Icon/IconBase'),
      'icon-tv': () => import( /* webpackPrefetch: true */ '../Icon/IconTv.vue'),
      'icon-movie': () => import( /* webpackPrefetch: true */ '../Icon/IconMovie.vue'),
      'icon-filter': () => import( /* webpackPrefetch: true */ '../Icon/IconFilter.vue'),
    },
    data() {
      return {
        tabs: [
          'ドラマ',
          '映画',
        ],
        loaderText: '現在チャット中のスペースはありません。',
        componentKey: 0,
        page: 1,
        pageSize: 8,
        items: [],
        loading: false,
        switcher: false,
        query_media: 'tv',
        error: '',
        media: {
          tv: 'tv',
          movie: 'mv',
        },
        tv: {
          pathName: 'TvSpace'
        },
        movie: {
          pathName: 'MvSpace'
        },
      }
    },
    watch: {
      switcher: function () {
        this.page = 1
        this.items = []
        if (this.switcher === false) {
          this.query_media = this.media.tv
          this.forceRerender()
        } else if (this.switcher === true) {
          this.query_media = this.media.movie
          this.forceRerender()
        }
      }
    },
    methods: {
      track() {
        this.$gtag.pageview({
          page_path: '/'
        })
      },
      forceRerender() {
        this.componentKey += 1
      },
      infiniteHandler($state) {
        setTimeout(() => {
          spacesRepository.getTrend({
              page: this.page,
              per_page: this.pageSize,
              media: this.query_media
            })
            .then(res => {
              if (res.data.data.length) {
                this.page += 1
                this.items.push(...res.data.data)
                this.loading = true
                $state.loaded()
              } else {
                $state.complete();
              }
            })
        }, 0);
      },
      enterSpace(item) {
        if (item.media === this.media.tv) {
          this.$router.push({
            name: this.tv.pathName,
            params: {
              season_number: item.season,
              episode_number: item.episode,
              name: item.name,
              episode_title: item.episode_title,
              tmdb_tv_id: item.tmdb_tv_id,
              image_path: item.image_path,
              media: item.media,
            }
          })
        } else if (item.media === this.media.movie) {
          this.$router.push({
            name: this.movie.pathName,
            params: {
              image_path: item.image_path,
              tmdb_mv_id: item.tmdb_mv_id,
              name: item.name,
              media: item.media,
            }
          })
        }
      },
      changeContents(tab) {
        if (tab === 'ドラマ') {
          this.switcher = false
        } else if (tab === '映画') {
          this.switcher = true
        }
      }
    },
    computed: {
      gridTv() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'mt-4'
          case 'sm':
          case 'md':
          case 'lg':
          case 'xl':
            return 'mt-4 ml-n3'
        }
      },
      gridMv() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'mt-4'
          case 'sm':
          case 'md':
          case 'lg':
          case 'xl':
            return 'mt-4 ml-n7'
        }
      },
      gridSwitcher() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'mt-n3 mb-5'
          case 'sm':
          case 'md':
          case 'lg':
          case 'xl':
            return 'ml-1'
        }
      },
      gridSubHeader() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'sub-header'
          case 'sm':
          case 'md':
          case 'lg':
          case 'xl':
            return 'sub-header mt-4'
        }
      }
    },
  }
</script>

<style scoped>
  .theme--light.v-divider {
    border-color: rgba(0, 0, 0, 0.082);
  }

  .sub-header {
    font-weight: bold;
    font-size: 20px;
    color: #111111;
  }

  .tab-name {
    font-weight: bold;
    font-size: 14px;
    color: #24292e;
  }
</style>