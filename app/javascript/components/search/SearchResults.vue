<template>
  <v-container>
    <v-row>
      <v-col cols=12 sm=12 md=12 lg=12 xl=12>
        <div :style="resultsStyle" v-text="resultsText" />
      </v-col>
    </v-row>
    <v-row class="mt-n3">
      <v-col cols=12 sm=12 md=12 lg=12 xl=12>
        <v-tabs mobile-breakpoint="xs" hide-slider grow :background-color="tabColor">
          <v-tab v-for="(menu, index) in menus" :key="index"
          :style="listStyle" :active-class="tabActive" v-text="menu.name" @click="movePath(menu.path)" />
        </v-tabs>
        <v-divider />
      </v-col>
    </v-row>
    <v-list two-line style="background-color: #ffffff;">
      <v-list-item-group v-for="(item, index) in items.contents"
      :key="index"
      :active-class="listActive" multiple>
      <v-hover v-slot="{hover}">
          <v-list-item
          :class="'rounded-lg'"
           @click="showContents(item)"
            :style="hover ? 'background-color: #f6f6f9;' : 'background-color: #ffffff;'">
              <v-list-item-avatar :size='55' :width='55'
                :class="avatar.rounded">
                <v-img v-if="items.type === 'person'" :src="base_tmdb_img_url + item.profile_path" />
                <v-img v-else :src="base_tmdb_img_url + item.poster_path" />
              </v-list-item-avatar>
              <v-list-item-content v-if="items.type === 'multi'">
                <v-list-item-title class="mb-2" v-if="item.media_type === 'tv'" :style="listItemStyle" v-text="item.name" />
                <v-list-item-title class="mb-2" v-if="item.media_type === 'movie'" :style="listItemStyle" v-text="item.title" />
                <v-list-item-subtitle :style="subtitleStyle" v-text="item.overview" />
              </v-list-item-content>
              <v-list-item-content v-if="items.type === 'tv'">
                <v-list-item-title class="mb-2" :style="listItemStyle" v-text="item.name" />
                <v-list-item-subtitle :style="subtitleStyle" v-text="item.overview" />
              </v-list-item-content>
              <v-list-item-content v-if="items.type === 'movie'">
                <v-list-item-title class="mb-2" :style="listItemStyle" v-text="item.title" />
                <v-list-item-subtitle :style="subtitleStyle" v-text="item.overview" />
              </v-list-item-content>
              <v-list-item-content v-if="items.type === 'person'">
                <v-list-item-title :style="listItemStyle" v-text="item.name" />
              </v-list-item-content>
          </v-list-item>
            </v-hover>
      </v-list-item-group>
    </v-list>
  </v-container>
</template>

<script>
  import { RepositoryFactory } from '../../repositories/RepositoryFactory';
  const tmdbRepository = RepositoryFactory.get('tmdb');

  export default {
    name: 'SearchResults',
    components: {
      'base-list': () => import(/* webpackPrefetch: true */ '../Base/BaseList')
    },
    data() {
      return {
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w500`,
        resultsText: `「${this.$route.params.query}」の検索結果`,
        items: {
          type: '',
          contents: []
        },
        menus: [
          {
            name: 'キーワード',
            path: 'multi'
          },
          {
            name: 'テレビ',
            path: 'tv',
          },
          {
            name: '映画',
            path: 'movie',
          },
          {
            name: '出演者・スタッフ',
            path: 'person'
          },
          {
            name: '企業',
            path: 'company'
          }
        ],
        tabColor: '#ffffff',
        tabActive: 'black--text',
        listActive: 'orange--text',
        resultsStyle: {
          fontSize: "18px",
          fontWeight: 'bold',
          color: '#111111'
        },
        listStyle: {
          fontSize: '12px',
          fontWeight: 'bold',
          color: '#6c757d'
        },
        listItemStyle: {
          fontWeight: 'bold',
          fontSize: '15px',
          color: '#111111'
        },
        subtitleStyle: {
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
        tmdbRepository.search(this.$route.name, this.$route.params.query)
          .then(res => this.searchSuccessful(res))
          .catch(err => this.searchFailed(err))
      },
      searchSuccessful(res) {
        if (this.$route.name === 'multi') {
          this.items = {
            type: 'multi',
            contents: res.data.results
          }
        } else if (this.$route.name === 'tv') {
          this.items = {
            type: 'tv',
            contents: res.data.results
          }
        } else if (this.$route.name === 'movie') {
          this.items = {
            type: 'movie',
            contents: res.data.results
          }
        } else if (this.$route.name === 'person') {
          this.items = {
            type: 'person',
            contents: res.data.results
          }
        } else if (this.$route.name === 'company') {
          this.items = {
            type: 'comapny',
            contents: res.data.results
          }
        }
      },
      searchFailed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ''
      },
      showContents(item) {
        if (this.items.type === 'multi') {
          if (item.media_type === 'tv') {
            this.$router.push({
              name: 'TvDetails',
              params: {
                id: item.id,
                number: 1,
                tv_name: item.name
              }
            }).catch(()=> {});
          } else if (item.media_type === 'movie') {
            this.$router.push({
              name: 'MvDetails',
              params: {
                id: item.id,
                mv_name: item.title
              }
            }).catch(()=> {});
          }
        } else if (this.items.type === 'tv') {
          this.$router.push({
            name: 'TvDetails',
            params: {
              id: item.id,
              number: 1,
              tv_name: item.name
            }
          }).catch(()=> {});
        } else if (this.items.type === 'movie') {
          this.$router.push({
            name: 'MvDetails',
            params: {
              id: item.id,
              mv_name: item.name
            }
          }).catch(()=> {});
        } else if (this.items.type === 'person') {
        } else if (this.items.type === 'company') {
        }
      },
      movePath(path_name) {
        this.$router.replace({
          name: path_name
        }).catch(()=> {});
      }
    },
    computed: {
      // vContainerGrid(){
      //   switch(this.$vuetify.breakpoint.name) {
      //     case 'xs' : return 'ml-16'
      //     case 'sm' : return 'mt-7'
      //     case 'md' : return 'mt-7'
      //     case 'lg' : return 'ml-n2'
      //     case 'xl' : return 'mt-n9'
      //   }
      // }
    }
  }
</script>

<style scoped>
  .theme--light.v-divider {
    border-color: rgba(201, 204, 204, 0.06);
  }
</style>