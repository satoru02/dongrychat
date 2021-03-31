<template>
  <v-container fluid>
    <v-row class="mt-n3">
      <v-col lg=1><h3 class="ml-3 head-title mt-2">TV</h3>
      <!-- <v-avatar color="blue" class="ml-7" :size="5" /> -->
      </v-col>
      <v-col lg=1>
        <!-- <h3 class="ml-3 mt-2 another-head-title">Movie</h3> -->
      </v-col>
      <v-col lg=9 />
      <v-col lg=1 class="mt-n3">
        <v-switch v-model="switch1" color="orange" inset />
      </v-col>
    </v-row>
    <v-row class="mt-n7">
      <v-col lg=12>
        <v-card elevation=0 height=350 outlined class="rounded-lg">
          <v-row class="mt-n1">
            <v-col lg=3>
              <div class="subtitle ml-6 mt-3">今週のおすすめ</div>
            </v-col>
          </v-row>
          <div class="ml-3">
            <v-avatar v-for="(n, index) in 4" :key="index" class="rounded-lg ml-7 mt-4" color="primary" tile size=100
              width=160 height=220>
              <v-row>
                <v-col lg=12>
                  <img src="https://image.tmdb.org/t/p/w500/qR6Ybx47dzCcvJKl9juzKKzy9Q9.jpg">
                </v-col>
              </v-row>
            </v-avatar>
            <!-- <top-rated :weekly_trend_contents="weekly_trend_mvs" :media="'mv'" /> -->
          </div>
        </v-card>
      </v-col>
    </v-row>
    <v-row class="mt-n1">
      <v-col lg=6>
        <v-card elevation=0 height=393 outlined class="rounded-lg">
          <v-row>
            <v-col lg=12>
              <div class="part-title ml-6 mt-5">ランキング</div>
            </v-col>
          </v-row>
          <v-list two-line>
            <v-list-item-group active-class="orange--text" multiple class="list-body">
              <template v-for="(item, index) in 5">
                <v-list-item :key="index">
                  <template v-slot:default="{}">
                    <div class="mr-4 ranktitle">{{index + 1}}
                      <!-- <v-icon color="green" class="ml-2" :size="22">mdi-menu-up</v-icon> -->
                    </div>
                    <v-list-item-avatar size=36 height=36 class="rounded-lg">
                      <v-img src="https://cdn.vuetifyjs.com/images/john.jpg" />
                    </v-list-item-avatar>
                    <v-list-item-content class=ml-4>
                      <v-list-item-title class="card-title" v-html="'タイトル'" />
                      <v-list-item-subtitle class="subdiscription mt-1">
                        <!-- Season{{item.attributes.season}}-{{item.attributes.episode}}
                  {{item.attributes.episode_title}} -->
                        Steve johnson
                      </v-list-item-subtitle>
                    </v-list-item-content>

                    <!-- <v-list-item-action>
                      <div class="subtitle ml-n16">1</div>
                    </v-list-item-action>
                    <v-list-item-action>
                      <div class="subtitle ml-n6">1</div>
                    </v-list-item-action> -->
                    <v-list-item-action>
                      <div class="subtitle">157人が会話中</div>
                    </v-list-item-action>
                  </template>
                </v-list-item>
              </template>
            </v-list-item-group>
          </v-list>
        </v-card>
      </v-col>
      <v-col lg=6>
        <v-card elevation=0 height=393 outlined class="rounded-lg">
        </v-card>
      </v-col>
    </v-row>
        <v-row>
      <v-col lg=12>
        <v-card elevation=0 height=350 outlined class="rounded-lg">
          <v-row>
            <v-col lg=3 class="mt-2">
              <div class="subtitle ml-6 mt-3">人気のドラマ</div>
            </v-col>
          </v-row>
          <div class="ml-3">
            <v-avatar v-for="(n, index) in 4" :key="index" class="rounded-lg ml-7 mt-4" color="primary" tile size=100
              width=160 height=220>
              <v-row>
                <v-col lg=12>
                  <img src="https://image.tmdb.org/t/p/w500/qR6Ybx47dzCcvJKl9juzKKzy9Q9.jpg">
                </v-col>
              </v-row>
            </v-avatar>
            <!-- <top-rated :weekly_trend_contents="weekly_trend_mvs" :media="'mv'" /> -->
          </div>
        </v-card>
      </v-col>
    </v-row>
        <v-row>
      <v-col lg=12>
        <v-card elevation=0 height=350 outlined class="rounded-lg">
          <v-row>
            <v-col lg=3 class="mt-2">
              <div class="subtitle ml-6 mt-3">評価の高いドラマ</div>
            </v-col>
          </v-row>
          <div class="ml-3">
            <v-avatar v-for="(n, index) in 4" :key="index" class="rounded-lg ml-7 mt-4" color="primary" tile size=100
              width=160 height=220>
              <v-row>
                <v-col lg=12>
                  <img src="https://image.tmdb.org/t/p/w500/qR6Ybx47dzCcvJKl9juzKKzy9Q9.jpg">
                </v-col>
              </v-row>
            </v-avatar>
            <!-- <top-rated :weekly_trend_contents="weekly_trend_mvs" :media="'mv'" /> -->
          </div>
        </v-card>
      </v-col>
    </v-row>
    <!-- <v-row no-gutters dense class="mb-n16">
        <v-col lg=11 />
        <v-col lg=1>
          <v-switch v-model="switch1" color="orange" inset />
        </v-col>
      </v-row> -->
    <!-- <popular-part v-if="this.switch1 === true" :weekly_trend_contents="weekly_trend_tvs" :media="'tv'"/>
    <popular-part v-else :weekly_trend_contents="weekly_trend_mvs" :media="'mv'" />
    <trend-part /> -->
    <!-- <keep-alive>
      <top-rated v-if="this.switch1 === true" :weekly_trend_contents="weekly_trend_tvs" :media="'tv'" />
      <top-rated v-else :weekly_trend_contents="weekly_trend_mvs" :media="'mv'" />
    </keep-alive> -->
    <!-- <actors-part /> -->
  </v-container>
