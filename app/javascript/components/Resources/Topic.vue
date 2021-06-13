<template>
  <v-container fluid :key="componentKey" class="ml-2">
    <!-- <base-banner class="ml-14" /> -->
    <sub-header class="ml-2 mt-n3">
      <template v-slot:popular_header="subHeaderProps">
        <h3 :class="gridSubHeader">
          {{subHeaderProps.sub_header}}
        </h3>
      </template>
    </sub-header>
    <!-- <v-row :class="gridSwitcher">
      <v-col :class="gridTv" cols=3 sm=2 md=2 lg=2 xl=1>
        <h3 :style="switcher === false ? switchBtn.active : switchBtn.inactive">
          <span v-if="switcher === false"></span>ドラマ
        </h3>
      </v-col>
      <v-col :class="gridMv" cols=2 sm=2 md=1 lg=1 xl=1>
        <h3 :style="switcher === true ? switchBtn.active : switchBtn.inactive">
          <span v-if="switcher === true"></span>映画
        </h3>
      </v-col>
      <v-col cols=6 sm=7 md=8 lg=7 xl=9 />
      <v-col class='ml-10' v-if="$vuetify.breakpoint.name != 'xs'" cols=1 sm=1 md=1 lg=1 xl=1>
        <v-switch v-model="switcher" color='blue' dense inset />
      </v-col>
    </v-row> -->
     <v-tabs height="40" class="mt-n1 ml-5" background-color='#ffffff'>
       <v-tabs-slider color="#000000"></v-tabs-slider>
      <v-tab class="tab-name" active-class="black--text" color="#000000"
        v-for="(tablist, index) in tabs" :key="index">
        {{tablist}}
      </v-tab>
    </v-tabs>
    <v-divider class="ml-6" />
    <base-card class="mt-n3" :items="items" :loading="loading" />
    <base-loader :handler="infiniteHandler" :wrapper="true" :text="loaderText" />
  </v-container>
</template>

<script>
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const spacesRepository = RepositoryFactory.get('spaces');

  export default {
    name: 'Topic',
    components: {
      'base-banner': () => import( /* webpackPrefetch: true */ '../Base/BaseBanner'),
      'sub-header': () => import( /* webpackPrefetch: true */ '../Layout/TheSubHeader'),
      'base-card': () => import( /* webpackPrefetch: true */ '../Base/BaseCard'),
      'base-loader': () => import( /* webpackPrefetch: true */ '../Base/BaseInfiniteLoader'),
    },
    data() {
      return {
        tabs: [
          '映画',
          'ドラマ'

        ],
        loaderText: '現在チャット中のスペースはありません。',
        items: [],
        loading: false,
        switcher: false,
        page: 1,
        pageSize: 10,
        componentKey: 0,
        query_media: 'tv',
        error: '',
        media: {
          tv: 'tv',
          movie: 'mv',
        },
        tv: {
          header: 'テレビ',
          pathName: 'TvSpace'
        },
        movie: {
          header: '映画',
          pathName: 'MvSpace'
        },
        switchBtn: {
          active: {
            fontSize: '13px',
            fontWeight: 'bold',
            color: '#000000',
            letterSpacing: '1px'
          },
          inactive: {
            fontSize: '13px',
            fontWeight: 'bold',
            color: '#657786',
            letterSpacing: '1px'
          }
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
    }
  }
</script>

<style scoped>
  .theme--light.v-divider {
    border-color: rgba(0, 0, 0, 0.082);
  }

  .sub-header {
    font-weight: bold;
    font-size: 15px;
    color: #111111;
  }
  .tab-name {
    font-weight: bold;
    font-size: 14px;
    color: #24292e;
    /* height: 53px; */
  }
</style>