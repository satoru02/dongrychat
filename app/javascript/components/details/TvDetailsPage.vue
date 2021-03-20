<template>
  <div>
    <v-row>
      <v-col cols=5 class="ml-4 mt-3">
        <featured-content />
      </v-col>
      <v-col>
        <v-row>
          <v-col cols=12 class="mt-3 card-title">
            <h3>{{ this.$route.params.tv_name }}</h3>
          </v-col>
        </v-row>
        <v-row>
          <v-col cols=12 class="mt-n4">
            <div style="font-size: 0.7rem;">
              {{ tv_details.overview }}
            </div>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=12 class="mt-n3">
        <v-list two-line>
          <v-list-item-group style="background-color: #ffffff" active-class="orange--text" multiple>
            <template v-for="(episode, index) in tv_details.episodes">
              <v-list-item :key="index" @click="enterSpace(episode)">
                <template v-slot:default="{}">
                  <div class="mr-5 ranktitle">{{index + 1}}</div>
                  <v-list-item-content class=ml-1>
                    <v-list-item-title class="card-title" v-html="episode.title" />
                    <v-list-item-subtitle v-html="episode.name" class="subtitle" />
                  </v-list-item-content>
                  <v-list-item-action>
                    <!-- <div class="subtitle">{{item.count}}人が会話中</div> -->
                  </v-list-item-action>
                </template>
              </v-list-item>
            </template>
          </v-list-item-group>
        </v-list>
      </v-col>
    </v-row>
  </div>
</template>

<script>
  import { tmdbAxios } from '../../backend/axios';
  import FeaturedContent from '../top/TopFeaturedContents';

  export default {
    name: 'TvDetailsPage',
    components: {
      'featured-content': FeaturedContent
    },
    data() {
      return {
        tv_details: [],
        error: null,
        media: 'tv'
      }
    },
    created() {
      this.getContents()
    },
    methods: {
      getContents() {
        var TV_ENDPOINT =
          `https://api.themoviedb.org/3/tv/${this.$route.params.id}/season/${this.$route.params.number}?api_key=${process.env.TMDB_API_KEY}&language=ja`
        tmdbAxios.get(TV_ENDPOINT)
          .then(res => this.fetchSuccessfull(res))
          .catch(err => this.fetchFailed(err))
      },
      fetchSuccessfull(res) {
        this.tv_details = res.data
      },
      fetchFailed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ''
      },
      enterSpace(tv_data) {
        this.$router.push({
          name: 'TvSpace',
          params: {
            season_number: tv_data.season_number,
            episode_number: tv_data.episode_number,
            name: this.$route.params.tv_name,
            episode_title: tv_data.name,
            tmdb_tv_id: this.tv_details.id,
            image_path: this.tv_details.poster_path,
            media: this.media,
          }
        })
      }
    }
  }
</script>

<style scoped>
  .card-title {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 14px;
  }

  .subtitle {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 10px;
    font-weight: bold;
    color: #6c757d;
  }

  .ranktitle {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 12px;
    font-weight: bold;
    color: #000000;
  }

  .side-count {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 14px;
  }
</style>