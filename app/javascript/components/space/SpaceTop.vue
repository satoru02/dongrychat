<template>
  <div class="ml-4">
    <space-header :space_data="this.space_data" />
    <v-tabs grow class="mt-7" v-if="space_data" :background-color='vTabs.backgroundColor' :height="vTabs.height">
      <v-tab
       :active-class="vTab.activeText" @click="changeTab(tablist.path)" :style="vTab.style"
        v-for="(tablist, index) in tablists" :key="index">
        <icon-base v-if="tablist.title === 'チャット'" :iconColor="'#6c757d'" icon-name="icon-comment" :width="'19'" :height="'19'"
          :viewBox="'0 0 30.333 30.333'">
          <icon-comment />
        </icon-base>
        <icon-base v-if="tablist.title === 'レビュー'" :iconColor="'#6c757d'" icon-name="icon-pen" :width="'19'" :height="'19'"
          :viewBox="'0 0 512 512'">
          <icon-pen />
        </icon-base>
        <icon-base v-if="tablist.title === 'ユーザー'" :iconColor="'#6c757d'" icon-name="icon-pen" :width="'19'" :height="'19'"
          :viewBox="'-42 0 512 512.001'">
          <icon-user />
        </icon-base>
        <span class="ml-3">{{tablist.title}}</span>
        <v-chip v-if="$vuetify.breakpoint.width > 600" class="ml-3 rounded-xl" :style="vChip.style" :text-color="vChip.textColor" :elevation="vChip.elevation"
          :color="'#f2f2f2'" small v-text="setCount(tablist.title)">
        </v-chip>
      </v-tab>
    </v-tabs>
    <!-- <v-divider color="black" /> -->
    <router-view v-if="this.space_data" :spaceId="this.space_data.id" :users="this.space_data.users.data" />
  </div>
</template>

<script>
  import { RepositoryFactory } from '../../repositories/RepositoryFactory';
  const spacesRepository = RepositoryFactory.get('spaces');

  export default {
    name: 'SpaceTop',
    components: {
      'space-header': () => import(/* webpackPrefetch: true */ './SpaceHeader'),
      'icon-base': () => import( /* webpackPrefetch: true */ '../Icon/IconBase'),
      'icon-pen': () => import( /* webpackPrefetch: true */ '../Icon/IconPen'),
      'icon-comment': () => import( /* webpackPrefetch: true */ '../Icon/IconComment'),
      'icon-user': () => import( /* webpackPrefetch: true */ '../Icon/IconUser'),
    },
    data() {
      return {
        params: {},
        space_data: '',
        endpoint: '',
        media: {
          tv: 'tv',
          mv: 'mv',
        },
        api: {
          from_search: `unsubscribed`,
          from_subscription: `subscribed`,
        },
        space: {
          tv: {
            subscribed: 'subscribedTvSpace',
            unsubscribed: 'TvSpace'
          },
          movie: {
            subscribed: 'subscribedMvSpace',
            unsubscribed: 'MvSpace'
          }
        },
        tablists: [{
            title: 'チャット',
            path: 'chats'
          },
          {
            title: 'レビュー',
            path: 'reviews'
          },
          {
            title: 'ユーザー',
            path: 'members'
          },
        ],
        vSheet: {
          height: '740',
          style: {
            backgroundColor: '#f6f6f9'
          }
        },
        vTabs: {
          backgroundColor: '#ffffff',
          height: '40'
        },
        vTab: {
          activeText: 'black--text',
          style: {
            fontWeight: 'bold',
            fontSize: '14px',
            // color: '#f6f8fb'
          }
        },
        vChip: {
          textColor: '#111111',
          elevation: 0,
          color: '#ededee',
          style: {
            // fontWeight: 'bold',
            fontSize: '10px',
          }
        }
      }
    },
    created() {
      switch (this.$route.name) {
        case 'subscribedTvSpace': {
          this.endpoint = this.api.from_subscription
          this.params = {
            id: this.$route.params.space_id,
            media: this.media.tv
          }
        }
        break;
      case 'subscribedMvSpace': {
        this.endpoint = this.api.from_subscription
        this.params = {
          id: this.$route.params.space_id,
          media: this.media.mv
        }
      }
      break;
      case 'TvSpace': {
        this.endpoint = this.api.from_search
        this.params = {
          name: this.$route.params.name,
          season: this.$route.params.season_number,
          episode: this.$route.params.episode_number,
          media: this.media.tv,
          episode_title: this.$route.params.episode_title,
          tmdb_comp_id: this.$route.params.tmdb_comp_id,
          tmdb_tv_id: this.$route.params.tmdb_tv_id,
          image_path: this.$route.params.image_path,
          overview: this.$route.params.overview,
          tag_list: this.$route.params.tag_list,
        }
      }
      break;
      case 'MvSpace': {
        this.endpoint = this.api.from_search
        this.params = {
          name: this.$route.params.name,
          media: this.media.mv,
          image_path: this.$route.params.image_path,
          tmdb_mv_id: this.$route.params.tmdb_mv_id,
          overview: this.$route.params.overview,
          tag_list: this.$route.params.tag_list
        }
      }
      break;
      default: {
        this.$router.replace('/')
      }
      }
      this.setSpace()
    },
    watch: {
      $route: 'setSpace'
    },
    beforeRouteEnter(to, from, next) {
      next(vm => {
        setTimeout(() => {
          document.title = `${vm.space_data.name} - Devio` || 'Devio';
        }, 1000)
      })
    },
    beforeRouteUpdate(to, from, next) {
      document.title = `${this.space_data.name} - Devio` || 'Devio';
      next()
    },
    methods: {
      track() {
        this.$gtag.pageview({
          page_path: '/tv_space/:space_id',
        })
      },
      setSpace() {
        spacesRepository.enterSpace(this.endpoint,this.params)
          .then(res => this.successful(res))
          .catch(err => this.failed(err))
      },
      successful(res) {
        this.space_data = res.data.data.attributes
      },
      failed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ''
      },
      setCount(tabListName) {
        switch (tabListName) {
          case 'チャット':
            return this.space_data.comments_count;
          case 'ユーザー':
            return this.space_data.users.data.length;
          case 'レビュー':
            return this.space_data.reviews_count;
          // case 'シェアウォッチ':
          //   return 0;
          default:
            return 0;
        }
      },
      changeTab(tabListPath) {
        this.$router.push(({
          path: tabListPath
        })).catch(() => {});
      }
    },
    computed: {
      vContainerGrid() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-16 mt-n9'
          case 'sm':
            return 'mt-7'
          case 'md':
            return 'mt-7'
          case 'lg':
            return 'mt-n9'
          case 'xl':
            return 'mt-n9'
        }
      }
    }
  }
</script>

<style scoped>
</style>