<template>
  <div class="ml-5 mt-3" v-if="this.space_data">
    <space-header v-if="this.space_data" :space_data="this.space_data" :watched="this.watched" />

    <v-row>
      <v-col lg=3>
        <v-row class="ml-7">
          <v-col lg=5 style="font-weight: bold;">
            <h2>{{this.space_data.watchlist_count}}</h2>
            <p class="ml-n4" style="font-size: 13px; font-weight: bold;">総視聴数</p>
          </v-col>
          <v-col lg=1 class="ml-n4 mb-5 mt-1">
            <v-divider vertical />
          </v-col>
          <v-col lg=5 style="font-weight: bold;" class="ml-3">
            <h2>4.3</h2>
            <p class="ml-n1" style="font-size: 13px; font-weight: bold;">レビュー</p>
          </v-col>
        </v-row>

        <v-row class="mt-n5">
          <v-col lg=6>
            <v-btn @click="watched === false ? addWatchedlist() : deleteWatchList()"
              :outlined="watched === false ? false : true" :color="watched === true ? '#06d6a0' : '#06d6a0'"
              style="font-weight: bold;" small block elevation=0>
              <span :style="watched === false ? this.watchColor : this.unwatchColor">
                {{watched === true ? this.watchText : this.unwatchText}}
              </span>
            </v-btn>
          </v-col>
          <v-col lg=6 v-if="watched === false">
            <v-btn @click="checked === false ? addWatchlist() : deleteWatchList()" style="font-weight: bold;"
              :color="checked === true ? 'rgb(0 213 247)' : 'rgb(0 213 247)'"
              :outlined="checked === false ? false : true" small block elevation=0>
              <span :style="checked === false ? this.checkColor : this.uncheckColor">
                {{checked === true ? this.checkText : this.uncheckText}}
              </span>
            </v-btn>
          </v-col>
        </v-row>

        <v-row class="">
          <v-col lg=12>
            <v-btn @click="subscribed === true ? unsubscribe() : subscribe()"
              :outlined="subscribed === false ? false : true"
              :color="subscribed === true ? '#3a86ff' : '#3a86ff'" class="rounded-xl"
              style="font-weight: bold;" block elevation=0>
              <span :style="subscribed === false ? this.subscribeColor : this.unsubscribeColor">
                {{subscribed === true ? this.followText : this.unfollowText}}
              </span>
            </v-btn>
          </v-col>
        </v-row>

        <v-row class="mt-3">
          <v-col lg=2>
            <icon-base class="" icon-name="icon-clip" :viewBox="'0 0 471.641 471.641'" :iconColor="'#111111'"
              :height="'17'" :width="'17'">
              <icon-clip />
            </icon-base>
          </v-col>
          <v-col lg=2>
            <icon-base class="" icon-name="icon-twitter" :viewBox="'0 0 512 512'" :height="'17'" :width="'17'">
              <icon-twitter />
            </icon-base>
          </v-col>
          <v-col lg=2>
            <icon-base class="" icon-name="icon-facebook" :viewBox="'0 0 512 512'" :height="'17'" :width="'17'">
              <icon-facebook />
            </icon-base>
          </v-col>
          <v-col lg=2>
            <icon-base class="" icon-name="icon-line" :viewBox="'0 0 24 24'" :iconColor="'#07b53b'" :height="'17'"
              :width="'17'">
              <icon-line />
            </icon-base>
          </v-col>
        </v-row>
        <v-row>
          <v-col lg=12>
            <h5 color="#000000" style="font-weight: bold; color: #6c757d;">クリエイター</h5>
            <div class="mt-1" style="font-weight: bold; font-size: 13px;">監督ホニャホニャ</div>
          </v-col>
        </v-row>
        <v-row>
          <v-col lg=12>
            <h5 color="#000000" style="font-weight: bold; color: #6c757d;">公開日/放送日</h5>
            <p class="mt-1" style="font-weight: bold; font-size: 13px;">2021/01/01</p>
          </v-col>
        </v-row>
        <v-row class="mt-n5">
          <v-col lg=12>
            <h5 color="#000000" style="font-weight: bold; color: #6c757d;">ジャンル</h5>
            <v-chip-group column class="mt-1">
              <v-chip small active-class="blue--text" outlined class="mb-3 rounded-lg"
                style="width: auto; font-weight: bold;" color="#000000" label
                v-for="(genre, index) in this.space_data.tag_list" :key="index">
                {{genre}}
              </v-chip>
            </v-chip-group>
          </v-col>
        </v-row>
        <v-row class="mt-n3">
          <v-col lg=12>
            <v-btn small block elevation=0>公式HPはこちら</v-btn>
          </v-col>
        </v-row>
      </v-col>
      <v-col lg=9 class="ml-n16">
        <v-tabs grow class="mt-3 ml-16" v-if="space_data" :background-color='vTabs.backgroundColor'
          :height="vTabs.height">
          <v-tabs-slider color="#0aff99" class="rounded-xl" />
          <v-tab :active-class="vTab.activeText" @click="changeTab(tablist.path)" :style="vTab.style"
            v-for="(tablist, index) in tablists" :key="index">
            <icon-base v-if="tablist.title === 'コメント'" :iconColor="'#6c757d'" icon-name="icon-comment" :width="'19'"
              :viewBox="'0 0 30.333 30.333'">
              <icon-comment />
            </icon-base>
            <icon-base v-if="tablist.title === 'レビュー'" :iconColor="'#6c757d'" icon-name="icon-pen" :width="'19'"
              :viewBox="'0 0 512 512'">
              <icon-pen />
            </icon-base>
            <icon-base v-if="tablist.title === 'ユーザー'" :iconColor="'#6c757d'" icon-name="icon-pen" :width="'19'"
              :viewBox="'-42 0 512 512.001'">
              <icon-user />
            </icon-base>
            <span class="ml-3">{{setCount(tablist.title)}}件の{{tablist.title}}</span>
          </v-tab>
        </v-tabs>
        <v-divider width="900" class="ml-16" />　
        <router-view v-if="this.space_data" :spaceId="this.space_data.id" :users="this.space_data.users.data" />
      </v-col>
    </v-row>
  </div>
