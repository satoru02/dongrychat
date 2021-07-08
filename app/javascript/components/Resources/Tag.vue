<template>
  <v-container fluid :class="tagContainer">
    <v-row class="mt-1 mb-1">
      <v-col cols=10 sm=10 md=10 lg=10 xl=11>
        <span style="font-weight: bold;">トップ</span> <span style="color:#657482; font-weight: bold">/ #{{this.$route.params.name}}</span>
      </v-col>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 class="ml-n3" v-if="$vuetify.breakpoint.width > 600">
        <v-btn small color="#00bbf9" style="font-weight: bold; color: #ffffff;" elevation=0 class="rounded-xl">
          フィルター
        </v-btn>
      </v-col>
    </v-row>

    <v-tabs height="60">
      <v-tabs-slider color="#000000" />
      <v-tab v-for="(tab, index) in tabs" :key="index" v-text="tab" @click="changeContents(tab)" class="tab-name"
        active-class="black--text" />
    </v-tabs>
    <v-divider class="home-divider mb-5" />
    <base-picture :items="items.slice(0, limit)" />
    <base-card :class="baseCardPosition" :items="items.slice(4)" :loading="loading" />
    <base-loader :infiniteId="componentKey" :handler="infiniteHandler" :wrapper="true" :text="loaderText" />
  </v-container>
</template>

<script>
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const tagsRepository = RepositoryFactory.get('tags');

  export default {
    name: 'Tag',
    components: {
      'base-banner': () => import( /* webpackPrefetch: true */ '../Base/BaseBanner'),
      'base-card': () => import( /* webpackPrefetch: true */ '../Base/BaseCard'),
      'base-loader': () => import( /* webpackPrefetch: true */ '../Base/BaseInfiniteLoader'),
      'base-picture': () => import( /* webpackPrefetch: true */ '../Base/BasePicture'),
      'sub-header': () => import( /* webpackPrefetch: true */ '../Layout/TheSubHeader'),
    },
    data() {
      return {
        tabs: [
          'ドラマ',
          '映画',
        ],
        loaderText: '現在チャット中の作品はありません。',
        componentKey: 0,
        page: 1,
        pageSize: 10,
        items: [],
        loading: false,
        switcher: false,
        query_media: 'tv',
        error: '',
        media: {
          tv: 'tv',
          movie: 'mv',
        },
      }
    },
    beforeRouteEnter(to, from, next) {
      next(vm => {
        setTimeout(() => {
          document.title = `${vm.$route.params.name} -  Filmosh` || 'Filmosh';
        }, 0)
      })
    },
    beforeRouteUpdate(to, from, next) {
      document.title = `${to.params.name} -  Filmosh` || 'Filmosh';
      next()
    },
    watch: {
      '$route.params.name': function () {
        this.page = 1
        this.items = []
        this.forceRerender()
      },
      switcher: function () {
        this.page = 1
        this.items = []
        if (this.switcher === false) {
          this.query_media = this.media.tv
          this.forceRerender()
        } else if (this.switcher === true) {
          this.query_media = this.media.movie
          this.forceRerender()
        }
      }
    },
    methods: {
      track() {
        this.$gtag.pageview({
          page_path: '/'
        })
      },
      forceRerender() {
        this.componentKey += 1
      },
      infiniteHandler($state) {
        setTimeout(() => {
          tagsRepository.getSpaces(this.$route.params.name, {
              page: this.page,
              per_page: this.pageSize,
              media: this.query_media
            })
            .then(res => {
              if (res.data.data.length) {
                this.page += 1
                this.items.push(...res.data.data)
                this.loading = true
                $state.loaded()
              } else {
                $state.complete();
              }
            })
        }, 0);
      },
      changeContents(tab) {
        if (tab === 'ドラマ') {
          this.switcher = false
        } else if (tab === '映画') {
          this.switcher = true
        }
      },
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
      tagContainer() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
          case 'sm':
            return ''
          case 'md':
            return ''
          case 'lg':
          case 'xl':
            return 'ml-16'
        }
      },
      limit() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 3
          case 'sm':
          case 'md':
          case 'lg':
            return 4
          case 'xl':
            return 6
        }
      },
      baseCardPosition() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return ''
          case 'sm':
          case 'md':
          case 'lg':
          case 'xl':
            return 'ml-n5'
        }
      }
    },
  }
</script>

<style scoped>
  .theme--light.v-divider {
    border-color: rgba(0, 0, 0, 0.082);
  }

  .home-divider {
    border-width: thin 0 0.7;
  }

  .tab-name {
    font-weight: bold;
    font-size: 16px;
    background-color: #ffffff;
  }

  .sub-header {
    font-weight: bold;
    font-size: 20px;
    color: #111111;
  }
</style>