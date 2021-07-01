<template>
  <v-container fluid class="mt-n3">
    <v-row>
      <v-col lg=3 v-for="(item, index) in spaces.slice(0,4)" :key="index">
        <v-card @click="enterSpace(item.attributes)" elevation=0 class="rounded-lg">
          <v-img position="under" gradient="to bottom, rgb(81 81 85 / 1%), rgb(0 0 0 / 90%)"
            class="white--text align-end rounded-lg" height="230px" v-if="item.attributes.image_path"
            :src="posterImg(item.attributes.image_path)">
          <v-btn v-if="item.attributes.latest_comment === null" color="#00bbf9" x-small class="elevation-0 ml-3 rounded" alt="" style="font-size: 10px; font-weight: bold; color: #ffffff;"
            >
            ピックアップ
          </v-btn>
            <v-card-title v-if="item.attributes.latest_comment" class="mb-n11" style="font-weight: bold; line-height: 20px; font-size: 14px;">
              <p class="head-title">{{item.attributes.latest_comment.content}}</p>
            </v-card-title>
            <v-card-title v-else style="font-weight: bold; line-height: 20px; font-size: 18px;">
              <p class="mb-n1">{{item.attributes.name}}</p>
            </v-card-title>
            <v-card-actions v-if="item.attributes.latest_comment" class="mb-n2 ml-n2">
              <v-list-item class="grow">
                <v-list-item-avatar size=22 color="grey darken-3">
                  <v-img class="elevation-6" alt=""
                    :src="item.attributes.latest_comment_user.data.attributes.avatar_url">
                  </v-img>
                </v-list-item-avatar>
                <v-list-item-content>
                  <v-list-item-title style="color: #ffffff; font-size:11px;">
                    {{item.attributes.latest_comment_user.data.attributes.name}}
                  </v-list-item-title>
                </v-list-item-content>
              </v-list-item>
            </v-card-actions>
          </v-img>
        </v-card>
      </v-col>
    </v-row>

    <v-row no-gutters class="mt-3">
      <v-col lg=11>
        <sub-header class=" ml-n2" :tag='this.$route.params.name'>
          <template v-slot:tag_header="subHeaderProps">
            <h2 :class="gridSubHeader">
              トップ <span class="tag-page">/ {{subHeaderProps.sub_header}}</span>
            </h2>
          </template>
        </sub-header>
      </v-col>

      <v-col lg=1 class="mt-8 ml-n3">
        <v-btn small color="#00bbf9" style="font-weight: bold; color: #ffffff;" elevation=0 class="rounded-xl">フィルター
        </v-btn>
      </v-col>
    </v-row>

    <base-card class="mt-n4 ml-n9" :items='spaces.slice(4)' />
    <base-loader :infiniteId="componentKey" :handler="infiniteHandler" :text="text.loading" />
  </v-container>
</template>

<script>
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const tagsRepository = RepositoryFactory.get('tags');

  export default {
    name: "Tag",
    components: {
      'sub-header': () => import( /* webpackPrefetch: true */ '../Layout/TheSubHeader'),
      'base-banner': () => import( /* webpackPrefetch: true */ '../Base/BaseBanner'),
      'base-loader': () => import( /* webpackPrefetch: true */ '../Base/BaseInfiniteLoader'),
      'base-card': () => import( /* webpackPrefetch: true */ '../Base/BaseCard'),
      'icon-base': () => import( /* webpackPrefetch */ '../Icon/IconBase'),
      'icon-tv': () => import( /* webpackPrefetch: true */ '../Icon/IconTv.vue'),
      'icon-movie': () => import( /* webpackPrefetch: true */ '../Icon/IconMovie.vue'),
      'icon-filter': () => import( /* webpackPrefetch: true */ '../Icon/IconFilter.vue'),
    },
    data() {
      return {
        tabs: [
          '映画',
          'ドラマ'
        ],
        componentKey: 0,
        spaces: [],
        componentKey: 0,
        page: 1,
        pageSize: 10,
        error: '',
        base_img_url: `https://image.tmdb.org/t/p/w500`,
        text: {
          loading: 'このタグに登録されたスペースはまだありません。'
        }
      }
    },
    watch: {
      '$route.params.name'() {
        this.page = 1
        this.spaces = []
        this.forceRerender()
      }
    },
    beforeRouteEnter(to, from, next) {
      next(vm => {
        setTimeout(() => {
          document.title = `${vm.$route.params.name} |  Devio` || 'Devio';
        }, 0)
      })
    },
    beforeRouteUpdate(to, from, next) {
      document.title = `${to.params.name} |  Devio` || 'Devio';
      next()
    },
    computed: {
      gridSubHeader() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'sub-header mb-n5 mt-1 ml-2'
          case 'sm':
          case 'md':
          case 'lg':
          case 'xl':
            return 'sub-header mt-4'
        }
      },
    },
    methods: {
      forceRerender() {
        this.componentKey += 1
      },
      infiniteHandler($state) {
        setTimeout(() => {
          tagsRepository.getSpaces(this.$route.params.name, {
              page: this.page,
              per_page: this.pageSize
            })
            .then(res => {
              if (res.data.data.length) {
                this.page += 1
                this.spaces.push(...res.data.data)
                $state.loaded()
              } else {
                $state.complete();
              }
            })
        }, 0)
      },
      fetchFailed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ""
        this.$router.replace('/')
      },
      enterSpace(space) {
        if (space.media === 'tv') {
          this.$router.push({
            name: 'TvSpace',
            params: {
              season_number: space.season,
              episode_number: space.episode,
              name: space.name,
              episode_title: space.episode_title,
              tmdb_tv_id: space.tmdb_tv_id,
              image_path: space.image_path,
              media: space.media,
            }
          })
        } else if (space.media === 'mv') {
          this.$router.push({
            name: 'MvSpace',
            params: {
              image_path: space.image_path,
              tmdb_mv_id: space.tmdb_mv_id,
              name: space.name,
              media: space.media,
            }
          })
        }
      },
      posterImg(path) {
        return this.base_img_url + path
      },
    }
  }
</script>

<style scoped>
  .sub-header {
    font-weight: bold;
    font-size: 22px;
    color: #111111;
  }

  .tag-page {
    font-weight: bold;
    font-size: 22px;
    color: #666666;
  }

  .tab-name {
    font-weight: bold;
    font-size: 22px;
    color: #24292e;
  }

  .head-title {
    overflow: hidden;
    position: relative;
    line-height: 1.2em;
    max-height: 4.7em;
    text-align: justify;
    margin-right: -1em;
    padding-right: 1em;
  }

  .head-title:before {
    content: '...';
    position: absolute;
    right: 0;
    bottom: 0;
  }

  .head-title:after {
    content: '';
    position: absolute;
    right: 0;
    width: 1em;
    height: 1em;
    margin-top: 0.2em;
  }
</style>