<template>
  <div class="">
    <v-row v-if="space_data" class="">
      <v-col cols=2 sm=2 md=2 lg=3 xl=2 :class="vColAvatarGrid">
        <v-card elevation=0 class="rounded-lg" width="225px" color="#dee2e6">
          <v-img v-if="this.space_data.image_path" :src="posterImg()" class="white--text mt-n2" height="300px">
          </v-img>
          <v-img height="340px" v-else>
            <icon-base :width="'130'" class="mt-15 ml-13" :height="'140'" icon-name="icon-no-image"
              :iconColor="'#111111'" :viewBox="'0 0 512 512'">
              <icon-no-image />
            </icon-base>
          </v-img>
        </v-card>
      </v-col>
      <v-col cols=9 sm=9 md=9 lg=9 xl=9 class="ml-n8 mt-8">
        <v-row class="ml-8">
          <base-label :style="'font-weight: bold; border-width: 1.8;'" class="rounded-lg" font_size="13px"
            v-if="space_data.media === media.tv" :label="true" :small="true" :color="'#020814'" :outlined="true"
            :text_color="'#000000'" :season="space_data.season" :episode="space_data.episode"
            :title="space_data.episode_title" />
          <v-chip class="rounded" small v-if="space_data.media === media.mv" outlined label :color="'#020814'"
            :style="vChip.label.style" v-text="'映画'" />
        </v-row>
        <v-row dense class="mt-7">
          <v-col cols=12 sm=12 md=12 lg=12 xl=12>
            <span class="ml-8"
              @click="space_data.media === media.tv ? moveDetails(space_data.tmdb_comp_id, space_data.name, space_data.season, 'Tv') : moveDetails(space_data.tmdb_mv_id, space_data.name, null, 'Mv')"
              :style="vColTitle.style">{{space_data.name}}</span>
              <icon-base
                v-if="watched === true"
               :iconColor="'#0aff99'" class="ml-4 mb-n1" icon-name="icon-check" :viewBox="'0 0 191.667 191.667'" :height="'25'" :width="'25'">
                <icon-check />
              </icon-base>
          </v-col>
        </v-row>

        <v-row class="mt-1">
          <v-col lg=1></v-col>
          <v-col lg=5>
            <span class="ml-n7">
              <v-btn color="#f0f5fa" style="font-weight: bold; font-size: 12px;" elevation=0 small>あらすじ</v-btn>
            </span>
          </v-col>
          <v-col class="" cols=11 sm=12 md=12 lg=2 xl=12>
            <v-btn small @click="subscribed === true ? unsubscribe() : subscribe()" class="mx-2 rounded-lg" elevation=0
              :outlined="subscribed === false ? false : true"
              :color="subscribed === true ? 'rgb(0 213 247)' : 'rgb(0 213 247)'"
              style="font-weight: bold; border-width: 1.9;">
              <icon-base v-if="subscribed === false" class="mr-3" :iconColor="'#ffffff'" icon-name="icon-following"
                :viewBox="'0 0 511.996 511.996'" :height="'20'" :width="'20'">
                <icon-following />
              </icon-base>
              <span :style="subscribed === false ? this.subscribeText : this.unsubscribeText">
                {{subscribed === true ? this.followText : this.unfollowText}}
              </span>
            </v-btn>
          </v-col>

          <v-col class="" cols=11 sm=12 md=12 lg=2 xl=12 v-if="watched === false">
            <v-btn small @click="checked === false ? addWatchlist() : deleteWatchList()" class="mx-2 rounded-lg"
              elevation=0 style="font-weight: bold; border-width: 1.9;" :outlined="checked === false ? false : true"
              :color="checked === true ? 'rgb(0 213 247)' : 'rgb(0 213 247)'">
              <icon-base v-if="checked === false" class="mr-2" :iconColor="'#ffffff'" icon-name="icon-calendar"
                :viewBox="'-33 -19 626 626.68002'" :height="'25'" :width="'25'">
                <icon-calendar />
              </icon-base>
              <span :style="checked === false ? this.subscribeText : this.unsubscribeText">
                {{checked === true ? this.checkText : this.uncheckText}}
              </span>
            </v-btn>
          </v-col>
          <v-col class="" cols=11 sm=12 md=12 lg=2 xl=12>
            <v-btn small @click="watched === false ? addWatchedlist() : deleteWatchList()" class="mx-2 rounded-lg"
              elevation=0 style="font-weight: bold; border-width: 1.9;" :outlined="watched === false ? false : true"
              :color="watched === true ? '#06d6a0' : 'rgb(0 213 247)'">
              <icon-base class="mr-3" v-if="watched === false" :iconColor="'#ffffff'" icon-name="icon-list"
                :viewBox="'0 0 512 512'" :height="'20'" :width="'20'">
                <icon-list />
              </icon-base>
              <span :style="watched === false ? this.watchColor : this.unwatchColor">
                {{watched === true ? this.watchText : this.unwatchText}}
              </span>
            </v-btn>
          </v-col>
        </v-row>
        <v-row class="mt-2" style="min-height: 164; max-height: 164;">
          <v-col class="ml-9" cols=11 sm=12 md=12 lg=11 xl=12 :style="vColSummaryStyle"
            v-text="space_data.overview != null ? space_data.overview : dummyText" />
        </v-row>
      </v-col>
    </v-row>
  </div>
