<template>
  <v-container fluid class="ml-n2">

    <sub-header class="mt-n3 ml-1" :tag='this.$route.params.name'>
      <template v-slot:tag_header="subHeaderProps">
        <h3 :class="gridSubHeader">
          トップ <span class="tag-page">/ {{subHeaderProps.sub_header}}</span>
        </h3>
      </template>
    </sub-header>

    <!-- <v-tabs height="40" class="mt-n1 ml-5" background-color='#ffffff'>
       <v-tabs-slider color="#000000"></v-tabs-slider>
      <v-tab class="tab-name" active-class="black--text" color="#000000"
        v-for="(tablist, index) in tabs" :key="index">
        {{tablist}}
      </v-tab>
    </v-tabs> -->

    <v-divider class="ml-5" />

    <v-row no-gutters class="mt-2 mb-2">
      <v-col lg=1></v-col>
      <v-col lg=5 class="ml-13" style="font-size: 11px; font-weight: bold; color: #606770;">タイトル</v-col>
      <v-col lg=4 class="" style="font-size: 11px; font-weight: bold; color: #606770;">詳細</v-col>
      <v-col lg=1 class="ml-5" style="font-size: 11px; font-weight: bold; color: #606770;">
        フィルタ
        <icon-base icon-name="icon-filter" :width="'7'" :height="'7'" :viewBox="'0 0 451.847 451.847'" :iconColor="'#606770'"><icon-filter /></icon-base>
      </v-col>
    </v-row>

    <v-divider class="ml-5" />

    <base-card class="mt-n3" :items='spaces' />
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
      }
    }
  }
</script>

<style scoped>
  .sub-header {
    font-weight: bold;
    font-size:15px;
    color: #111111;
  }

  .tag-page {
    font-weight: bold;
    font-size:15px;
    color: #666666;
  }

  .tab-name {
    font-weight: bold;
    font-size: 14px;
    color: #24292e;
  }
</style>