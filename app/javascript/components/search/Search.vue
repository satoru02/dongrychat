<template>
  <v-container fluid>
    <v-row>
      <v-col md=1 lg=1 xl=1>
        <div
          :style="switch1 === false ? active : inactive"
          v-text="tv.header" />
        <v-avatar
           :color="colors.blue"
           :size="5" v-if="switch1 === false"
           :class="tv.avatar" />
      </v-col>
      <v-col md=1 lg=1 xl=1>
        <div
          :style="switch1 === true ? active : inactive"
          v-text="movie.header" />
        <v-avatar
          :color="colors.blue" :size="5"
          v-if="switch1 === true"
          :class="movie.avatar" />
      </v-col>
      <v-col md=9 lg=9 xl=9 />
      <v-col md=1 lg=1 xl=1>
        <v-switch
          v-model="switch1"
          :color="colors.orange"
          inset
          :class="switchPosition" />
      </v-col>
    </v-row>

    <top-rated
      v-if="this.switch1 === false"
      :items="weekly_trend_tvs"
      :media="media.tv"
      :title="weekly_title" />
    <top-rated
      v-else
      :items="weekly_trend_mvs"
      :media="media.mv"
      :title="weekly_title" />

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
                    </div>
                    <v-list-item-avatar size=36 height=36 class="rounded-lg">
                      <v-img src="https://cdn.vuetifyjs.com/images/john.jpg" />
                    </v-list-item-avatar>
                    <v-list-item-content class=ml-4>
                      <v-list-item-title class="card-title" v-html="'タイトル'" />
                      <v-list-item-subtitle class="subdiscription mt-1">
                        Steve johnson
                      </v-list-item-subtitle>
                    </v-list-item-content>
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

    <upcoming-part
       v-if="this.switch1 === true"
       :items="upcoming_mvs"
       :media="media.mv"
       :title="upcoming_title"
    />
    <trend-part
      v-if="this.switch1 === false"
      :items="top_rated_tvs"
      :media="media.tv"
      :title="rated_title"
    />
    <trend-part
       v-else
       :items="top_rated_mvs"
       :media="media.mv"
       :title="rated_title"
    />
    <popular-part
       v-if="this.switch1 === false"
       :items="todays_popular_tvs"
       :media="media.tv"
       :title="popular_title"
      />
    <popular-part
       v-else
       :items="todays_popular_mvs"
       :media="media.mv"
       :title="popular_title"
    />
  </v-container>
</template>

<script>
  import { tmdbAxios } from '../../backend/axios';
  import SearchPopularPart from '../search/SearchPart';
  import SearchTrendPart from '../search/SearchPart';
  import SearchTopRatedPard from '../search/SearchPart';
  import SearchUpcomingPart from '../search/SearchPart';
  import TrendSpace from '../trend/TrendTop';
  const WTV_ENDPOINT = `https://api.themoviedb.org/3/trending/tv/week?api_key=${process.env.TMDB_API_KEY}&language=ja`;
  const WMV_ENDPOINT = `https://api.themoviedb.org/3/trending/movie/week?api_key=${process.env.TMDB_API_KEY}&language=ja`;
  const TTV_ENDPOINT = `https://api.themoviedb.org/3/tv/popular?api_key=${process.env.TMDB_API_KEY}&language=ja&page=1`;
  const TMV_ENDPOINT = `https://api.themoviedb.org/3/movie/popular?api_key=${process.env.TMDB_API_KEY}&language=ja&page=1&region=JP`;
  const TRTV_ENDPOINT = `https://api.themoviedb.org/3/tv/top_rated?api_key=${process.env.TMDB_API_KEY}&language=ja&page=1`;
  const TRMV_ENDPOINT = `https://api.themoviedb.org/3/movie/top_rated?api_key=${process.env.TMDB_API_KEY}&language=ja&page=1`;
  const UPCOMING_MV_ENDPOINT = `https://api.themoviedb.org/3/movie/upcoming?api_key=${process.env.TMDB_API_KEY}&language=en-US&page=1`;

  export default {
    name: 'Search',
    components: {
      'popular-part': SearchPopularPart,
      'top-rated': SearchTopRatedPard,
      'trend-part': SearchTrendPart,
      'upcoming-part': SearchUpcomingPart,
      'trend-space': TrendSpace
    },
    data() {
      return {
        media: {
          tv: 'tv',
          mv: 'mv'
        },
        weekly_trend_mvs: [],
        weekly_trend_tvs: [],
        todays_popular_mvs: [],
        todays_popular_tvs: [],
        top_rated_tvs: [],
        top_rated_mvs: [],
        upcoming_mvs: [],
        switch1: false,
        switchPosition: 'mt-1',
        weekly_title: '今週のおすすめ',
        popular_title: '人気の作品',
        rated_title: '評価の高い作品',
        upcoming_title: 'もうすぐ公開',
        colors: {
          blue: 'blue',
          orange: 'orange'
        },
        tv: {
          header: 'TV',
          avatar: 'ml-4',
        },
        movie: {
          header: 'MOVIE',
          avatar: 'ml-10'
        },
        active: {
          fontFamily: 'Helvetica Neue sans-serif',
          fontSize: '25px',
          fontWeight: 'bold',
          color: '#000000'
        },
        inactive: {
          fontFamily: 'Helvetica Neue sans-serif',
          fontSize: '25px',
          fontWeight: 'bold',
          color: '#8f8f8f'
        }
      }
    },
    created() {
      this.getTvContents()
    },
    watch: {
      switch1: function () {
        this.weekly_trend_mvs = []
        this.weekly_trend_tvs = []
        this.todays_popular_mvs = []
        this.todays_popular_tvs = []
        this.top_rated_tvs = []
        if (this.switch1 === false) {
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
      getTopratedMvs() {
        return tmdbAxios.get(TRMV_ENDPOINT)
      },
      getUpcomingMvs() {
        return tmdbAxios.get(UPCOMING_MV_ENDPOINT)
      },
      getUpcomingTvs() {
        return tmdbAxios.get(UPCOMING_TV_ENDPOINT)
      },
      getTvContents() {
        Promise.all([this.getTrendTvs(), this.getPopularTvs(), this.getTopratedTvs()])
          .then((res) => {
            this.weekly_trend_tvs = res[0].data.results.slice(0,5)
            this.todays_popular_tvs = res[1].data.results.slice(0,5)
            this.top_rated_tvs = res[2].data.results.slice(0,5)
          })
      },
      getMvContents() {
        Promise.all([this.getTrendMvs(), this.getPopularMvs(), this.getTopratedMvs(), this.getUpcomingMvs()])
          .then((res) => {
            this.weekly_trend_mvs = res[0].data.results.slice(0,5)
            this.todays_popular_mvs = res[1].data.results.slice(0,5)
            this.top_rated_mvs = res[2].data.results.slice(0,5)
            this.upcoming_mvs = res[3].data.results.slice(0,5)
          })
      },
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