</template>

<script>
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const sbscRepository = RepositoryFactory.get('subscriptions');
  const watchlistsRepository = RepositoryFactory.get('watchlists');

  export default {
    name: 'SpaceHeader',
    components: {
      'icon-base': () => import( /* webpackPrefetch: true */ '../Icon/IconBase.vue'),
      'icon-list': () => import( /* webpackPrefetch: true */ '../Icon/IconList.vue'),
      'icon-check': () => import( /* webpackPrefetch: true */ '../Icon/IconCheck.vue'),
      'icon-following': () => import( /* webpackPrefetch: true */ '../Icon/IconFollowing.vue'),
      'icon-calendar': () => import( /* webpackPrefetch: true */ '../Icon/IconCalendar.vue'),
      'icon-no-image': () => import( /* webpackPrefetch: true */ '../Icon/IconNoImage.vue'),
      'base-label': () => import( /* webpackPrefetch: true */ '../Base/BaseLabel'),
    },
    props: {
      space_data: '',
    },
    data() {
      return {
        subscribed: '',
        watched: false,
        checked: false,
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w500`,
        api: {
          for_subscription: `/api/v1/subscriptions`
        },
        media: {
          tv: 'tv',
          mv: 'mv',
        },
        followText: '',
        unfollowText: '',
        watchText: '',
        unwatchText: '',
        checkText: '',
        uncheckText: '',
        // followText: 'チャットスペースをフォロー中',
        // unfollowText: 'チャットスペースをフォロー',
        // watchText: '鑑賞済み',
        // unwatchText: 'ウォッチログに追加',
        // checkText: 'ウォッチリストに追加済',
        // uncheckText: 'ウォッチリストに追加',
        subscribeText: {
          color: '#ffffff'
        },
        unsubscribeText: {
          color: '#42ccff'
        },
        watchColor: {
          color: '#ffffff'
        },
        unwatchColor: {
          color: '#06d6a0'
        },
        dummyText: '',
        params: {},
        comment: '',
        time: '',
        vColTitle: {
          style: {
            color: '#020814',
            fontWeight: 'bold',
            fontSize: '23px',
            cursor: 'pointer',
            lineHeight: '30px'
          },
          hoverStyle: {
            color: '#3a86ff',
            fontWeight: 'bold',
            fontSize: '23px',
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
      this.subscribed = this.space_data.subscribed
      this.checkWatchlist()
    },
    methods: {
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
      failed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ''
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
      vColAvatarGrid() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-2 mt-1'
          case 'sm':
            return 'mt-7'
          case 'md':
            return 'mt-7'
          case 'lg':
            return 'mt-7'
          case 'xl':
            return 'ml-10 mt-1'
        }
      },
      vColSummaryStyle() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs' || 'sm' || 'md':
            return {
              color: '#111111',
                fontWeight: 'bold',
                fontSize: '12px',
            }
            case 'lg' || 'xl':
              return {
                color: '#000000',
                  fontSize: '14.56px',
                  fontWeight: 'bold',
              }
        }
      }
    }
  }
</script>