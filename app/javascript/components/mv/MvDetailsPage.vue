<template>
  <div>
    <v-row>
      <v-col cols=5 class="ml-4 mt-3">
        <featured-content />
      </v-col>
      <v-col>
        <v-row>
          <v-col :mv_name="mv_name" cols=12 class="mt-3 card-title">
            <h3>{{ contents_name }}</h3>
          </v-col>
        </v-row>
        <v-row>
          <v-col cols=12 class="mt-n4">
            <div style="font-size: 0.7rem;">
              {{ description }}
            </div>
          </v-col>
        </v-row>
      </v-col>
    </v-row>

    <v-row>
      <v-col cols=12 class="mt-n3">
        <!-- <v-list two-line>
          <v-list-item-group style="background-color: #ffffff" active-class="orange--text" multiple>
            <template v-for="(n, index) in items">
              <v-list-item :key="index">
                <template v-slot:default="{ }">
                  <div class="mr-5 ranktitle">{{index + 1}}</div>
                  <v-list-item-content class=ml-1>
                    <v-list-item-title class="card-title" v-html="n.title"></v-list-item-title>
                    <v-list-item-subtitle v-html="n.name" class="subtitle">
                    </v-list-item-subtitle>
                  </v-list-item-content>
                  <v-list-item-action>
                    <div class="subtitle">{{n.count}}人が会話中</div>
                  </v-list-item-action>
                </template>
              </v-list-item>
            </template>
          </v-list-item-group>
        </v-list> -->
      </v-col>
    </v-row>
  </div>

</template>

<script>
  import {
    tmdbAxios
  } from '../../backend/axios';
  import FeaturedContent from '../top/TopFeaturedContents';

  export default {
    name: 'TvPage',
    components: {
      'featured-content': FeaturedContent
    },
    props: {
      mv_name: {
        type: String,
        // required: true
      }
    },
    data() {
      return {
        description: null,
        contents: null,
        error: null,
      }
    },
    created() {
      this.getContents()
    },
    methods: {
      getContents() {
        var MV_ENDPOINT =
          `https://api.themoviedb.org/3/movie/${this.$route.params.id}?api_key=${process.env.TMDB_API_KEY}`
        tmdbAxios.get(MV_ENDPOINT)
          .then(res => this.fetchSuccessfull(res))
          .catch(err => this.fetchFailed(err))
      },
      fetchSuccessfull(res) {
        console.log(res)
        // this.description = res.data.overview
        // this.items = res.data.episodes
      },
      fetchFailed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ''
      },
      enterSpace(mv_data, mv_name) {
        this.$router.push({
          name: 'MvSpace',
          params: {
            value: mv_data,
            name: mv_name,
            media: 'mv'
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