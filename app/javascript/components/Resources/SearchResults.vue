<template>
  <v-container class="mt-n2 ml-n3">
    <v-row no-gutters>
      <v-col cols=12 sm=12 md=12 lg=12 xl=12>
        <h1 :style="resultsStyle" v-text="resultsText" />
      </v-col>
    </v-row>
    <v-row class="mt-2">
      <v-col cols=12 sm=12 md=12 lg=12 xl=12>
        <v-tabs mobile-breakpoint="xs" :background-color="tabColor">
         <v-tabs-slider color="#111111"></v-tabs-slider>
          <v-tab v-for="(menu, index) in menus" :key="index" :style="listStyle" :active-class="tabActive"
            v-text="menu.name" @click="movePath(menu.path)" />
        </v-tabs>
        <!-- <v-divider /> -->
      </v-col>
    </v-row>
    <v-list two-line :key="componentKey">
      <v-list-item-group v-for="(item, index) in contents" :key="index" multiple>
        <v-hover v-slot="{hover}">
          <v-list-item :class="'rounded-lg'" @click="showContents(item)"
            :style="hover ? 'background-color: #f5f8fa;' : 'background-color: #ffffff;'">
            <v-list-item-avatar :size='70' :width='70' :class="avatar.rounded" color="#dee2e6">
              <v-img v-if="$route.name === 'person' && item.profile_path"
                :src="base_tmdb_img_url + item.profile_path" />
              <v-img v-else-if="$route.name !== 'person' && item.poster_path"
                :src="base_tmdb_img_url + item.poster_path" />
              <span v-else>
                <icon-base :iconColor="'#ced4da'" :width="'45'" :height="'45'" icon-name="icon-no-image"
                  :viewBox="'0 0 512 512'">
                  <icon-no-image />
                </icon-base>
              </span>
            </v-list-item-avatar>
            <v-list-item-content v-if="$route.name === 'multi'">
              <v-list-item-title class="mb-2" v-if="item.media_type === 'tv' || item.media_type === 'person'"
                :style="listItemStyle" v-text="item.name" />
              <v-list-item-title class="mb-2" v-if="item.media_type === 'movie'" :style="listItemStyle"
                v-text="item.title" />
              <v-list-item-subtitle :style="subtitleStyle" v-text="item.overview" />
            </v-list-item-content>
            <v-list-item-content v-if="$route.name === 'tv'">
              <v-list-item-title class="mb-2" :style="listItemStyle" v-text="item.name" />
              <v-list-item-subtitle :style="subtitleStyle" v-text="item.overview" />
            </v-list-item-content>
            <v-list-item-content v-if="$route.name === 'movie'">
              <v-list-item-title class="mb-2" :style="listItemStyle" v-text="item.title" />
              <v-list-item-subtitle :style="subtitleStyle" v-text="item.overview" />
            </v-list-item-content>
            <v-list-item-content v-if="$route.name === 'person'">
              <v-list-item-title :style="listItemStyle" v-text="item.name" />
            </v-list-item-content>
          </v-list-item>
        </v-hover>
      </v-list-item-group>
    </v-list>
    <base-loader :infiniteId="componentKey" :handler="infiniteHandler" :wrapper="true" :text="loaderText" />
  </v-container>
</template>

<script>
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const tmdbRepository = RepositoryFactory.get('tmdb');

  export default {
    name: 'SearchResults',
    components: {
      'base-list': () => import( /* webpackPrefetch: true */ '../Base/BaseList'),
      'base-loader': () => import( /* webpackPrefetch: true */ '../Base/BaseInfiniteLoader'),
      'icon-no-image': () => import( /* webpackPrefetch */ '../Icon/IconNoImage.vue'),
      'icon-base': () => import( /* webpackPrefetch: true */ '../Icon/IconBase'),
    },
    data() {
      return {
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w200`,
        resultsText: `「${this.$route.params.query}」の検索結果`,
        loaderText: `「${this.$route.params.query}」の検索結果は見つかりませんでした。`,
        componentKey: 0,
        page: 1,
        contents: [],
        menus: [{
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
          // {
          //   name: '出演者・スタッフ',
          //   path: 'person'
          // },
        ],
        tabColor: '#ffffff',
        tabActive: 'black--text',
        resultsStyle: {
          fontSize: "22px",
          fontWeight: 'bold',
          color: '#111111'
        },
        listStyle: {
          fontSize: '16px',
          fontWeight: 'bold',
          color: '#6c757d'
        },
        listItemStyle: {
          fontWeight: 'bold',
          fontSize: '16px',
          color: '#111111'
        },
        subtitleStyle: {
          fontSize: '14px',
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
          this.page = 1
          this.resultsText = `「${this.$route.params.query}」の検索結果`
          this.contents = ''
          this.forceRerender()
        }
      }
    },
    methods: {
      infiniteHandler($state) {
        setTimeout(() => {
          tmdbRepository.search(this.$route.name, this.$route.params.query, this.page)
            .then(res => {
              if (res.data.results.length) {
                if (this.page === 1) {
                  this.contents = res.data.results
                } else if (this.page > 1) {
                  this.contents = this.contents.concat(res.data.results)
                }
                this.page += 1;
                this.loading = true
                $state.loaded()
              } else {
                $state.complete()
              }
            })
        }, 0)
      },
      forceRerender(){
        this.componentKey += 1
      },
      showContents(item) {
        if (this.$route.name === 'multi') {
          if (item.media_type === 'tv') {
            this.$router.push({
              name: 'TvDetails',
              params: {
                id: item.id,
                number: 1,
                tv_name: item.name
              }
            }).catch(() => {});
          } else if (item.media_type === 'movie') {
            this.$router.push({
              name: 'MvDetails',
              params: {
                id: item.id,
                mv_name: item.title
              }
            }).catch(() => {});
          }
        } else if (this.$route.name === 'tv') {
          this.$router.push({
            name: 'TvDetails',
            params: {
              id: item.id,
              number: 1,
              tv_name: item.name
            }
          }).catch(() => {});
        } else if (this.$route.name === 'movie') {
          this.$router.push({
            name: 'MvDetails',
            params: {
              id: item.id,
              mv_name: item.title
            }
          }).catch(() => {});
        } else if (this.$route.name === 'person') {} else if (this.$route.name === 'company') {}
      },
      movePath(path_name) {
        this.$router.replace({
          name: path_name
        }).catch(() => {});
      }
    },
  }
</script>

<style scoped>
  .theme--light.v-divider {
    border-color: rgba(0, 0, 0, 0.06);
  }
</style>