</template>

<script>
  import {
    tmdbAxios
  } from '../../backend/axios';
  import SearchPopularPart from '../search/SearchPopularPart';
  import SearchTrendPart from '../search/SearchTrendPart';
  import SearchTopRatedPard from '../search/SearchTopRatedPart';
  import BaseLandingPart from '../base/BaseLandingPart';
  // import SearchActorsPart from '../search/SearchActorsPart';

  const WTV_ENDPOINT = `https://api.themoviedb.org/3/trending/tv/week?api_key=${process.env.TMDB_API_KEY}`;
  const WMV_ENDPOINT = `https://api.themoviedb.org/3/trending/movie/week?api_key=${process.env.TMDB_API_KEY}`;
  const TTV_ENDPOINT = `https://api.themoviedb.org/3/tv/popular?api_key=${process.env.TMDB_API_KEY}&language=ja&page=1`;
  const TMV_ENDPOINT =
    `https://api.themoviedb.org/3/movie/popular?api_key=${process.env.TMDB_API_KEY}&language=ja&page=1&region=JP`;
  const TRTV_ENDPOINT =
    `https://api.themoviedb.org/3/tv/top_rated?api_key=${process.env.TMDB_API_KEY}&language=ja&page=1`;

  export default {
    name: 'Search',
    components: {
      'popular-part': SearchPopularPart,
      'trend-part': SearchTrendPart,
      'top-rated': SearchTopRatedPard,
      'landing-part': BaseLandingPart
      // 'actors-part': SearchActorsPart,
    },
    data() {
      return {
        weekly_trend_mvs: [],
        weekly_trend_tvs: [],
        todays_popular_mvs: [],
        todays_popular_tvs: [],
        top_rated_tvs: [],
        switch1: false,
      }
    },
    created() {
      this.getMvContents()
    },
    watch: {
      switch1: function () {
        this.weekly_trend_mvs = []
        this.weekly_trend_tvs = []
        this.todays_popular_mvs = []
        this.todays_popular_tvs = []
        this.top_rated_tvs = []
        if (this.switch1 === true) {
          this.getTvContents()
        } else {
          this.getMvContents()
        }
      }
    },
    methods: {
      getTrendTvs() {
        return tmdbAxios.get(WTV_ENDPOINT)
      },
      getTrendMvs() {
        return tmdbAxios.get(WMV_ENDPOINT)
      },
      getPopularTvs() {
        return tmdbAxios.get(TTV_ENDPOINT)
      },
      getPopularMvs() {
        return tmdbAxios.get(TMV_ENDPOINT)
      },
      getTopratedTvs() {
        return tmdbAxios.get(TRTV_ENDPOINT)
      },
      getTvContents() {
        Promise.all([this.getTrendTvs(), this.getPopularTvs(), this.getTopratedTvs()])
          .then((res) => {
            this.weekly_trend_tvs = res[0].data.results
            this.todays_popular_tvs = res[1].data.results
            this.top_rated_tvs = res[2].data.results
          })
      },
      getMvContents() {
        Promise.all([this.getTrendMvs(), this.getPopularMvs()])
          .then((res) => {
            this.weekly_trend_mvs = res[0].data.results
            this.todays_popular_mvs = res[1].data.results
          })
      }
    }
  }
</script>

<style scoped>
  .title {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 2px;
    font-weight: bold;
    color: #111213;
  }

  .card-title {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 8px;
  }

  .subdiscription {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 4px;
    font-weight: bold;
    color: #6c757d;
  }

  .subtitle {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 4px;
    font-weight: bold;
    color: #484b4d;
  }

  .part-title {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 10px;
    font-weight: bold;
    color: #111213;
  }

  .ranktitle {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 8px;
    font-weight: bold;
    color: #8f8f8f;
  }
</style>