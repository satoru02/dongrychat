<template>
  <v-container :key="componentKey" class="mt-n4">
    <v-row dense class="">
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 :class="$vuetify.breakpoint.width > 600 ? 'mt-4' : 'mt-1'">
        <div :style="switcher === false ? switchBtn.active : switchBtn.inactive" v-text="tv.header" />
      </v-col>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 :class="$vuetify.breakpoint.width > 600 ? 'mt-4' : 'mt-1'">
        <div :style="switcher === true ? switchBtn.active : switchBtn.inactive" v-text="movie.header" />
      </v-col>
      <v-col cols=8 sm=9 md=9 lg=9 xl=9 />
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 :class="$vuetify.breakpoint.width > 600 ? '' : 'mt-n3 ml-4'">
        <v-switch v-model="switcher" color="blue" dense inset />
      </v-col>
    </v-row>
    <v-hover v-slot="{ hover }" v-for="(item, index) in items" :key="index">
      <v-card outlined class="rounded-lg mb-3" @click="enterSpace(item.attributes)"
        :style="card.unhoverStyle" :elevation='hover ? 3 : 0' height="110px">
        <v-row class="mt-1">
          <v-col cols=1 sm=1 md=1 lg=1 xl=1
          :class="$vuetify.breakpoint.width > 600 ? 'ml-4 mt-8' : 'mt-8 ml-3 mr-4'" :style="ranking.style">
            {{index + 1}}
          </v-col>
          <v-col cols=1 sm=1 md=1 lg=1 xl=1
          :class="$vuetify.breakpoint.width > 600 ? 'ml-n8' : 'ml-n10'">
            <v-avatar :class="avatar.round" :size="avatar.size" :height="avatar.height" tile>
              <v-img :src="base_tmdb_img_url + item.attributes.image_path" />
            </v-avatar>
          </v-col>
          <v-col cols=10 sm=10 md=10 lg=10 xl=10 class="ml-3">
            <v-row dense>
              <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
              <v-col cols=10 sm=10 md=10 lg=10 xl=10
              :class="$vuetify.breakpoint.width > 600 ? 'ml-n6 mt-1' : 'ml-4 mt-1'"
              :style="label.style">
                <base-label class="ml-1 mr-3" :x_small="true" :outlined="false" :label="true"
                  v-if="item.attributes.media === media.tv" :color="'#016aff'" :text-color="'#ffffff'"
                  :season="item.attributes.season" :episode="item.attributes.episode"
                  :title="item.attributes.episode_title" />
              </v-col>
            </v-row>
            <v-row>
              <v-col cols=9 sm=10 md=10 lg=10 xl=10 />
              <v-col cols=1 sm=1 md=1 lg=1 xl=1 class="ml-9 mt-n1">
                <v-badge color="#02e98d" dot />
              </v-col>
              <v-col cols=1 sm=1 md=1 lg=1 xl=1 :class="$vuetify.breakpoint.width > 600 ? 'mt-n4 ml-n9' : 'mt-n4 ml-n4'"
                 :style="userCount.style" v-text="item.attributes.users.length" />
            </v-row>
            <v-row class='mt-n11'>
              <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
              <v-col cols=9 sm=10 md=10 lg=10 xl=10 :class="$vuetify.breakpoint.width > 600 ? 'ml-n5' : 'ml-5'" :style="listItemTitle.style" v-text="item.attributes.name" />
            </v-row>
            <v-row
            :class="$vuetify.breakpoint.width > 600 ? 'mt-n4 ml-4' : 'mt-n4 ml-10'">
              <v-col cols=12 sm=12 md=12 lg=12 xl=12 :style="tags.style">
                <v-chip label
                :class="$vuetify.breakpoint.width > 600 ? 'mr-2' : 'mr-2'" :style="tags.style" v-for="(tag, index) in item.attributes.tag_list.slice(0, 2)" :key="index"
                  color="#f6f6f9" v-text="'#' + tag" x-small />
              </v-col>
            </v-row>
          </v-col>
        </v-row>
      </v-card>
    </v-hover>
    <base-loader :handler="infiniteHandler" :wrapper="true" :text="loaderText" />
    <v-dialog v-model="loginDialog" width="400" transition="dialog-top-transition">
      <v-card color="#161b22" height="250" class="rounded-lg">
        <v-row>
          <v-col cols=3 sm=3 md=3 lg=3 xl=3 />
          <v-col cols=7 sm=7 md=7 lg=7 xl=7>
            <div class="mt-9 ml-6" :style="dialog.headerStyle" v-text="'Devioを使ってみる'" />
          </v-col>
        </v-row>
        <v-row>
          <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          <v-col cols=10 sm=10 md=10 lg=10 xl=10>
            <v-btn @click="goLogin()" block　:style="dialog.btnStyle" color="blue" outlined elevation=0
              v-text="'ログイン'" />
          </v-col>
        </v-row>
        <v-row>
          <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          <v-col cols=10 sm=10 md=10 lg=10 xl=10>
            <v-btn block @click="goSignup()" :style="dialog.btnStyle" color="blue" elevation=0 v-text="'アカウント作成'" />
          </v-col>
        </v-row>
        <v-row>
          <v-col cols=3 sm=3 md=3 lg=3 xl=3 />
          <v-col cols=9 sm=9 md=9 lg=9 xl=9>
            <div class="ml-1" :style="dialog.policyStyle" v-text="'利用規約とプライバシーポリシーはこちら'" />
          </v-col>
        </v-row>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios';
  import BaseLabel from '../Base/BaseLabel';
  import BaseInfiniteLoader from '../Base/BaseInfiniteLoader';

  export default {
    name: 'ChartTop',
    components: {
      'base-label': BaseLabel,
      'base-loader': BaseInfiniteLoader
    },
    data() {
      return {
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w500`,
        trend_endpoint: `/api/v1/spaces/trend`,
        loaderText: '現在チャット中のスペースはありません。',
        items: [],
        switcher: false,
        loginDialog: false,
        page: 1,
        pageSize: 10,
        componentKey: 0,
        query_media: 'tv',
        error: '',
        avatar: {
          size: 80,
          height: 77,
          round: "rounded-lg"
        },
        icon: {
          size: 22,
          mdi: 'mdi-menu-up'
        },
        media: {
          tv: 'tv',
          movie: 'mv',
        },
        tv: {
          header: 'TV',
          pathName: 'TvSpace'
        },
        movie: {
          header: 'MOVIE',
          pathName: 'MvSpace'
        },
        card: {
          hoverStyle: {
            backgroundColor: '#1a212d'
          },
          unhoverStyle: {
            backgroundColor: '#ffffff'
          }
        },
        switchBtn: {
          active: {
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '18px',
            fontWeight: 'bold',
            color: '#000000',
            letterSpacing: '3px'
          },
          inactive: {
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '18px',
            fontWeight: 'bold',
            color: '#6c757d',
            letterSpacing: '3px'
          }
        },
        ranking: {
          style: {
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '12px',
            fontWeight: 'bold',
            color: '#6c757d',
          }
        },
        label: {
          style: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '15px',
            color: '#ced4da'
          }
        },
        userCount: {
          style: {
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '13px',
            fontWeight: 'bold',
            color: '#6c757d'
          }
        },
        listItemTitle: {
          style: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '16px',
            color: '#111111'
          }
        },
        tags: {
          style: {
            color: '#666666',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '6px'
          }
        },
        dialog: {
          headerStyle: {
            color: '#ced4da',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '17px',
          },
          btnStyle: {
            color: '#ffffff',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '12px',
          },
          policyStyle: {
            color: '#6c757d',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '4px',
          }
        }
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
          secureAxios.get(this.trend_endpoint, {
              params: {
                page: this.page,
                per_page: this.pageSize,
                media: this.query_media
              }
            })
            .then(res => {
              if (res.data.data.length) {
                this.page += 1,
                  this.items.push(...res.data.data)
                $state.loaded()
              } else {
                $state.complete();
              }
            })
        }, 100);
      },
      enterSpace(item) {
        if (this.$store.state.signedIn) {
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
        } else {
          this.loginDialog = true
        }
      },
      goLogin() {
        this.$router.replace('/login')
      },
      goSignup() {
        this.$router.replace('/signup')
      }
    }
  }
</script>

<style scoped>
  .theme--light.v-divider {
    border-color: rgba(0, 1, 1, .06);
  }
  .theme--light.v-sheet--outlined {
    border: thin solid rgba(0,0,0, .05);
}
</style>