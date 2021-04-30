<template>
  <v-container class="mt-n12">
    <v-row :class="heading_part.position">
      <v-col md=4 lg=2 xl=4 :class="heading_part.avatar.position">
        <v-avatar tile :size="heading_part.avatar.size" :height="heading_part.avatar.height" class="rounded-lg">
          <v-img v-if="details.poster_path" :src="base_tmdb_img_url + details.poster_path" />
        </v-avatar>
      </v-col>
      <v-col md=7 lg=9 xl=7>
        <v-row>
          <v-col md=12 lg=9 xl=12 :class="heading_part.title.position" :style="heading_part.title.style">
            <h3 v-if="media === 'tv'" v-text="this.$route.params.tv_name" />
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
        <v-row class="mt-3">
          <v-col lg=2 :style="heading_part.personHeader.style" :class="heading_part.person.position">
            クレジット
          </v-col>
          <v-col lg=3 :style="heading_part.person.style" class="ml-n10" v-for="(credit, index) in overall.created_by" :key="index">
            {{credit.name}}
          </v-col>
        </v-row>
        <v-row class="mt-n1">
          　<v-col lg=2 :style="heading_part.personHeader.style" class="ml-n6 mt-1">
            　 ジャンル
            　</v-col>
          　<v-col lg=8 :style="heading_part.person.style" class="ml-n8">
            　 <v-chip class="mr-4 mb-2" v-for="(genre, index) in this.genres" :key="index" color="#293241"
              :style="heading_part.tag.style" small>
              {{genre}}
            </v-chip>
          </v-col>
        </v-row>
      </v-col>
    </v-row>

    <v-tabs background-color='#0e0e10' v-if="(media === 'tv') && (overall.seasons)" :style="tabs.style" :class="tabs.grid" :height="'40'"
      :width="tabs.width" :color="'blue'">
      <v-tab :active-class="tabActive" @click="changeSeason(index+1)" :style="tab.style" v-for="(season, index) in overall.seasons.length"
        :key="index">
        シーズン{{index + 1}}
      </v-tab>
    </v-tabs>
    <v-divider class="ml-n2" v-if="media === 'tv'" />

    <v-row v-if="media === 'tv'">
      <v-col md=12 lg=12 xl=12 :class="list_part.position">
        <v-list style="background-color: #0e0e10;">
          <v-list-item-group v-for="(episode, index) in details.episodes" :key="index" :active-class="list_part.active">
            <v-hover v-slot="{hover}">
              <v-list-item :class="'rounded-lg'" @click="enterTvSpace(episode)" :style="hover ? 'background-color: #1a212d;' : 'background-color: #0e0e10;'">
                  <v-list-item-avatar :size="list_part.avatar.size" :height="list_part.avatar.height" tile
                    :class="list_part.avatar.round">
                    <v-img :src="base_tmdb_img_url + episode.still_path" />
                  </v-list-item-avatar>
                  <v-list-item-content :class='list_part.title.position'>
                    <v-list-item-title :style="details_title">
                      <span :style="captionStyle" class="mr-2">{{index + 1}}</span> {{episode.name}}
                    </v-list-item-title>
                    <v-list-item-subtitle :style="overviewStyle" class="mt-2">
                      {{episode.overview}}
                    </v-list-item-subtitle>
                  </v-list-item-content>
                  <v-list-item-action>
                  </v-list-item-action>
              </v-list-item>
              </v-hover>
            <v-divider :key="index" />
          </v-list-item-group>
        </v-list>
      </v-col>
    </v-row>

    <v-row v-else>
      <v-col md=12 lg=12 xl=12 :class="list_part.position">
        <v-list style="background-color: #0e0e10;">
          <v-list-item-group :active-class="list_part.active">
            <v-hover v-slot="{hover}">
              <v-list-item :class="'rounded-lg'" :style="hover ? 'background-color: #1a212d;' : 'background-color: #0e0e10;'" @click="enterMovieSpace(details)">
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
              </v-list-item>
            </v-hover>
          </v-list-item-group>
        </v-list>
      </v-col>
    </v-row>

    <v-dialog v-model="loginDialog" width="400" transition="dialog-top-transition">
      <v-card color="#161b22" height="250" class="rounded-lg">
        <v-row>
          <v-col lg=3 />
          <v-col lg=7>
            <div class="mt-9" :style="dialog.headerStyle">DongryChatを使ってみる</div>
          </v-col>
        </v-row>
        <v-row>
          <v-col lg=1 />
          <v-col lg=10>
            <v-btn @click="goLogin()" block　:style="dialog.btnStyle" color="blue" outlined elevation=0 v-text="'ログイン'" />
          </v-col>
        </v-row>
        <v-row>
          <v-col lg=1 />
          <v-col lg=10>
            <v-btn block @click="goSignup()" :style="dialog.btnStyle" color="blue" elevation=0 v-text="'アカウント作成'" />
          </v-col>
        </v-row>
        <v-row>
          <v-col cols=3 sm=3 md=3 lg=3 xl=3 />
          <v-col cols=8 sm=8 md=8 lg=9 xl=8>
            <div class="ml-1" :style="dialog.policyStyle" v-text="'利用規約とプライバシーポリシーはこちら'" />
          </v-col>
        </v-row>
      </v-card>
    </v-dialog>

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
        loginDialog: false,
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w500`,
        tmdb_tv_overall: `https://api.themoviedb.org/3/tv/${this.$route.params.id}?api_key=${process.env.TMDB_API_KEY}&language=ja`,
        tmdb_mv: `https://api.themoviedb.org/3/movie/${this.$route.params.id}?api_key=${process.env.TMDB_API_KEY}&language=ja`,
        details: [],
        overall: [],
        genres: [],
        error: '',
        number: '',
        media: 'tv',
        tv_space: 'TvSpace',
        movie_space: 'MvSpace',
        tabActive: 'white--text',
        captionStyle: {
          fontFamily: 'Helvetica Neue, sans-serif',
          fontSize: '15px',
          fontWeight: 'bold',
          color: '#6c757d'
        },
        heading_part: {
          position: 'mt-7 ml-n7',
          avatar: {
            position: 'ml-4 mt-3',
            size: '165',
            height: '235',
          },
          title: {
            position: 'mt-4 ml-n2',
            style: {
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue sans-serif',
              fontSize: '16px',
              color: '#ced4da'
            }
          },
          subTitle: {
            position: 'mt-2 ml-n2',
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
            position: 'ml-n2',
            style: {
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue sans-serif',
              fontSize: '12px',
              color: '#ced4da',
            }
          },
          details: {
            position: 'mt-n2 ml-n2',
            style: {
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '12px',
              fontWeight: 'bold',
              color: '#ced4da',
              height: '90px',
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
          },
          tag: {
            style: {
              color: '#ffffff',
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '11px'
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
          active: 'black--text',
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
            position: ''
          }
        },
        details_title: {
          fontFamily: 'Helvetica Neue, sans-serif',
          fontSize: '14px',
          fontWeight: 'bold',
          color: '#ffffff',
        },
        overviewStyle: {
          fontFamily: 'Helvetica Neue, sans-serif',
          fontSize: '11px',
          fontWeight: 'bold',
          color: '#b3b3b3',
        },
        tabs: {
          chat: 'チャット',
          review: 'レビュー',
          members: 'メンバー',
          news: 'ニュース',
          relationship: '関連作',
          grid: 'mt-6 ml-n2',
          height: '48px',
          width: '70px',
          color: '#0e0e10',
          btnGrid: 'ml-1 rounded-xl',
          btnColor: '#e9ecef',
          btnElevation: 0,
          style: {
            color: '#0e0e10',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '13px',
          },
        },
        tab: {
          style: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '11px',
            color: '#6c757d'
          },
          btn: {
            style: {
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '10px'
            }
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
    created() {
      if (this.$route.name === 'TvDetails') {
        this.media = 'tv'
        this.getTvContents(this.$route.params.number)
        this.getTvOverall()
      } else if (this.$route.name === 'MvDetails') {
        this.media = 'mv'
        this.getMvContents()
      }
    },
    watch: {
      "$route.params.number"() {
        this.details = []
        this.media = 'tv'
        this.getTvContents(this.$route.params.number)
      }
    },
    beforeRouteEnter(to, from, next){
      next(vm => {
        if(vm.media === 'tv'){
          document.title = `${vm.$route.params.tv_name} - DongryChat` || 'DongryChat';
        } else {
          document.title = `${vm.$route.params.mv_name} - DongryChat` || 'DongryChat';
        }
      })
    },
    beforeRouteUpdate(to, from, next){
        if(this.media === 'tv'){
          document.title = `${this.$route.params.tv_name} - DongryChat` || 'DongryChat';
        } else {
          document.title = `${this.$route.params.mv_name} - DongryChat` || 'DongryChat';
        }
      next()
    },
    methods: {
      getTvContents(number) {
        tmdbAxios.get(
            `https://api.themoviedb.org/3/tv/${this.$route.params.id}/season/${number}?api_key=${process.env.TMDB_API_KEY}&language=ja`
          )
          .then(res => this.setTvDetails(res))
          .catch(err => this.fetchFailed(err))
      },
      getMvContents() {
        tmdbAxios.get(this.tmdb_mv)
          .then(res => this.setMvDetails(res))
          .catch(err => this.fetchFailed(err))
      },
      setTvDetails(res) {
        this.details = res.data
      },
      setMvDetails(res) {
        this.details = res.data
        this.genres = this.setGenres(this.details.genres)
      },
      getTvOverall() {
        tmdbAxios.get(this.tmdb_tv_overall)
          .then(res => this.setOverall(res))
          .catch(err => this.fetchFailed(err))
      },
      setOverall(res) {
        this.overall = res.data
        this.genres = this.setGenres(this.overall.genres)
      },
      setGenres(content_genres) {
        var ary = []
        for (var i = 0; i < content_genres.length; i++) {
          ary.push(content_genres[i].name)
        }
        return ary
      },
      fetchFailed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ''
      },
      changeSeason(number) {
        this.$router.replace({
          name: 'TvDetails',
          params: {
            id: this.$route.params.id,
            number: number,
            tv_name: this.$route.params.tv_name
          }
        })
      },
      enterTvSpace(tv_data) {
        if (!this.$store.state.signedIn) {
          this.loginDialog = true
        } else {
          this.$router.push({
            name: this.tv_space,
            params: {
              season_number: tv_data.season_number,
              episode_number: tv_data.episode_number,
              name: this.$route.params.tv_name,
              episode_title: tv_data.name,
              tmdb_comp_id: this.overall.id,
              tmdb_tv_id: this.details.id,
              image_path: this.details.poster_path,
              media: this.media,
              overview: tv_data.overview,
              tag_list: this.genres,
            }
          })
        }
      },
      enterMovieSpace(details) {
        if (!this.$store.state.signedIn) {
          this.loginDialog = true
        } else {
          this.$router.push({
            name: this.movie_space,
            params: {
              image_path: details.poster_path,
              tmdb_mv_id: details.id,
              name: this.$route.params.mv_name,
              media: this.media,
              overview: details.overview,
              tag_list: this.genres
            }
          })

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
    border-color: rgba(201, 204, 204, 0.06);
  }
</style>