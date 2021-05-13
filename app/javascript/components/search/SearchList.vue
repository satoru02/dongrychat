<template>
  <v-container>
    <v-row :class="vRowHeader">
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 :class="vColTvHeader">
        <div :style="switch1 === false ? active : inactive" v-text="tv.header" />
      </v-col>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 class="ml-n8">
        <div :style="switch1 === true ? active : inactive" v-text="movie.header" />
      </v-col>
      <v-col cols=8 sm=8 md=8 lg=8 xl=8 />
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 class="ml-n6">
        <v-switch dense v-model="switch1" :color="colors.blue" inset :class="switchPosition" />
      </v-col>
    </v-row>
    <v-row :class="vRowContents">
      <v-col cols=3 sm=2 md=2 lg=2 xl=2 :class="vColContents"
       v-for="(item, index) in items" :key="index">
        <v-row class=mb-2>
          <v-col cols=12 sm=12 md=12 lg=12 xl=12>
            <v-avatar
             @click="showContents(item)" :class="listItem.img.avatar.position" :size="listItem.img.avatar.size"
              :width="listItem.img.avatar.width" :height="listItem.img.avatar.height" tile>
              <v-img :src="base_tmdb_img_url + item.poster_path" />
            </v-avatar>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
  import { tmdbAxios } from '../../backend/axios';
  export default {
    name: 'SearchList',
    data() {
      return {
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w200`,
        tmdb_api: {
          type: {
            popular: 'popular',
            trending: 'trending',
            topRated: 'topRated',
            upcoming: 'upcoming'
          },
          tv: {
            popular: `https://api.themoviedb.org/3/tv/popular?api_key=${process.env.TMDB_API_KEY}&language=ja&page=1`,
            trending: `https://api.themoviedb.org/3/trending/tv/week?api_key=${process.env.TMDB_API_KEY}&language=ja`,
            topRated: `https://api.themoviedb.org/3/tv/top_rated?api_key=${process.env.TMDB_API_KEY}&language=ja&page=1`
          },
          movie: {
            popular: `https://api.themoviedb.org/3/movie/popular?api_key=${process.env.TMDB_API_KEY}&language=ja&page=1`,
            trending: `https://api.themoviedb.org/3/trending/movie/week?api_key=${process.env.TMDB_API_KEY}&language=ja`,
            topRated: `https://api.themoviedb.org/3/movie/top_rated?api_key=${process.env.TMDB_API_KEY}&language=ja&page=1`,
            upcoming: `https://api.themoviedb.org/3/movie/upcoming?api_key=${process.env.TMDB_API_KEY}&language=ja&page=1`
          }
        },
        items: [],
        switch1: false,
        media: 'tv',
        endpoint: '',
        switchPosition: 'mt-1',
        colors: {
          blue: 'blue',
          orange: 'orange'
        },
        tv: {
          header: 'TV',
          avatar: 'ml-4',
          type: 'tv',
          details: 'TvDetails'
        },
        movie: {
          header: 'MOVIE',
          avatar: 'ml-10',
          type: 'mv',
          details: 'MvDetails'
        },
        active: {
          fontFamily: 'Helvetica Neue, sans-serif',
          fontSize: '20px',
          fontWeight: 'bold',
          color: '#000000'
        },
        inactive: {
          fontFamily: 'Helvetica Neue, sans-serif',
          fontSize: '20px',
          fontWeight: 'bold',
          color: '#6c757d'
        },
        listItem: {
          position: 'mt-n3',
          elevation: '0',
          height: '430',
          round: 'rounded-lg',
          img: {
            position: 'mt-n10 ml-4',
            avatar: {
              position: 'ml-6 mt-7 rounded-lg',
              size: '125',
              height: '195'
            },
            titlePosition: 'mt-n3 ml-7',
            titleStyle: {
              fontFamily: 'Helvetica Neue sans-serif',
              fontSize: '13px',
              fontWeight: 'bold',
              color: '#000000'
            }
          }
        }
      }
    },
    watch: {
      switch1: function () {
        this.items = []
        if (this.switch1 === false) {
          this.media = 'tv'
          this.getTvContents()
        } else {
          this.media = 'mv'
          this.getMvContents()
        }
      }
    },
    created() {
      if (this.$route.params.query) {
        this.media = this.$route.params.query
      }
      if (this.media === 'tv') {
        this.switch1 = false
        this.getTvContents()
      } else if (this.media === 'mv') {
        this.switch1 = true
        this.getMvContents()
      }
    },
    methods: {
      getTvContents() {
        if (this.$route.name === this.tmdb_api.type.trending) {
          this.endpoint = this.tmdb_api.tv.trending
        } else if (this.$route.name === this.tmdb_api.type.popular) {
          this.endpoint = this.tmdb_api.tv.popular
        } else if (this.$route.name === this.tmdb_api.type.topRated) {
          this.endpoint = this.tmdb_api.tv.topRated
        };
        tmdbAxios.get(this.endpoint)
          .then((res) => {
            this.items = res.data.results
          })
      },
      getMvContents() {
        if (this.$route.name === this.tmdb_api.type.trending) {
          this.endpoint = this.tmdb_api.movie.trending
        } else if (this.$route.name === this.tmdb_api.type.popular) {
          this.endpoint = this.tmdb_api.movie.popular
        } else if (this.$route.name === this.tmdb_api.type.topRated) {
          this.endpoint = this.tmdb_api.movie.topRated
        } else if (this.$route.name === this.tmdb_api.type.upcoming) {
          this.endpoint = this.tmdb_api.movie.upcoming
        };
        tmdbAxios.get(this.endpoint)
          .then((res) => {
            this.items = res.data.results
          })
      },
      showContents(item) {
        if (this.media == this.tv.type) {
          this.$router.push({
            name: this.tv.details,
            params: {
              id: item.id,
              number: 1,
              tv_name: item.name
            }
          })
        } else if (this.media == this.movie.type) {
          this.$router.push({
            name: this.movie.details,
            params: {
              id: item.id,
              mv_name: item.title
            }
          })
        }
      }
    },
    computed: {
      vRowHeader(){
        switch(this.$vuetify.breakpoint.name){
          case 'xs' : return 'ml-10 mt-n6'
          case 'sm' : return ''
          case 'md' : return ''
          case 'lg' : return ''
          case 'xl' : return ''
        }
      },
      vColTvHeader(){
        switch(this.$vuetify.breakpoint.name){
          case 'xs' : return 'ml-10 mr-13'
          case 'sm' : return ''
          case 'md' : return ''
          case 'lg' : return 'ml-10'
          case 'xl' : return ''
        }

      },
      vRowContents(){
        switch(this.$vuetify.breakpoint.name){
          case 'xs' : return 'ml-6'
          case 'sm' : return ''
          case 'md' : return ''
          case 'lg' : return ''
          case 'xl' : return ''
        }
      },
      vColContents(){
        switch(this.$vuetify.breakpoint.name){
          case 'xs' : return 'ml-8 mt-n10'
          case 'sm' : return ''
          case 'md' : return ''
          case 'lg' : return 'mt-n10 ml-4'
          case 'xl' : return ''
        }
      }
    }
  }
</script>

<style scoped>
</style>