</template>

<script>
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const spacesRepository = RepositoryFactory.get('spaces');
  const sbscRepository = RepositoryFactory.get('subscriptions');
  const watchlistsRepository = RepositoryFactory.get('watchlists');

  export default {
    name: 'SpaceTop',
    components: {
      'space-header': () => import( /* webpackPrefetch: true */ './SpaceHeader'),
      'icon-base': () => import( /* webpackPrefetch: true */ '../Icon/IconBase'),
      'icon-pen': () => import( /* webpackPrefetch: true */ '../Icon/IconPen'),
      'icon-comment': () => import( /* webpackPrefetch: true */ '../Icon/IconComment'),
      'icon-user': () => import( /* webpackPrefetch: true */ '../Icon/IconUser'),
      'icon-twitter': () => import( /* webpackPrefetch: true */ '../Icon/IconTwitter.vue'),
      'icon-facebook': () => import( /* webpackPrefetch: true */ '../Icon/IconFacebook.vue'),
      'icon-line': () => import( /* webpackPrefetch: true */ '../Icon/IconLine.vue'),
      'icon-clip': () => import( /* webpackPrefetch: true */ '../Icon/IconClip.vue'),
    },
    data() {
      return {
        subscribed: '',
        watched: false,
        checked: false,
        followText: 'チャットフォロー中',
        unfollowText: 'チャットフォロー',
        watchText: '見た',
        unwatchText: '見た',
        checkText: '見たい',
        uncheckText: '見たい',
        subscribeColor: {
          color: '#ffffff'
        },
        unsubscribeColor: {
          color: '#3a86ff'
        },
        checkColor: {
          color: '#ffffff'
        },
        uncheckColor: {
          color: 'rgb(0 213 247)'
        },
        watchColor: {
          color: '#ffffff'
        },
        unwatchColor: {
          color: '#06d6a0'
        },

        params: {},
        space_data: '',
        endpoint: '',
        media: {
          tv: 'tv',
          mv: 'mv',
        },
        api: {
          from_search: `unregistered`,
          from_subscription: `registered`,
        },
        tablists: [{
            title: 'コメント',
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
        vTabs: {
          backgroundColor: '#ffffff',
          height: '40'
        },
        vTab: {
          activeText: 'black--text',
          style: {
            fontWeight: 'bold',
            fontSize: '15px',
          }
        },
        vChip: {
          textColor: '#111111',
          elevation: 0,
          color: '#ededee',
          style: {
            fontSize: '10px',
          }
        }
      }
    },
    created() {
      switch (this.$route.name) {
        case 'registeredTvSpace': {
          this.endpoint = this.api.from_subscription
          this.params = {
            id: this.$route.params.space_id,
            media: this.media.tv
          }
        }
        break;
      case 'registeredMvSpace': {
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
        spacesRepository.enterSpace(this.endpoint, this.params)
          .then(res => this.successful(res))
          .catch(err => this.failed(err))
      },
      successful(res) {
        this.space_data = res.data.data.attributes
        this.subscribed = this.space_data.subscribed
        this.checkWatchlist()
        document.title = `${this.space_data.name} - Devio` || 'Devio';
      },
      failed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ''
      },
      setCount(tabListName) {
        switch (tabListName) {
          case 'コメント':
            return this.space_data.comments_count;
          case 'ユーザー':
            return this.space_data.users.data.length;
          case 'レビュー':
            return this.space_data.reviews_count;
          default:
            return 0;
        }
      },
      changeTab(tabListPath) {
        this.$router.push(({
          path: tabListPath
        })).catch(() => {});
      },
      checkWatchlist() {
        if (this.space_data.watchlist[0]) {
          switch (this.space_data.watchlist[0].status) {
            case false:
              return this.checked = true
            case true:
              return this.watched = true
          }
        }
      },
      addWatchlist() {
        watchlistsRepository.post({
            watchlist: {
              user_id: this.$store.state.user.currentUser.id,
              space_id: this.space_data.id,
              status: false,
            }
          })
          .then(res => this.addListSuccessful(res))
          .catch(err => this.failed(err))
      },
      deleteWatchList() {
        watchlistsRepository.delete(this.space_data.id, this.$store.state.user.currentUser.id)
          .then((res) => this.deleteListSuccessful(res))
          .catch(err => this.failed(err))
      },
      addWatchedlist() {
        const params = {
          user_id: this.$store.state.user.currentUser.id,
          space_id: this.space_data.id,
          status: true,
          comment: this.comment,
          time: this.comment
        }

        if (this.checked === false) {
          watchlistsRepository.post({
              watchlist: params
            })
            .then((res) => {
              this.watched = true
            })
            .catch(err => this.failed(err))
        } else if (this.checked === true) {
          watchlistsRepository.update(this.space_data.id, this.$store.state.user.currentUser.id, {
              watchlist: params
            })
            .then((res) => {
              this.watched = true
            })
            .catch(err => this.failed(err))
        }
      },
      addListSuccessful(res) {
        this.checked = true
      },
      deleteListSuccessful(res) {
        this.checked = false
        this.watched = false
      },
      subscribe() {
        sbscRepository.subscribe({
            user_id: this.$store.state.user.currentUser.id,
            space_id: this.space_data.id
          })
          .then((res) => {
            this.subscribed = true
          })
          .catch(err => this.Failed(err))
      },
      unsubscribe() {
        sbscRepository.unsubscribe(this.space_data.id, this.$store.state.user.currentUser.id)
          .then(res => {
            this.subscribed = false
          })
          .catch(err => this.failed(err))
      },
      unsubscribeSuccessful(res) {
        this.subscribed = false
      },
    },
    computed: {}
  }
</script>

<style scoped>
</style>