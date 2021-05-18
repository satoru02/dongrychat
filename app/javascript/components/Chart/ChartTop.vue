<template>
  <v-container :key="componentKey">
    <!-- <v-row class="mt-n4">
      <v-col lg=12>
       <v-img class="rounded-lg" elevation="0" height="113" width="685" src="https://picsum.photos/510/300?random"></v-img>
      </v-col>
    </v-row> -->
    <sub-header class="mb-n9 mt-1">
      <template v-slot:popular_header="subHeaderProps">
        <h3 :style="headerPart">{{subHeaderProps.sub_header}}</h3>
      </template>
    </sub-header>
    <v-divider class="mt-5" />
    <v-row dense class="mt-n2">
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 :class="$vuetify.breakpoint.width > 600 ? 'mt-4' : 'mt-1'">
        <div :style="switcher === false ? switchBtn.active : switchBtn.inactive" v-text="tv.header" />
      </v-col>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 :class="$vuetify.breakpoint.width > 600 ? 'mt-4 ml-4' : 'mt-1'">
        <div :style="switcher === true ? switchBtn.active : switchBtn.inactive" v-text="movie.header" />
      </v-col>
      <v-col cols=8 sm=9 md=9 lg=9 xl=9 />
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 :class="$vuetify.breakpoint.width > 600 ? 'ml-n4' : 'mt-n3 ml-4'">
        <v-switch v-model="switcher" color="blue" dense inset />
      </v-col>
    </v-row>
    <v-hover v-slot="{ hover }" v-for="(item, index) in items" :key="index">
      <v-card outlined class="rounded-lg mb-9 mt-n3" @click="enterSpace(item.attributes)"
        :style="hover ? card.hoverStyle : card.unhoverStyle" :elevation='hover ? 0 : 0' height="200px">
        <v-row class="mt-1">
          <v-col cols=1 sm=1 md=1 lg=1 xl=1 :class="$vuetify.breakpoint.width > 600 ? 'ml-4 mt-8' : 'mt-8 ml-3 mr-4'"
            :style="ranking.style">
            {{index + 1}}
          </v-col>
          <v-col cols=1 sm=1 md=1 lg=1 xl=1 :class="$vuetify.breakpoint.width > 600 ? 'ml-n8' : 'ml-n10'">
            <v-avatar :class="avatar.round" :size="avatar.size" :height="avatar.height" tile>
              <v-img :src="base_tmdb_img_url + item.attributes.image_path" />
            </v-avatar>
          </v-col>
          <v-col cols=10 sm=10 md=10 lg=10 xl=10 class="ml-3">
            <v-row dense>
              <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
              <v-col cols=10 sm=10 md=10 lg=9 xl=10 :class="$vuetify.breakpoint.width > 600 ? 'ml-n6' : 'ml-4 mt-1'"
                :style="label.style">
                <base-label class="ml-1 mr-3" :x_small="true" :outlined="false" :label="true"
                  v-if="item.attributes.media === media.tv" :color="'#016aff'" :text-color="'#ffffff'"
                  :season="item.attributes.season" :episode="item.attributes.episode"
                  :title="item.attributes.episode_title" />
                <v-chip v-if="item.attributes.media === media.movie" x-small label :color="'yellow'" :style="vchipStyle"
                  v-text="'Movie'" />
              </v-col>
            </v-row>
            <v-row class=mt-5>
              <v-col cols=9 sm=10 md=10 lg=10 xl=10 />
              <v-col cols=1 sm=1 md=1 lg=1 xl=1 class="ml-8 mt-n1">
                <v-badge color="#02e98d" dot />
              </v-col>
              <v-col cols=1 sm=1 md=1 lg=1 xl=1 :class="$vuetify.breakpoint.width > 600 ? 'mt-n4 ml-n8' : 'mt-n4 ml-n4'"
                :style="userCount.style" v-text="item.attributes.users.length" />
            </v-row>
            <v-row class='mt-n12'>
              <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
              <v-col cols=9 sm=10 md=10 lg=8 xl=10 :class="$vuetify.breakpoint.width > 600 ? 'ml-n5' : 'ml-5'"
                :style="listItemTitle.style" v-text="item.attributes.name" />
              <!-- <v-col lg=3>
                <v-avatar size="21">
                  <v-img src="https://cdn.vuetifyjs.com/images/john.jpg" />
                </v-avatar>
                <v-avatar size="21" class="ml-n2">
                  <v-img src="https://avatars0.githubusercontent.com/u/9064066?v=4&s=460" />
                </v-avatar>
                <v-avatar size="21" class="ml-n2" color="red">
                  <v-img src="https://cdn.vuetifyjs.com/images/john.jpg" />
                </v-avatar>
                <v-avatar size="21" class="ml-n2" color="green">
                  <v-img src="https://avatars0.githubusercontent.com/u/9064066?v=4&s=460" />
                </v-avatar>
              </v-col> -->
            </v-row>
            <v-row :class="$vuetify.breakpoint.width > 600 ? 'mt-n3 ml-4' : 'mt-n4 ml-10'">
              <v-col cols=12 sm=12 md=12 lg=7 xl=12 :style="tags.style">
                <v-chip label :class="$vuetify.breakpoint.width > 600 ? 'mr-2' : 'mr-2'" :style="tags.style"
                  v-for="(tag, index) in item.attributes.tag_list.slice(0, 2)" :key="index" color="#e9ecef"
                  v-text="'#' + tag" x-small />
              </v-col>
              <v-col lg=1></v-col>
              <v-col lg=4 class="mt-n1 ml-n5">
                <v-icon color="#5d666e" size=13>
                  mdi-comment-outline
                </v-icon>
                <span :style="numberStyle">123</span>
                <v-icon color="#5d666e" size=13 class="ml-2">
                  mdi-note-outline
                </v-icon>
                <span :style="numberStyle">63</span>
                <v-icon color="#5d666e" size=13 class="ml-2">
                  mdi-television-classic
                </v-icon>
                <span :style="numberStyle">11</span>
              </v-col>
              <!-- <v-col lg=2 class="mt-n1 ml-n10">
                <v-icon color="#6c757d" size=13>
                  mdi-note-outline
                </v-icon>
                <span :style="numberStyle"> 13</span>
              </v-col> -->
            </v-row>
          </v-col>
        </v-row>
        <v-divider class="mt-3 mr-11 ml-11" />
        <v-row class="mt-2" dense>
          <v-col lg=1 class="ml-11 mt-n1">
            <v-avatar size="24">
              <v-img src="https://cdn.vuetifyjs.com/images/john.jpg" />
            </v-avatar>
          </v-col>
          <v-col lg=10 :style="nameStyle" class="ml-n7">
            ボニ語ろう <span :style="timeStyle">2日前</span>
          </v-col>
          <v-col lg=1></v-col>
        </v-row>
        <v-row dense class=mt-n3>
          <v-col lg=1>
          </v-col>
          <v-col lg=10 :style="wordStyle" class="ml-2">
            『劇場版「鬼滅の刃」無限列車編』のBlu-ray＆DVD発売を記念したカウントダウン。日まで紡がれる全38日 発売当日まで紡がれる全38日発売当日まで紡がれる全38日間。...
          </v-col>
          <v-col lg=1></v-col>
        </v-row>
      </v-card>
    </v-hover>
    <base-loader :handler="infiniteHandler" :wrapper="true" :text="loaderText" />
    <v-dialog v-model="loginDialog" width="400" transition="dialog-top-transition">
      <v-card color="#ffffff" height="250" class="rounded-lg">
        <v-row>
          <v-col cols=3 sm=3 md=3 lg=3 xl=3 />
          <v-col cols=7 sm=7 md=7 lg=7 xl=7>
            <div class="mt-9 ml-6" :style="dialog.headerStyle" v-text="'Devioを使ってみる'" />
          </v-col>
        </v-row>
        <v-row>
          <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          <v-col cols=10 sm=10 md=10 lg=10 xl=10>
            <v-btn @click="goLogin()" block　:style="dialog.btnStyle" color="black" outlined elevation=0
              v-text="'ログイン'" />
          </v-col>
        </v-row>
        <v-row>
          <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          <v-col cols=10 sm=10 md=10 lg=10 xl=10>
            <v-btn block @click="goSignup()" :style="dialog.btnStyle" color="#016aff" elevation=0 v-text="'アカウント作成'" />
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
  import TheSubHeader from '../Layout/TheSubHeader';

  export default {
    name: 'ChartTop',
    components: {
      'base-label': BaseLabel,
      'base-loader': BaseInfiniteLoader,
      'sub-header': TheSubHeader
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
          height: 83,
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
          header: 'テレビ',
          pathName: 'TvSpace'
        },
        movie: {
          header: '映画',
          pathName: 'MvSpace'
        },
        card: {
          hoverStyle: {
            backgroundColor: '#edf2f4'
          },
          unhoverStyle: {
            backgroundColor: '#f5f8fa'

          }
        },
        switchBtn: {
          active: {
            fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
            fontSize: '15px',
            fontWeight: 'bold',
            color: '#000000',
            letterSpacing: '1px'
          },
          inactive: {
            fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
            fontSize: '15px',
            fontWeight: 'bold',
            color: '#657786',
            letterSpacing: '1px'
          }
        },
        ranking: {
          style: {
            fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
            fontSize: '12px',
            fontWeight: 'bold',
            color: '#14171a',
          }
        },
        label: {
          style: {
            fontWeight: 'bold',
            fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
            fontSize: '15px',
            color: '#ced4da'
          }
        },
        userCount: {
          style: {
            fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
            fontSize: '13px',
            fontWeight: 'bold',
            color: '#6c757d'
          }
        },
        listItemTitle: {
          style: {
            fontWeight: 'bold',
            fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
            fontSize: '17px',
            color: '#000000'
          }
        },
        tags: {
          style: {
            color: '#111111',
            // fontWeight: 'bold',
            fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
            fontSize: '5px'
          }
        },
        dialog: {
          headerStyle: {
            color: '#111111',
            fontWeight: 'bold',
            fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
            fontSize: '17px',
          },
          btnStyle: {
            color: '#ffffff',
            fontWeight: 'bold',
            fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
            fontSize: '12px',
          },
          policyStyle: {
            color: '#6c757d',
            fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
            fontSize: '4px',
          }
        },
        wordStyle: {
          color: '#011627',
          fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
          fontSize: '12px',
          lineHeight: '20px',
          // fontWeight: 'bold',
        },
        nameStyle: {
          fontWeight: 'bold',
          color: '#011627',
          fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
          fontSize: '11px',
        },
        timeStyle: {
          fontWeight: 'bold',
          color: '#6c757d',
          fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
          fontSize: '8px',
        },
        vchipStyle: {
          fontWeight: 'bold',
          fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
          fontSize: '11px',
        },
        numberStyle: {
          // fontWeight: 'bold',
          fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
          fontSize: '11px',
          color: '#5d666e'
        },
        headerPart: {
          fontWeight: 'bold',
          fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
          fontSize: '19px',
          color: '#111111'
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
  .v-divider {
    border-color: rgba(226, 226, 226, 0.384);
  }

  .v-input__slot::before {
    border-style: none !important;
    color: #f3f6f7;
    /* color: #98989b */
  }

  .theme--light.v-sheet--outlined {
    border: thin solid rgba(206, 206, 206, 0.12);
  }
</style>