<template>
  <v-container fluid>
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

    <v-row>
      <v-col lg=3 v-for="(item, index) in items.slice(0,4)" :key="index">
        <v-card @click="enterSpace(item.attributes)" elevation=0 class="rounded-lg">
          <v-img position="under" gradient="to bottom, rgb(81 81 85 / 1%), rgb(0 0 0 / 90%)"
            class="white--text align-end rounded-lg" height="230px" v-if="item.attributes.image_path"
            :src="posterImg(item.attributes.image_path)">
            <v-btn v-if="item.attributes.latest_comment === null" color="#00bbf9" x-small
              class="elevation-0 ml-3 rounded" alt="" style="font-size: 10px; font-weight: bold; color: #ffffff;">
              ピックアップ
            </v-btn>
            <v-card-title v-if="item.attributes.latest_comment" class="mb-n11"
              style="font-weight: bold; line-height: 20px; font-size: 14px;">
              <p class="head-title">{{item.attributes.latest_comment.content}}</p>
            </v-card-title>
            <v-card-title v-else style="font-weight: bold; line-height: 20px; font-size: 18px;">
              <p class="mb-n1">{{item.attributes.name}}</p>
            </v-card-title>
            <v-card-actions v-if="item.attributes.latest_comment" class="mb-n2 ml-n2">
              <v-list-item class="grow">
                <v-list-item-avatar size=22 color="grey darken-3">
                  <v-img class="elevation-6" alt=""
                    :src="item.attributes.latest_comment_user.data.attributes.avatar_url">
                  </v-img>
                </v-list-item-avatar>
                <v-list-item-content>
                  <v-list-item-title style="color: #ffffff; font-size:11px;">
                    {{item.attributes.latest_comment_user.data.attributes.name}}
                  </v-list-item-title>
                </v-list-item-content>
              </v-list-item>
            </v-card-actions>
          </v-img>
        </v-card>
      </v-col>
    </v-row>

    <sub-header class="ml-n2 mt-n3">
      <template v-slot:home_header="subHeaderProps">
        <h2 :class="gridSubHeader">
          {{subHeaderProps.sub_header}}
        </h2>
      </template>
    </sub-header>

    <base-card class="mt-n3 ml-n9" :items="items.slice(4)" :loading="loading" />
    <base-loader :infiniteId="componentKey" :handler="infiniteHandler" :wrapper="true" :text="loaderText" />
  </v-container>
</template>

<script>
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const spacesRepository = RepositoryFactory.get('spaces');

  export default {
    name: 'Home',
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
        base_img_url: `https://image.tmdb.org/t/p/w500`,
        componentKey: 0,
        page: 1,
        pageSize: 7,
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
      },
      posterImg(path) {
        return this.base_img_url + path
      },
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
    font-size: 24px;
    color: #111111;
  }

  .tab-name {
    font-weight: bold;
    font-size: 14px;
    color: #24292e;
  }

  .head-title {
    overflow: hidden;
    position: relative;
    line-height: 1.2em;
    max-height: 4.7em;
    text-align: justify;
    margin-right: -1em;
    padding-right: 1em;
  }

  .head-title:before {
    content: '...';
    position: absolute;
    right: 0;
    bottom: 0;
  }

  .head-title:after {
    content: '';
    position: absolute;
    right: 0;
    width: 1em;
    height: 1em;
    margin-top: 0.2em;
  }
</style>