<template>
  <v-container v-if="this.space_data">

    <v-row no-gutters>

      <!-- left part -->
      <v-col cols=4 sm=4 md=4 lg=3 xl=3 :class="vColAvatarGrid">
        <v-card elevation=0 class="rounded-lg" width="310px" color="#dee2e6">
          <v-img v-if="this.space_data.image_path" :src="posterImg()" class="white--text mt-n2"
            :height="$vuetify.breakpoint.width > 600 ?  '380px' : '190px'">
          </v-img>
          <v-img height="340px" v-else>
            <icon-base :width="'130'" class="mt-15 ml-13" :height="'140'" icon-name="icon-no-image"
              :iconColor="'#111111'" :viewBox="'0 0 512 512'">
              <icon-no-image />
            </icon-base>
          </v-img>
        </v-card>

        <v-row class="mt-1">
          <v-col sm=12 md=12 lg=12 xl=12 v-if="$vuetify.breakpoint.width > 600">
            <v-row class="ml-11">
              <v-col sm=5 md=5 lg=5 style="font-weight: bold;">
                <h2>{{this.space_data.watchlist_count}}</h2>
                <p class="ml-n4" style="font-size: 13px; font-weight: bold;">総視聴数</p>
              </v-col>
              <v-col sm=2 md=2 lg=2 class="ml-n4 mb-5 mt-1">
              </v-col>
              <v-col sm=5 md=5 lg=5 style="font-weight: bold;" class="ml-2">
                <h2>4.3</h2>
                <p class="ml-n1" style="font-size: 13px; font-weight: bold;">レビュー</p>
              </v-col>
            </v-row>

            <v-row class="mt-n5">
              <v-col lg=6>
                <v-btn @click="watched === false ? addWatchedlist() : deleteWatchList()"
                  :outlined="watched === false ? false : true" :color="watched === true ? '#06d6a0' : '#06d6a0'"
                  style="font-weight: bold;" block elevation=0>
                  <span :style="watched === false ? this.watchColor : this.unwatchColor">
                    {{watched === true ? this.watchText : this.unwatchText}}
                  </span>
                </v-btn>
              </v-col>
              <v-col lg=6 v-if="watched === false">
                <v-btn @click="checked === false ? addWatchlist() : deleteWatchList()" style="font-weight: bold;"
                  :color="checked === true ? 'rgb(0 213 247)' : 'rgb(0 213 247)'"
                  :outlined="checked === false ? false : true" block elevation=0>
                  <span :style="checked === false ? this.checkColor : this.uncheckColor">
                    {{checked === true ? this.checkText : this.uncheckText}}
                  </span>
                </v-btn>
              </v-col>
            </v-row>
            <v-row>
              <v-col lg=12>
                <v-btn @click="subscribed === true ? unsubscribe() : subscribe()"
                  :outlined="subscribed === false ? false : true" :color="subscribed === true ? '#000000' : '#000000'"
                  class="rounded" style="font-weight: bold;" block elevation=0>
                  <span :style="subscribed === false ? this.subscribeColor : this.unsubscribeColor">
                    {{subscribed === true ? this.followText : this.unfollowText}}
                  </span>
                </v-btn>
              </v-col>
            </v-row>

            <v-row class="mt-3">
              <v-col sm=2 md=2 lg=2 xl=2>
                <icon-base class="" icon-name="icon-clip" :viewBox="'0 0 471.641 471.641'" :iconColor="'#111111'"
                  :height="'17'" :width="'17'">
                  <icon-clip />
                </icon-base>
              </v-col>
              <v-col sm=2 md=2 lg=2 xl=2>
                <icon-base class="" icon-name="icon-twitter" :viewBox="'0 0 512 512'" :height="'17'" :width="'17'">
                  <icon-twitter />
                </icon-base>
              </v-col>
              <v-col sm=2 md=2 lg=2 xl=2>
                <icon-base class="" icon-name="icon-facebook" :viewBox="'0 0 512 512'" :height="'17'" :width="'17'">
                  <icon-facebook />
                </icon-base>
              </v-col>
              <v-col sm=2 md=2 lg=2 xl=2>
                <icon-base class="" icon-name="icon-line" :viewBox="'0 0 24 24'" :iconColor="'#07b53b'" :height="'17'"
                  :width="'17'">
                  <icon-line />
                </icon-base>
              </v-col>
            </v-row>

            <v-row v-if="(this.space_data.media === 'tv') && (this.space_data.creators)" class="">
              <v-col md=12 lg=12 v-if="this.space_data.creators.length > 0">
                <h5 color="#000000" style="font-weight: bold; color: #6c757d;">クリエイター</h5>
                <div v-for="(creator, index) in this.space_data.creators" :key="index" class="mt-1"
                  style="font-weight: bold; font-size: 14px;">
                  {{creator}}
                </div>
              </v-col>
              <v-col md=12 lg=12 v-else>
                <h5 color="#000000" style="font-weight: bold; color: #6c757d;">クリエイター</h5>
                <div class="mt-1" style="font-weight: bold; font-size: 14px;">
                  未登録
                </div>
              </v-col>
            </v-row>
            <v-row class="">
              <v-col md=12 lg=12>
                <h5 color="#000000" style="font-weight: bold; color: #6c757d;">
                  {{ this.space_data.media === 'mv' ? '公開日' : '放送日'}}
                </h5>
                <p v-if="this.space_data.air_date" class="mt-1" style="font-weight: bold; font-size: 13px;">
                  {{this.space_data.air_date}}</p>
                <p v-else class="mt-1" style="font-weight: bold; font-size: 14px;">未登録</p>
              </v-col>
            </v-row>
            <v-row class="mt-n5">
              <v-col md=12 lg=12>
                <h5 color="#000000" style="font-weight: bold; color: #6c757d;">ジャンル</h5>
                <v-chip-group column class="mt-1">
                  <v-chip @click="goTagPage(genre)" small active-class="blue--text" outlined class="mb-3 rounded-lg"
                    style="width: auto; font-weight: bold;" color="#000000" label
                    v-for="(genre, index) in this.space_data.tag_list" :key="index">
                    {{genre}}
                  </v-chip>
                </v-chip-group>
              </v-col>
            </v-row>
            <v-row class="mt-n3">
              <v-col md=12 lg=12 v-if="this.space_data.homepage">
                <v-btn @click="goHomepage()" small block elevation=0>公式HPはこちら</v-btn>
              </v-col>
            </v-row>
          </v-col>
        </v-row>
      </v-col>

      <!-- right part -->
      <v-col cols=8 sm=7 md=8 lg=8 xl=8 :class="$vuetify.breakpoint.width > 600 ? 'mt-8' : 'ml-n5 mt-2'">
        <v-row class="ml-8">
          <base-label :style="'font-weight: bold; border-width: 1.8;'" class="rounded" font_size="13px"
            v-if="space_data.media === media.tv" :label="true" :small="true" :color="'#020814'" :outlined="true"
            :text_color="'#000000'" :season="space_data.season" :episode="space_data.episode"
            :title="space_data.episode_title" />
          <v-chip class="rounded" small v-if="space_data.media === media.mv" outlined label :color="'#020814'"
            :style="vChip.label.style" v-text="'映画'" />
        </v-row>
        <v-row dense class="mt-7" :class="gridTitle">
          <v-col cols=2 sm=1 md=1 lg=1 xl=1 />
          <v-col cols=10 sm=11 md=11 lg=11 xl=11>
            <span :style="contentsTitle"
              @click="space_data.media === media.tv ? moveDetails(space_data.tmdb_comp_id, space_data.name, space_data.season, 'Tv') : moveDetails(space_data.tmdb_mv_id, space_data.name, null, 'Mv')">
              {{space_data.name}}
            </span>
            <icon-base v-if="watched === true" :iconColor="'#0aff99'" class="ml-3 mb-n1" icon-name="icon-check"
              :viewBox="'0 0 191.667 191.667'" :height="'23'" :width="'23'">
              <icon-check />
            </icon-base>
          </v-col>
        </v-row>
        <v-row class="d-flex d-sm-none ml-1">
          <v-col cols=1></v-col>
          <v-col cols=4  style="font-weight: bold;">
            <h4>{{this.space_data.watchlist_count}}</h4>
            <p class="" style="font-size: 13px; font-weight: bold;">総視聴数</p>
          </v-col>
          <v-col cols=1 class="ml-n4 mb-5 mt-1">
          </v-col>
          <v-col cols=4 style="font-weight: bold;" class="">
            <h4>4.3</h4>
            <p class="ml-n1" style="font-size: 13px; font-weight: bold;">レビュー</p>
          </v-col>
        </v-row>

        <v-row v-if="$vuetify.breakpoint.width > 600">
          <v-col class="ml-9" cols=11 sm=12 md=12 lg=11 xl=12 :style="vColSummaryStyle"
            v-text="space_data.overview != null ? space_data.overview : dummyText" />
          <v-col sm=12 md=12 lg=12 xl=12>
            <v-tabs :class="gridHeight" v-if="space_data" :background-color='vTabs.backgroundColor'
              :height="vTabs.height">
              <v-tabs-slider color="#0aff99" class="rounded-xl" />
              <v-tab :active-class="vTab.activeText" @click="changeTab(tablist.path)" :style="vTab.style"
                v-for="(tablist, index) in tablists" :key="index">
                <icon-base v-if="tablist.title === 'コメント'" :iconColor="'#6c757d'" icon-name="icon-following" :width="'19'"
                  :viewBox="'0 0 511.996 511.996'">
                  <icon-following />
                </icon-base>
                <icon-base v-if="tablist.title === 'レビュー'" :iconColor="'#6c757d'" icon-name="icon-pen" :width="'19'"
                  :viewBox="'0 0 512 512'">
                  <icon-pen />
                </icon-base>
                <icon-base v-if="tablist.title === 'ユーザー'" :iconColor="'#6c757d'" icon-name="icon-pen" :width="'19'"
                  :viewBox="'-42 0 512 512.001'">
                  <icon-user />
                </icon-base>
                <span v-if="$vuetify.breakpoint.width > 960"
                  class="ml-3">{{setCount(tablist.title)}}件の{{tablist.title}}</span>
                <span v-else class="ml-3">{{setCount(tablist.title)}}</span>
              </v-tab>
            </v-tabs>
            <router-view v-if="this.space_data" :spaceId="this.space_data.id" />
          </v-col>
        </v-row>
      </v-col>
    </v-row>

    <!-- mobile part -->
    <v-row v-if="$vuetify.breakpoint.width < 600" no-gutters class="mt-5">
      <v-row>
        <v-col cols=6>
          <v-btn small @click="subscribed === true ? unsubscribe() : subscribe()"
            :outlined="subscribed === false ? false : true" :color="subscribed === true ? '#000000' : '#000000'"
            class="rounded" style="font-weight: bold;" block elevation=0>
            <span :style="subscribed === false ? this.subscribeColor : this.unsubscribeColor">
              {{subscribed === true ? this.followText : this.unfollowText}}
            </span>
          </v-btn>
        </v-col>
        <v-col cols=3>
          <v-btn class="rounded" small @click="watched === false ? addWatchedlist() : deleteWatchList()"
            :outlined="watched === false ? false : true" :color="watched === true ? '#06d6a0' : '#06d6a0'"
            style="font-weight: bold;" block elevation=0>
            <span :style="watched === false ? this.watchColor : this.unwatchColor">
              {{watched === true ? this.watchText : this.unwatchText}}
            </span>
          </v-btn>
        </v-col>
        <v-col cols=3 v-if="watched === false">
          <v-btn class="rounded" small @click="checked === false ? addWatchlist() : deleteWatchList()"
            style="font-weight: bold;" :color="checked === true ? 'rgb(0 213 247)' : 'rgb(0 213 247)'"
            :outlined="checked === false ? false : true" block elevation=0>
            <span :style="checked === false ? this.checkColor : this.uncheckColor">
              {{checked === true ? this.checkText : this.uncheckText}}
            </span>
          </v-btn>
        </v-col>
      </v-row>
      <v-col cols=12>
        <v-tabs grow :class="gridHeight" v-if="space_data" :background-color='vTabs.backgroundColor' :height="vTabs.height">
          <v-tabs-slider color="#0aff99" class="rounded-xl" />
          <v-tab :active-class="vTab.activeText" @click="changeTab(tablist.path)" :style="vTab.style"
            v-for="(tablist, index) in tablists" :key="index">
            <icon-base v-if="tablist.title === 'コメント'" :iconColor="'#6c757d'" icon-name="icon-following" :width="'19'"
              :viewBox="'0 0 511.996 511.996'">
              <icon-following />
            </icon-base>
            <icon-base v-if="tablist.title === 'レビュー'" :iconColor="'#6c757d'" icon-name="icon-pen" :width="'19'"
              :viewBox="'0 0 512 512'">
              <icon-pen />
            </icon-base>
            <icon-base v-if="tablist.title === 'ユーザー'" :iconColor="'#6c757d'" icon-name="icon-pen" :width="'19'"
              :viewBox="'-42 0 512 512.001'">
              <icon-user />
            </icon-base>
            <span v-if="$vuetify.breakpoint.width > 960"
              class="ml-3">{{setCount(tablist.title)}}件の{{tablist.title}}</span>
            <span v-else class="ml-3">{{setCount(tablist.title)}}</span>
          </v-tab>
        </v-tabs>
        <v-divider />　
        <router-view v-if="this.space_data" :spaceId="this.space_data.id" />
      </v-col>
    </v-row>

  </v-container>
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
      'icon-base': () => import( /* webpackPrefetch: true */ '../Icon/IconBase'),
      'icon-pen': () => import( /* webpackPrefetch: true */ '../Icon/IconPen'),
      'icon-following': () => import( /* webpackPrefetch: true */ '../Icon/IconFollowing'),
      'icon-user': () => import( /* webpackPrefetch: true */ '../Icon/IconUser'),
      'icon-twitter': () => import( /* webpackPrefetch: true */ '../Icon/IconTwitter.vue'),
      'icon-facebook': () => import( /* webpackPrefetch: true */ '../Icon/IconFacebook.vue'),
      'icon-line': () => import( /* webpackPrefetch: true */ '../Icon/IconLine.vue'),
      'icon-clip': () => import( /* webpackPrefetch: true */ '../Icon/IconClip.vue'),
      'icon-check': () => import( /* webpackPrefetch: true */ '../Icon/IconCheck.vue'),
      'icon-no-image': () => import( /* webpackPrefetch: true */ '../Icon/IconNoImage.vue'),
      'base-label': () => import( /* webpackPrefetch: true */ '../Base/BaseLabel'),
    },
    data() {
      return {
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w500`,
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
          color: '#000000'
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
        comment: '',
        time: '',
        media: {
          tv: 'tv',
          mv: 'mv',
        },
        api: {
          from_search: `unregistered`,
          from_subscription: `registered`,
          for_subscription: `/api/v1/subscriptions`
        },
        dummyText: '',

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
        },
        vColTitle: {
          style: {
            color: '#020814',
            fontWeight: 'bold',
            fontSize: '22px',
            cursor: 'pointer',
            lineHeight: '30px'
          },
          hoverStyle: {
            color: '#3a86ff',
            fontWeight: 'bold',
            fontSize: '22px',
            cursor: 'pointer',
            lineHeight: '30px'
          }
        },
        vChip: {
          title: {
            color: '#f7e733',
            style: {
              color: '#000000',
              fontWeight: 'bold',
            }
          },
          label: {
            yellow: '#f7e733',
            movie: 'Movie',
            style: {
              fontWeight: 'bold',
              fontSize: '13px',
              borderWidth: '1.8',
            }
          },
        },
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
          air_date: this.$route.params.air_date,
          image_path: this.$route.params.image_path,
          overview: this.$route.params.overview,
          tag_list: this.$route.params.tag_list,
          creators: this.$route.params.creators,
          homepage: this.$route.params.homepage
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
          tag_list: this.$route.params.tag_list,
          air_date: this.$route.params.air_date,
          homepage: this.$route.params.homepage
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
      document.title = `${this.space_data.name} - DongryChat` || 'DongryChat';
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
        document.title = `${this.space_data.name} - DongryChat` || 'DongryChat';
      },
      failed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ''
      },
      setCount(tabListName) {
        switch (tabListName) {
          case 'コメント':
            return this.space_data.comments_count;
          case 'ユーザー':
            return this.space_data.users_count;
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
      goTagPage(tag) {
        this.$router.replace({
          name: 'Tag',
          params: {
            name: tag,
          }
        })
      },
      goHomepage() {
        window.open(this.space_data.homepage)
      },
      moveDetails(id, name, season, media) {
        if (media === 'Tv') {
          this.params = {
            id: id,
            tv_name: name,
            number: season,
          }
        } else if (media === 'Mv') {
          this.params = {
            id: id,
            mv_name: name,
          }
        }
        this.$router.push({
          name: `${media}Details`,
          params: this.params
        })
      },
      posterImg() {
        return this.base_tmdb_img_url + this.space_data.image_path
      },
    },
    computed: {
      pointSize() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return ''
          case 'sm':
            return 'mt-n3'
          case 'md':
            return 'mt-n3'
          case 'lg':
            return 'mt-n5'
          case 'xl':
            return ''
        }
      },
      gridHeight() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'mt-5'
          case 'sm':
            return 'ml-8'
          case 'md':
          case 'lg':
          case 'xl':
            return 'mt-3 ml-8'
        }
      },
      gridOverview() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
          case 'sm':
            return 'ml-n12'
          case 'md':
          case 'lg':
          case 'xl':
            return 'ml-n7'
        }
      },
      gridTitle() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-n4'
          case 'sm':
            return ''
          case 'md':
            return 'ml-n4'
          case 'lg':
            return 'ml-n8'
          case 'xl':
            return 'ml-n6'
        }

      },
      vColAvatarGrid() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return ''
          case 'sm':
            return 'mt-7 ml-n3'
          case 'md':
            return 'mt-7 ml-n4'
          case 'lg':
            return 'mt-7'
          case 'xl':
            return 'ml-10 mt-1'
        }
      },
      vColSummaryStyle() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
          case 'sm':
          case 'md':
            return {
              color: '#111111',
                fontWeight: 'bold',
                fontSize: '12px',
            }
            case 'lg':
            case 'xl':
              return {
                color: '#000000',
                  fontSize: '15.56px',
                  fontWeight: 'bold',
              }
        }
      },
      contentsTitle() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return {
              color: '#020814',
                fontWeight: 'bold',
                fontSize: '16px',
                cursor: 'pointer',
                lineHeight: '30px'
            }
            case 'sm':
            case 'md':
              return {
                color: '#020814',
                  fontWeight: 'bold',
                  fontSize: '18px',
                  cursor: 'pointer',
                  lineHeight: '30px'
              }
              case 'lg':
              case 'xl':
                return {
                  color: '#020814',
                    fontWeight: 'bold',
                    fontSize: '22px',
                    cursor: 'pointer',
                    lineHeight: '30px'
                }
        }
      }
    }
  }
</script>
