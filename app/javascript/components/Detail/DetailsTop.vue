<template>
  <v-container class="mt-n12">
    <v-row :class="heading_part.position">
      <v-col md=4 lg=2 xl=4 :class="heading_part.avatar.position">
        <v-avatar tile :size="heading_part.avatar.size" :height="heading_part.avatar.height" class="rounded-lg">
          <v-img :src="base_tmdb_img_url + details.poster_path" />
        </v-avatar>
      </v-col>
      <v-col md=7 lg=9 xl=7>
        <v-row>
          <v-col md=12 lg=9 xl=12 :class="heading_part.title.position" :style="heading_part.title.style">
            <h3 v-if="media === 'tv'" v-text="this.$route.params.tv_name + '（2021）'" />
            <h3 v-else v-text="this.$route.params.mv_name" />
          </v-col>
          <v-col lg=2>
          </v-col>
        </v-row>
        <v-row dense class="mt-n6">
          <v-col md=12 lg=12 xl=12 :style="heading_part.subTitle.style" :class="heading_part.subTitle.position">
            <h3 v-if="media === 'tv'" v-text="'@' + this.$route.params.tv_name" />
            <h3 v-else v-text="'@' + this.$route.params.mv_name" />
          </v-col>
        </v-row>
        <v-row>
          <v-col md=10 lg=12 xl=10 :class="heading_part.details.position">
            <div :style="heading_part.details.style" v-text="details.overview" />
          </v-col>
        </v-row>
        <v-row class="mt-2">
          　<v-col lg=2 :style="heading_part.personHeader.style" :class="heading_part.person.position">
            　 監督
            　</v-col>
          　<v-col lg=7 :style="heading_part.person.style" class="ml-n11">
            　 大畑勇
            　</v-col>
        </v-row>
        <v-row class="mt-n3">
          　<v-col lg=2 :style="heading_part.personHeader.style" :class="heading_part.person.position">
            　 出演者
            　</v-col>
          　<v-col lg=2 :style="heading_part.person.style" class="ml-n11">
            　 崎山ひろゆき
            　</v-col>
          <v-col lg=2 :style="heading_part.person.style" class="ml-n10">
            　 　のどか夢
            　</v-col>
          <v-col lg=2 :style="heading_part.person.style" class="ml-n10">
            　 田和村ごえ
            　</v-col>
        </v-row>
        <v-row class="mt-n8">
          　<v-col lg=2 :style="heading_part.personHeader.style" :class="heading_part.person.position">
            　 ジャンル
            　</v-col>
          　<v-col lg=7 :style="heading_part.person.style" class="ml-n11">
            　 アクション
            　</v-col>
        </v-row>
      </v-col>
    </v-row>

    <v-tabs v-if="media === 'tv'" :style="tabs.style" :class="tabs.grid" :height="tabs.height" :width="tabs.width"
      :color="tabs.color">
      <v-tab :style="tab.style">
        シーズン1
      </v-tab>
      <v-tab :style="tab.style">
        シーズン2
      </v-tab>
      <v-tab :style="tab.style">
        シーズン3
      </v-tab>
      <v-tab :style="tab.style">
        シーズン4
      </v-tab>
      <v-tab :style="tab.style">
        　シーズン5
      </v-tab>
    </v-tabs>
    <v-divider class="ml-n2" v-if="media === 'tv'" />

    <v-row v-if="media === 'tv'">
      <v-col md=12 lg=12 xl=12 :class="list_part.position">
        <v-list>
          <v-list-item-group :active-class="list_part.active">
            <template v-for="(episode, index) in details.episodes">
              <v-list-item :key="index" @click="enterTvSpace(episode)">
                <template v-slot:default="{}">
                  <!-- <div :class="list_part.ranking.position" :style="list_part.ranking.style" v-text="index + 1" /> -->
                  <v-list-item-avatar :size="list_part.avatar.size" :height="list_part.avatar.height" tile
                    :class="list_part.avatar.round">
                    <v-img :src="base_tmdb_img_url + episode.still_path" />
                  </v-list-item-avatar>
                  <v-list-item-content :class='list_part.title.position'>
                    <v-list-item-title :style="details_title">
                      #{{index + 1}} {{episode.name}}
                      <!-- <v-btn icon class="ml-3" color="#000000" style="background-color: yellow;" x-small elevation=0>1</v-btn> -->
                      <!-- <v-chip color="yellow" :style="chip" class="ml-3" small>
                        1
                     </v-chip> -->
                    </v-list-item-title>
                    <v-list-item-subtitle :style="overviewStyle" class="mt-1">
                      {{episode.overview}}
                    </v-list-item-subtitle>
                  </v-list-item-content>
                  <v-list-item-action>
                  </v-list-item-action>
                </template>
              </v-list-item>
            </template>
          </v-list-item-group>
        </v-list>
      </v-col>
    </v-row>

    <v-row v-else>
      <v-col md=12 lg=12 xl=12 :class="list_part.position">
        <v-list>
          <v-list-item-group :active-class="list_part.active">
            <template>
              <v-list-item @click="enterMovieSpace(details)">
                <template v-slot:default="{}">
                  <!-- <div :class="list_part.ranking.position" :style="list_part.ranking.style" v-text="1" /> -->
                  <v-list-item-avatar :size="list_part.avatar.size" :height="list_part.avatar.height" tile
                    :class="list_part.avatar.round">
                    <v-img :src="base_tmdb_img_url + details.backdrop_path" />
                  </v-list-item-avatar>
                  <v-list-item-content :class='list_part.title.position'>
                    <v-list-item-title v-text="details.title" :style="details_title" />
                    <v-list-item-subtitle :style="overviewStyle" class="mt-1">
                      {{details.overview}}
                    </v-list-item-subtitle>
                  </v-list-item-content>
                  <v-list-item-action>
                  </v-list-item-action>
                </template>
              </v-list-item>
            </template>
          </v-list-item-group>
        </v-list>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
  import {
    tmdbAxios
  } from '../../backend/axios';
  import BaseContentSheet from '../Base/BaseContentSheet';
  export default {
    name: 'DetailsTop',
    components: {
      'base-content-sheet': BaseContentSheet
    },
    data() {
      return {
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w500`,
        tmdb_tv: `https://api.themoviedb.org/3/tv/${this.$route.params.id}/season/${this.$route.params.number}?api_key=${process.env.TMDB_API_KEY}&language=ja`,
        tmdb_mv: `https://api.themoviedb.org/3/movie/${this.$route.params.id}?api_key=${process.env.TMDB_API_KEY}&language=ja`,
        details: [],
        error: '',
        media: 'tv',
        tv_space: 'TvSpace',
        movie_space: 'MvSpace',
        // for css ----------------------------------------
        heading_part: {
          position: 'mt-7 ml-n7',
          avatar: {
            position: 'ml-4 mt-3',
            size: '165',
            height: '235',
          },
          title: {
            position: 'mt-4 ml-4',
            style: {
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue sans-serif',
              fontSize: '16px'
            }
          },
          subTitle: {
            position: 'mt-2 ml-4',
            style: {
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue sans-serif',
              fontSize: '10px',
              color: '#6c757d',
            }
          },
          personHeader: {
            position: 'ml-1',
            style: {
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue sans-serif',
              fontSize: '12px',
              color: '#6c757d',
            }
          },
          person: {
            position: 'ml-1',
            style: {
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue sans-serif',
              fontSize: '12px',
              color: '#000000',
            }
          },
          details: {
            position: 'mt-n2 ml-5',
            style: {
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '12px',
              fontWeight: 'bold',
              color: '#2d3135',
              height: '70px',
              maxHeight: '90px',
              overflow: 'scroll',
              overflowY: 'scroll',
            }
          },
          btn: {
            style: {
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue sans-serif',
              fontSize: '12px',
              color: '#000000',
            }
          }
        },
        chip: {
          color: '#000000',
          fontWeight: 'bold',
          fontFamily: 'Helvetica Neue, sans-serif',
        },
        list_part: {
          position: 'ml-n2',
          active: 'orange--text',
          ranking: {
            position: 'mr-5',
            style: {
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '12px',
              fontWeight: 'bold',
              color: '#0a0a0a',
            }
          },
          avatar: {
            size: '80',
            height: '80',
            round: 'rounded-lg'
          },
          title: {
            position: 'ml-1 mt-n5'
          }
        },
        details_title: {
          fontFamily: 'Helvetica Neue, sans-serif',
          fontSize: '14px',
          fontWeight: 'bold',
          color: '#0a0a0a',
        },
        overviewStyle: {
          fontFamily: 'Helvetica Neue, sans-serif',
          fontSize: '11px',
          fontWeight: 'bold',
          color: '#6c757d',
        },
        tabs: {
          chat: 'チャット',
          review: 'レビュー',
          members: 'メンバー',
          news: 'ニュース',
          relationship: '関連作',
          grid: 'mt-2 ml-n2',
          height: '48px',
          width: '70px',
          color: '#000000',
          btnGrid: 'ml-1 rounded-xl',
          btnColor: '#e9ecef',
          btnElevation: 0,
          style: {
            color: '#000000',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '13px',
          },
        },
        tab: {
          style: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '11px'
          },
          btn: {
            style: {
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '10px'
            }
          }
        },
        // ----------------------------------------
      }
    },
    created() {
      if (this.$route.name === 'TvDetails') {
        this.media = 'tv'
        this.getTvContents()
      } else if (this.$route.name === 'MvDetails') {
        this.media = 'mv'
        this.getMvContents()
      }
    },
    methods: {
      getTvContents() {
        tmdbAxios.get(this.tmdb_tv)
          .then(res => this.fetchSuccessfull(res))
          .catch(err => this.fetchFailed(err))
      },
      getMvContents() {
        tmdbAxios.get(this.tmdb_mv)
          .then(res => this.fetchSuccessfull(res))
          .catch(err => this.fetchFailed(err))
      },
      fetchSuccessfull(res) {
        this.details = res.data
      },
      fetchFailed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ''
      },
      enterTvSpace(tv_data) {
        this.$router.push({
          name: this.tv_space,
          params: {
            season_number: tv_data.season_number,
            episode_number: tv_data.episode_number,
            name: this.$route.params.tv_name,
            episode_title: tv_data.name,
            tmdb_tv_id: this.details.id,
            image_path: this.details.poster_path,
            media: this.media,
            overview: tv_data.overview
          }
        })
      },
      enterMovieSpace(details) {
        this.$router.push({
          name: this.movie_space,
          params: {
            image_path: details.poster_path,
            tmdb_mv_id: details.id,
            name: this.$route.params.mv_name,
            media: this.media,
            overview: details.overview
          }
        })
      }
    }
  }
</script>

<style scoped>
  .theme--light.v-divider {
    border-color: rgba(0, 1, 1, .06);
  }
</style>