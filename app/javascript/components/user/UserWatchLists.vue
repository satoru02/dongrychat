<template>
  <div class="mt-3">
    <v-row>
      <v-col lg=3 v-for="(space, index) in spaces" :key="index">
        <v-card elevation=0 class="rounded-lg" @click="enterSpace(space)">
          <v-img size=100 position="under" gradient="to bottom, rgb(81 81 85 / 1%), rgb(0 0 0 / 90%)"
            class="white--text align-end rounded-lg" height="260px" :src="posterImg(space.attributes.image_path)">
            <v-btn :color="space.attributes.media === 'tv' ? '#00bbf9' : '#ff0054'" x-small
              class="elevation-0 ml-3 rounded-xl" style="font-size: 11px; font-weight: bold; color: #ffffff;">
              <span v-if="space.attributes.media === 'mv'">映画</span>
              <span v-if="space.attributes.media === 'tv'">ドラマ</span>
            </v-btn>
            <span v-if="space.attributes.media === 'tv'" class="ml-1"
              style="font-size: 11px; font-weight: bold; color: #ffffff;">
              シーズン{{space.attributes.season}}・第{{space.attributes.episode}}話</span>
            <v-card-title style="font-weight: bold; line-height: 23px; font-size: 15px;">
              {{space.attributes.name}}
              <!-- <span>
                <icon-base v-if="$route.name === 'watchlists'" :iconColor="'yellow'" class="ml-2" icon-name="icon-check"
                  :viewBox="'0 0 191.667 191.667'" :height="'18'" :width="'18'">
                  <icon-check />
                </icon-base>
              </span> -->
            </v-card-title>
          </v-img>
        </v-card>
      </v-col>
    </v-row>
    <base-loader :infiniteId="componentKey" :handler="infiniteHandler" :wrapper="true" :text="loaderText" />
  </div>
</template>

<script>
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const usersRepository = RepositoryFactory.get('users');

  export default {
    name: "UserWatchLists",
    components: {
      'base-loader': () => import( /* webpackPrefetch: true */ '../Base/BaseInfiniteLoader'),
      'icon-base': () => import( /* webpackPrefetch: true */ '../Icon/IconBase.vue'),
      'icon-check': () => import( /* webpackPrefetch: true */ '../Icon/IconCheck.vue'),
    },
    data() {
      return {
        base_img_url: `https://image.tmdb.org/t/p/w500`,
        spaces: [],
        resource: '',
        err: '',
        page: 1,
        pageSize: 8,
        componentKey: 0,
        loading: false,
        loaderText: '現在ウォッチリストに登録した作品はありません。',
      }
    },
    watch: {
      '$route'() {
        this.spaces = []
        this.page = 1
        this.forceRerender()
      }
    },
    methods: {
      forceRerender() {
        this.componentKey += 1
      },
      infiniteHandler($state) {
        setTimeout(() => {
          usersRepository.getWatchlists(this.$route.params.user_id, this.$route.name, {
              page: this.page,
              per_page: this.pageSize
            })
            .then(res => {
              if (res.data.data.length) {
                this.page += 1
                this.spaces.push(...res.data.data)
                this.loading = true
                $state.loaded()
              } else {
                $state.complete()
              }
            })
        }, 0)
      },
      posterImg(path) {
        return this.base_img_url + path
      },
      enterSpace(space) {
        if (space.attributes.media === 'tv') {
          this.$router.push({
            name: 'registeredTvSpace',
            params: {
              space_id: space.attributes.id,
            }
          })
        } else if (space.attributes.media === 'mv') {
          this.$router.push({
            name: 'registeredMvSpace',
            params: {
              space_id: space.attributes.id,
            }
          })
        }
      },
    }
  }
</script>