<template>
  <v-container class="ml-n2" style="background-color: #0e0e10;">
    <v-row>
      <v-col md=12 lg=12 xl=12>
        <div :style="resultsStyle" v-text="resultsText" />
      </v-col>
    </v-row>
    <v-row class="mt-n3">
      <v-col md=12 lg=12 xl=12>
        <v-tabs grow :background-color="tabColor">
          <v-tab :style="listStyle" :active-class="tabActive" v-text="keyword.text" @click="movePath(keyword.arg)" />
          <v-tab :style="listStyle" :active-class="tabActive" v-text="tv.text" @click="movePath(tv.arg)" />
          <v-tab :style="listStyle" :active-class="tabActive" v-text="movie.text" @click="movePath(movie.arg)" />
          <v-tab :style="listStyle" :active-class="tabActive" v-text="person.text" @click="movePath(person.arg)" />
          <v-tab :style="listStyle" :active-class="tabActive" v-text="company.text" @click="movePath(company.arg)" />
        </v-tabs>
        <v-divider />
      </v-col>
    </v-row>
    <v-list two-line style="background-color: #0e0e10;">
      <v-list-item-group v-for="(item, index) in items.contents"
      :key="index"
      :active-class="listActive" multiple>
      <v-hover v-slot="{hover}">
          <v-list-item
          :class="'rounded-lg'"
           @click="showContents(item)"
            :style="hover ? 'background-color: #1a212d;' : 'background-color: #0e0e10;'">

              <v-list-item-avatar :size='avatar.size' :width='avatar.width' :height='avatar.height'
                :class="avatar.rounded">
                <v-img v-if="items.type === person.arg" :src="base_tmdb_img_url + item.profile_path" />
                <v-img v-else :src="base_tmdb_img_url + item.poster_path" />
              </v-list-item-avatar>
              <v-list-item-content v-if="items.type === keyword.arg">
                <v-list-item-title class="mb-2" v-if="item.media_type === tv.arg" :style="listItemStyle" v-text="item.name" />
                <v-list-item-title class="mb-2" v-if="item.media_type === movie.arg" :style="listItemStyle" v-text="item.title" />
                <v-list-item-subtitle :style="subtitleStyle" v-text="item.overview" />
              </v-list-item-content>
              <v-list-item-content v-if="items.type === tv.arg">
                <v-list-item-title class="mb-2" :style="listItemStyle" v-text="item.name" />
                <v-list-item-subtitle :style="subtitleStyle" v-text="item.overview" />
              </v-list-item-content>
              <v-list-item-content v-if="items.type === movie.arg">
                <v-list-item-title class="mb-2" :style="listItemStyle" v-text="item.title" />
                <v-list-item-subtitle :style="subtitleStyle" v-text="item.overview" />
              </v-list-item-content>
              <v-list-item-content v-if="items.type === person.arg">
                <v-list-item-title :style="listItemStyle" v-text="item.name" />
              </v-list-item-content>
          </v-list-item>
            </v-hover>
      </v-list-item-group>
    </v-list>
  </v-container>
</template>

<script>
  import { tmdbAxios } from '../../backend/axios';

  export default {
    name: 'SearchResults',
    data() {
      return {
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w500`,
        resultsText: `「${this.$route.params.query}」の検索結果`,
        tmdb_api: {
          search: `https://api.themoviedb.org/3/search/${this.$route.name}?api_key=${process.env.TMDB_API_KEY}&language=ja&query=${this.$route.params.query}&page=1&include_adult=false`
        },
        items: {
          type: '',
          contents: []
        },
        keyword: {
          text: 'キーワード',
          arg: 'multi'
        },
        tv: {
          text: 'テレビ',
          arg: 'tv',
          details: 'TvDetails'
        },
        movie: {
          text: '映画',
          arg: 'movie',
          details: 'MvDetails'
        },
        person: {
          text: '出演者・スタッフ',
          arg: 'person'
        },
        company: {
          text: '企業',
          arg: 'company'
        },
        // for css --------------------------------------------
        tabColor: '#0e0e10',
        tabActive: 'white--text',
        listActive: 'orange--text',
        resultsStyle: {
          fontSize: "18px",
          fontFamily: 'Helvetica Neue, sans-serif',
          fontWeight: 'bold',
          color: '#ced4da'
        },
        listStyle: {
          fontSize: '13px',
          fontFamily: 'Helvetica Neue, sans-serif',
          fontWeight: 'bold',
          color: '#6c757d'
        },
        listItemStyle: {
          fontWeight: 'bold',
          fontFamily: 'Helvetica Neue, sans-serif',
          fontSize: '15px',
          color: '#ced4da'
        },
        subtitleStyle: {
          fontFamily: 'Helvetica Neue, sans-serif',
          fontSize: '12px',
          fontWeight: 'bold',
          color: '#6c757d'
        },
        avatar: {
          size: '105',
          width: '70',
          height: '135',
          rounded: 'rounded-lg'
        }
        // --------------------------------------------
      }
    },
    watch: {
      '$route': {
        immediate: true,
        handler() {
          this.items = ''
          this.resultsText = `「${this.$route.params.query}」の検索結果`
          this.getResults()
        }
      }
    },
    created() {
      this.getResults()
    },
    methods: {
      getResults() {
        tmdbAxios.get(this.tmdb_api.search)
          .then(res => this.searchSuccessful(res))
          .catch(err => this.searchFailed(err))
      },
      searchSuccessful(res) {
        if (this.$route.name === this.keyword.arg) {
          this.items = {
            type: this.keyword.arg,
            contents: res.data.results
          }
        } else if (this.$route.name === this.tv.arg) {
          this.items = {
            type: this.tv.arg,
            contents: res.data.results
          }
        } else if (this.$route.name === this.movie.arg) {
          this.items = {
            type: this.movie.arg,
            contents: res.data.results
          }
        } else if (this.$route.name === this.person.arg) {
          this.items = {
            type: this.person.arg,
            contents: res.data.results
          }
        } else if (this.$route.name === this.company.arg) {
          this.items = {
            type: this.company.arg,
            contents: res.data.results
          }
        }
      },
      searchFailed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ''
      },
      showContents(item) {
        if (this.items.type === this.keyword.arg) {
          if (item.media_type === this.tv.arg) {
            this.$router.push({
              name: this.tv.details,
              params: {
                id: item.id,
                number: 1,
                tv_name: item.name
              }
            }).catch(()=> {});
          } else if (item.media_type === this.movie.arg) {
            this.$router.push({
              name: this.movie.details,
              params: {
                id: item.id,
                mv_name: item.title
              }
            }).catch(()=> {});
          }
        } else if (this.items.type === this.tv.arg) {
          this.$router.push({
            name: this.tv.details,
            params: {
              id: item.id,
              number: 1,
              tv_name: item.name
            }
          }).catch(()=> {});
        } else if (this.items.type === this.movie.arg) {
          this.$router.push({
            name: this.movie.details,
            params: {
              id: item.id,
              mv_name: item.name
            }
          }).catch(()=> {});
        } else if (this.items.type === this.person.arg) {
          // actors component
        } else if (this.items.type === this.company.arg) {
          // company component
        }
      },
      movePath(path_name) {
        this.$router.replace({
          name: path_name
        }).catch(()=> {});
      }
    }
  }
</script>

<style scoped>
  .theme--light.v-divider {
    border-color: rgba(201, 204, 204, 0.06);
  }
</style>