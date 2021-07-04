<template>
  <v-container fluid :class="homeContainer">
    <!-- <base-banner class="ml-14" /> -->
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
  const spacesRepository = RepositoryFactory.get('spaces');

  export default {
    name: 'Home',
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
    watch: {
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
          spacesRepository.getTrend({
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
      homeContainer() {
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
          case 'xl':
            return 4
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
    font-size: 22px;
    color: #111111;
  }
</style>