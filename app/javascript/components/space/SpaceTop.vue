<template>
  <v-container>
    <!-- <v-row>
      <v-col lg=3>
        <v-sheet height=700 outlined class="rounded-lg">
          <v-row>
            <v-col lg=12 class="mt-5 ml-5">
              <v-avatar class="rounded-lg" size="80" height='130'>
                <v-img :src="`https://image.tmdb.org/t/p/w500`+ this.space_data.image_path" />
              </v-avatar>
            </v-col>
          </v-row>
        </v-sheet>
      </v-col>
    </v-row> -->

    <space-header :space_data="this.space_data" />
    <v-tabs hide-slider class="mt-2" v-if="space_data" :background-color='vTabs.backgroundColor' :height="vTabs.height" grow>
      <v-tab
       :active-class="vTab.activeText" @click="changeTab(tablist.path)" :style="vTab.style"
        v-for="(tablist, index) in tablists" :key="index">
        {{tablist.title}}
        <v-chip v-if="$vuetify.breakpoint.width > 600" class="ml-3 rounded-xl" :style="vChip.style" :text-color="vChip.textColor" :elevation="vChip.elevation"
          :color="vChip.color" x-small v-text="setCount(tablist.title)" />
      </v-tab>
    </v-tabs>
    <v-divider />
    <router-view v-if="this.space_data" :spaceId="this.space_data.id" :users="this.space_data.users.data" />
  </v-container>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios';
  import SpaceHeader from './SpaceHeader';

  export default {
    name: 'SpaceTop',
    components: {
      'space-header': SpaceHeader,
    },
    data() {
      return {
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w200`,
        params: {},
        space_data: '',
        endpoint: '',
        media: {
          tv: 'tv',
          mv: 'mv',
        },
        api: {
          from_search: `/api/v1/spaces/enter`,
          from_subscription: `/api/v1/spaces/enter_from_subscription`,
          for_subscription: `/api/v1/subscriptions`
        },
        space: {
          tv: {
            subscribed: 'subscribedTvSpace',
            unsubscribed: 'TvSpace'
          },
          movie: {
            subscribed: 'subscribedMvSpace',
            unsubscribed: 'MvSpace'
          }
        },
        tablists: [{
            title: 'チャット',
            path: 'chats'
          },
          {
            title: 'レビュー',
            path: 'reviews'
          },
          {
            title: 'シェアウォッチ',
            path: 'news'
          },
          {
            title: 'ユーザー',
            path: 'members'
          },
        ],
        vSheet: {
          height: '740',
          style: {
            backgroundColor: '#f6f6f9'
          }
        },
        vTabs: {
          backgroundColor: '#ffffff',
          height: '40'
        },
        vTab: {
          activeText: 'black--text',
          style: {
            fontWeight: 'bold',
            fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
            fontSize: '12px',
            color: '#666666'
          }
        },
        vChip: {
          textColor: '#666666',
          elevation: 0,
          color: '#f6f6f9',
          style: {
            fontWeight: 'bold',
            fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
            fontSize: '10px',
          }
        }
      }
    },
    created() {
      switch (this.$route.name) {
        case 'subscribedTvSpace': {
          this.endpoint = this.api.from_subscription
          this.params = {
            space_id: this.$route.params.space_id,
            media: this.media.tv
          }
        }
        break;
      case 'subscribedMvSpace': {
        this.endpoint = this.api.from_subscription
        this.params = {
          space_id: this.$route.params.space_id,
          media: this.media.mv
        }
      }
      break;
      case 'TvSpace': {
        this.endpoint = this.api.from_search
        this.params = {
          name: this.$route.params.name,
          season: this.$route.params.season_number,
          episode: this.$route.params.episode_number,
          media: this.media.tv,
          episode_title: this.$route.params.episode_title,
          tmdb_comp_id: this.$route.params.tmdb_comp_id,
          tmdb_tv_id: this.$route.params.tmdb_tv_id,
          image_path: this.$route.params.image_path,
          overview: this.$route.params.overview,
          tag_list: this.$route.params.tag_list,
        }
      }
      break;
      case 'MvSpace': {
        this.endpoint = this.api.from_search
        this.params = {
          name: this.$route.params.name,
          media: this.media.mv,
          image_path: this.$route.params.image_path,
          tmdb_mv_id: this.$route.params.tmdb_mv_id,
          overview: this.$route.params.overview,
          tag_list: this.$route.params.tag_list
        }
      }
      break;
      default: {
        this.$router.replace('/')
      }
      }
      this.setSpace()
    },
    watch: {
      $route: 'setSpace'
    },
    beforeRouteEnter(to, from, next) {
      next(vm => {
        setTimeout(() => {
          document.title = `${vm.space_data.name} - Devio` || 'Devio';
        }, 1000)
      })
    },
    beforeRouteUpdate(to, from, next) {
      document.title = `${this.space_data.name} - Devio` || 'Devio';
      next()
    },
    methods: {
      track() {
        this.$gtag.pageview({
          page_path: '/tv_space/:space_id',
        })
      },
      setSpace() {
        secureAxios.get(this.endpoint, {
            params: this.params
          })
          .then(res => this.successful(res))
          .catch(err => this.failed(err))
      },
      successful(res) {
        this.space_data = res.data.data.attributes
      },
      failed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ''
      },
      setCount(tabListName) {
        switch (tabListName) {
          case 'チャット':
            return this.space_data.comments_count;
          case 'ユーザー':
            return this.space_data.users.data.length;
          case 'レビュー':
            return 0;
          case 'シェアウォッチ':
            return 0;
          default:
            return 0;
        }
      },
      changeTab(tabListPath) {
        this.$router.push(({
          path: tabListPath
        })).catch(() => {});
      }
    },
    computed: {
      vContainerGrid() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-16 mt-n9'
          case 'sm':
            return 'mt-7'
          case 'md':
            return 'mt-7'
          case 'lg':
            return 'mt-n9'
          case 'xl':
            return 'mt-n9'
        }
      }
    }
  }
</script>

<style scoped>
  .theme--light.v-divider {
    border-color: rgba(94, 94, 94, 0.06);
  }

  .v-input__slot::before {
    border-style: none !important;
  }
</style>