<template>
  <v-container :key="componentKey">
    <sub-header class="mb-n9 mt-1">
      <template v-slot:popular_header="subHeaderProps">
        <h3 class="sub-header">{{subHeaderProps.sub_header}}</h3>
      </template>
    </sub-header>
    <v-divider class="mt-5" />
    <v-row class="mt-n2" dense>
      <v-col :class="$vuetify.breakpoint.width > 600 ? 'mt-4' : 'mt-1'" cols=1 sm=1 md=1 lg=1 xl=1>
        <div :style="switcher === false ? switchBtn.active : switchBtn.inactive" v-text="tv.header" />
      </v-col>
      <v-col :class="$vuetify.breakpoint.width > 600 ? 'mt-4 ml-4' : 'mt-1'" cols=1 sm=1 md=1 lg=1 xl=1>
        <div :style="switcher === true ? switchBtn.active : switchBtn.inactive" v-text="movie.header" />
      </v-col>
      <v-col cols=9 sm=9 md=9 lg=9 xl=9 />
      <v-col :class="$vuetify.breakpoint.width > 600 ? 'ml-n4' : 'mt-n3 ml-4'" cols=1 sm=1 md=1 lg=1 xl=1>
        <v-switch v-model="switcher" color="blue" dense inset />
      </v-col>
    </v-row>

    <base-card :items='items'/>
    <base-loader :handler="infiniteHandler" :wrapper="true" :text="loaderText" />

    <!-- to component -->
    <v-dialog v-model="loginDialog" width="400" transition="dialog-top-transition">
      <v-card color="#ffffff" height="250" class="rounded-lg">
        <v-row>
          <v-col cols=3 sm=3 md=3 lg=3 xl=3 />
          <v-col cols=7 sm=7 md=7 lg=7 xl=7>
            <div class="mt-9 ml-6" :style="dialog.headerStyle" v-text="'Devioを使ってみる'" />
          </v-col>
        </v-row>
        <v-row>
          <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          <v-col cols=10 sm=10 md=10 lg=10 xl=10>
            <v-btn @click="goLogin()" block　:style="dialog.btnStyle" color="black" outlined elevation=0
              v-text="'ログイン'" />
          </v-col>
        </v-row>
        <v-row>
          <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          <v-col cols=10 sm=10 md=10 lg=10 xl=10>
            <v-btn block @click="goSignup()" :style="dialog.btnStyle" color="#016aff" elevation=0 v-text="'アカウント作成'" />
          </v-col>
        </v-row>
        <v-row>
          <v-col cols=3 sm=3 md=3 lg=3 xl=3 />
          <v-col cols=9 sm=9 md=9 lg=9 xl=9>
            <div class="ml-1" :style="dialog.policyStyle" v-text="'利用規約とプライバシーポリシーはこちら'" />
          </v-col>
        </v-row>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<script>
  import { RepositoryFactory } from '../../repositories/RepositoryFactory';
  const spacesRepository = RepositoryFactory.get('spaces');

  export default {
    name: 'ChartTop',
    components: {
      'sub-header': () => import(/* webpackPrefetch: true */ '../Layout/TheSubHeader'),
      'base-label': () => import(/* webpackPrefetch: true */ '../Base/BaseLabel'),
      'base-loader': () => import(/* webpackPrefetch: true */ '../Base/BaseInfiniteLoader'),
      'base-card': () => import(/* webpackPrefetch: true */ '../Base/BaseCard'),
    },
    data() {
      return {
        loaderText: '現在チャット中のスペースはありません。',
        items: [],
        switcher: false,
        loginDialog: false,
        page: 1,
        pageSize: 10,
        componentKey: 0,
        query_media: 'tv',
        error: '',
        icon: {
          size: 22,
          mdi: 'mdi-menu-up'
        },
        media: {
          tv: 'tv',
          movie: 'mv',
        },
        tv: {
          header: 'テレビ',
          pathName: 'TvSpace'
        },
        movie: {
          header: '映画',
          pathName: 'MvSpace'
        },
        switchBtn: {
          active: {
            fontSize: '15px',
            fontWeight: 'bold',
            color: '#000000',
            letterSpacing: '1px'
          },
          inactive: {
            fontSize: '15px',
            fontWeight: 'bold',
            color: '#657786',
            letterSpacing: '1px'
          }
        },
        dialog: {
          headerStyle: {
            color: '#111111',
            fontWeight: 'bold',
            fontSize: '17px',
          },
          btnStyle: {
            color: '#ffffff',
            fontWeight: 'bold',
            fontSize: '12px',
          },
          policyStyle: {
            color: '#6c757d',
            fontSize: '4px',
          }
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
                $state.loaded()
              } else {
                $state.complete();
              }
            })
        }, 0);
      },
      enterSpace(item) {
        if (this.$store.state.user.signedIn) {
          if (item.media === this.media.tv) {
            this.$router.push({
              name: this.tv.pathName,
              params: {
                season_number: item.season,
                episode_number: item.episode,
                name: item.name,
                episode_title: item.episode_title,
                tmdb_tv_id: item.tmdb_tv_id,
                image_path: item.image_path,
                media: item.media,
              }
            })
          } else if (item.media === this.media.movie) {
            this.$router.push({
              name: this.movie.pathName,
              params: {
                image_path: item.image_path,
                tmdb_mv_id: item.tmdb_mv_id,
                name: item.name,
                media: item.media,
              }
            })
          }
        } else {
          this.loginDialog = true
        }
      },
      goLogin() {
        this.$router.replace('/login')
      },
      goSignup() {
        this.$router.replace('/signup')
      }
    }
  }
</script>

<style scoped>
  .theme--light.v-divider {
    border-color: rgba(0,0,0,.04);
  }

  .sub-header {
    font-weight: bold;
    font-size: 19px;
    color: #111111;
  }
</style>