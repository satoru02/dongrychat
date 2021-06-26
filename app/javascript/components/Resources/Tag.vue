<template>
  <v-container fluid class="ml-n2">
    <!-- <h2 class="mb-3">注目のレビュー</h2> -->

    <v-row>
    <v-col lg=4 v-for="(item, index) in spaces.slice(0,3)" :key="index">
      <v-card elevation=0 class="rounded-lg">
        <v-img position="under" gradient="to bottom, rgb(81 81 85 / 1%), rgb(0 0 0 / 90%)"
          class="white--text align-end rounded-lg" height="260px" v-if="item.attributes.image_path"
          :src="posterImg(item.attributes.image_path)">
          <v-card-title class="mb-n7" style="font-weight: bold; line-height: 23px; font-size: 14px;">
            『劇場版「鬼滅の刃」無限列車編』のBlu-ray＆DVD発売を記念したカウントダウン。
          </v-card-title>
           <v-card-actions>
      <v-list-item class="grow">
        <v-list-item-avatar size=22 color="grey darken-3">
          <v-img
            class="elevation-6"
            alt=""
            src="https://avataaars.io/?avatarStyle=Transparent&topType=ShortHairShortCurly&accessoriesType=Prescription02&hairColor=Black&facialHairType=Blank&clotheType=Hoodie&clotheColor=White&eyeType=Default&eyebrowType=DefaultNatural&mouthType=Default&skinColor=Light"
          ></v-img>
        </v-list-item-avatar>

        <v-list-item-content>
          <v-list-item-title style="color: #ffffff; font-size:10px;">Evan You</v-list-item-title>
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
    <!-- <v-col lg=5>

    </v-col> -->
    <v-col lg=1 class="mt-8 ml-n4">
      <v-btn small color="#580aff" style="font-weight: bold; color: #ffffff;" elevation=0 class="rounded-xl">フィルター</v-btn>
    </v-col>
  </v-row>

    <!-- <v-tabs height="40" class="mt-n1 ml-5" background-color='#ffffff'>
       <v-tabs-slider color="#000000"></v-tabs-slider>
      <v-tab class="tab-name" active-class="black--text" color="#000000"
        v-for="(tablist, index) in tabs" :key="index">
        {{tablist}}
      </v-tab>
    </v-tabs> -->

    <!-- <v-divider class="ml-5" /> -->

    <!-- <v-row no-gutters class="mt-2 mb-2">
      <v-col lg=1></v-col>
      <v-col lg=5 class="ml-13" style="font-size: 11px; font-weight: bold; color: #606770;">タイトル</v-col>
      <v-col lg=4 class="" style="font-size: 11px; font-weight: bold; color: #606770;">詳細</v-col>
      <v-col lg=1 class="ml-5" style="font-size: 11px; font-weight: bold; color: #606770;">
        フィルタ
        <icon-base icon-name="icon-filter" :width="'7'" :height="'7'" :viewBox="'0 0 451.847 451.847'" :iconColor="'#606770'"><icon-filter /></icon-base>
      </v-col>
    </v-row> -->

    <!-- <v-divider class="ml-5" /> -->

    <base-card class="mt-n4 ml-n9" :items='spaces' />
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
      posterImg(path) {
        return this.base_img_url + path
      },
    }
  }
</script>

<style scoped>
  .sub-header {
    font-weight: bold;
    font-size:22px;
    color: #111111;
  }

  .tag-page {
    font-weight: bold;
    font-size:22px;
    color: #666666;
  }

  .tab-name {
    font-weight: bold;
    font-size: 22px;
    color: #24292e;
  }
</style>