<template>
  <v-container>
    <v-row :class="heading_part.position">
      <v-col md=4 lg=4 xl=4 :class="heading_part.avatar.position">
        <v-avatar tile :size="heading_part.avatar.size" :height="heading_part.avatar.height"
          :width="heading_part.avatar.width">
          <base-content-sheet :height="heading_part.sheet_height" :img="base_tmdb_img_url + details.poster_path" />
        </v-avatar>
      </v-col>
      <v-col md=7 lg=7 xl=7>
        <v-row>
          <v-col md=12 lg=12 xl=12 :class="heading_part.title.position" :style="heading_part.title.style">
            <h3 v-if="media === 'tv'" v-text="this.$route.params.tv_name" />
            <h3 v-else v-text="this.$route.params.mv_name" />
          </v-col>
        </v-row>
        <v-row>
          <v-col md=10 lg=10 xl=10 :class="heading_part.details.position">
            <div :style="heading_part.details.style" v-text="details.overview" />
          </v-col>
        </v-row>
      </v-col>
    </v-row>
    <v-row v-if="media === 'tv'">
      <v-col md=12 lg=12 xl=12 :class="list_part.position">
        <v-list>
          <v-list-item-group :active-class="list_part.active">
            <template v-for="(episode, index) in details.episodes">
              <v-list-item :key="index" @click="enterTvSpace(episode)">
                <template v-slot:default="{}">
                  <div :class="list_part.ranking.position" :style="list_part.ranking.style" v-text="index + 1" />
                  <v-list-item-avatar :size="list_part.avatar.size" :height="list_part.avatar.height" tile
                    :class="list_part.avatar.round">
                    <v-img :src="base_tmdb_img_url + episode.still_path" />
                  </v-list-item-avatar>
                  <v-list-item-content :class='list_part.title.position'>
                    <v-list-item-subtitle v-text="episode.name" :style="details_title" />
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
      <v-col md=12 lg=12 xl=12>
        <v-list>
          <v-list-item-group :active-class="list_part.active">
            <template>
              <v-list-item @click="enterMovieSpace(details)">
                <template v-slot:default="{}">
                  <div :class="list_part.ranking.position" :style="list_part.ranking.style" v-text="1" />
                  <v-list-item-avatar :size="list_part.avatar.size" :height="list_part.avatar.height" tile
                    :class="list_part.avatar.round">
                    <v-img :src="base_tmdb_img_url + details.backdrop_path" />
                  </v-list-item-avatar>
                  <v-list-item-content :class='list_part.title.position'>
                    <v-list-item-subtitle v-text="details.title" :style="details_title" />
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
  import { tmdbAxios } from '../../backend/axios';
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
          position: 'mt-7',
          sheet_height: 330,
          avatar: {
            position: 'ml-4 mt-3',
            size: '40',
            height: '330',
            width: '220'
          },
          title: {
            position: 'mt-3 ml-6',
            style: {
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue sans-serif',
              fontSize: '20px'
            }
          },
          details: {
            position: 'mt-n2 ml-7',
            style: {
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '12px',
              fontWeight: 'bold',
              color: '#2d3135'
            }
          }
        },
        list_part: {
          position: 'mt-n1',
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
            size: '50',
            height: '50',
            round: 'rounded-lg'
          },
          title: {
            position: 'ml-4'
          }
        },
        details_title: {
          fontFamily: 'Helvetica Neue, sans-serif',
          fontSize: '12px',
          fontWeight: 'bold',
          color: '#0a0a0a',
        }
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
          }
        })
      }
    }
  }
</script>

<style scoped>
</style>