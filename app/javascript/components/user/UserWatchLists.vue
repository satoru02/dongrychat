<template>
  <div class="mt-3">
    <v-row v-if="$vuetify.breakpoint.width > 600">
      <v-col
        v-for="(space, index) in spaces"
        :key="index"
        sm=4
        md=3
        lg=3>
        <v-card elevation=0 class="rounded-lg" @click="enterSpace(space)">
          <v-img
            position="under"
            gradient="to bottom, rgb(81 81 85 / 1%), rgb(0 0 0 / 90%)"
            class="white--text align-end rounded-lg"
            height="240px"
            :src="posterImg(space.attributes.image_path)">
            <v-btn
              :color="space.attributes.media === 'tv' ? '#00bbf9' : '#ff0054'"
              x-small
              class="elevation-0 ml-3 rounded-xl"
              style="font-size: 11px; font-weight: bold; color: #ffffff;">
              <span v-if="space.attributes.media === 'mv'">
                映画
              </span>
              <span v-if="space.attributes.media === 'tv'">
                ドラマ
              </span>
            </v-btn>
            <span
              v-if="space.attributes.media === 'tv'"
              class="ml-1"
              style="font-size: 12px; font-weight: bold; color: #ffffff;">
              シーズン{{space.attributes.season}}・第{{space.attributes.episode}}話
            </span>
            <v-card-title
              style="font-weight: bold; line-height: 23px; font-size: 15px;">
              {{space.attributes.name}}
            </v-card-title>
          </v-img>
        </v-card>
      </v-col>
    </v-row>
    <v-row v-if="$vuetify.breakpoint.width < 600">
      <v-col v-for="(space, index) in spaces" :key="index" cols=4>
        <v-card elevation=0 class="rounded-lg" @click="enterSpace(space)">
          <v-img
            class="white--text align-end rounded"
            height="160px"
            :src="posterImg(space.attributes.image_path)">
          </v-img>
        </v-card>
      </v-col>
    </v-row>
    <base-loader
      :infiniteId="componentKey"
      :handler="infiniteHandler"
      :wrapper="true"
      :text="loaderText" />
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
      // 'icon-base': () => import( /* webpackPrefetch: true */ '../Icon/IconBase.vue'),
      // 'icon-check': () => import( /* webpackPrefetch: true */ '../Icon/IconCheck.vue'),
    },
    data() {
      return {
        baseImgUrl: `https://image.tmdb.org/t/p/w500`,
        spaces: [],
        err: '',
        page: 1,
        pageSize: 8,
        componentKey: 0,
        isLoading: false,
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
                this.isLoading = true
                $state.loaded()
              } else {
                $state.complete()
              }
            })
        }, 0)
      },
      posterImg(path) {
        return this.baseImgUrl + path
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