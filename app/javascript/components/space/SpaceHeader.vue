<template>
  <div class="mt-4 ml-n5">
    <v-row v-if="space_data" class="mt-n3">
      <v-col cols=2 sm=2 md=2 lg=3 xl=2 :class="vColAvatarGrid">
        <v-card elevation=0 class="rounded-lg" width="240px" color="#dee2e6">
          <v-img v-if="this.space_data.image_path" :src="posterImg()" class="white--text mt-n2" height="350px">
          </v-img>
          <v-img height="340px" v-else >
            <icon-base :width="'130'" class="mt-15 ml-13" :height="'140'" icon-name="icon-no-image" :iconColor="'#111111'"
              :viewBox="'0 0 512 512'">
              <icon-no-image />
            </icon-base>
          </v-img>
        </v-card>
      </v-col>
      <v-col cols=9 sm=9 md=9 lg=9 xl=9 class="ml-n5 mt-8">
        <v-row class="ml-8">

          <!-- <v-btn @click="subscribed === true ? unsubscribe() : subscribe()"
             >{{subscribed === true ? vBtn.subscribedText : vBtn.unsubscribedText}}</v-btn> -->
          <base-label :style="'font-weight: bold; border-width: 1.8;'" class="rounded-xl" font_size="16px"
            v-if="space_data.media === media.tv" :label="true" :small="false" :color="'#020814'" :outlined="true"
            :text_color="'#000000'" :season="space_data.season" :episode="space_data.episode"
            :title="space_data.episode_title" />
          <v-chip class="rounded-xl" v-if="space_data.media === media.mv" outlined label :color="'#020814'"
            :style="vChip.label.style" v-text="'映画'" />
        </v-row>
        <v-row dense class="mt-8">
          <v-col cols=12 sm=12 md=12 lg=12 xl=12>
            <span class="ml-8"
              @click="space_data.media === media.tv ? moveDetails(space_data.tmdb_comp_id, space_data.name, space_data.season, 'Tv') : moveDetails(space_data.tmdb_mv_id, space_data.name, null, 'Mv')"
              :style="vColTitle.style">{{space_data.name}}</span>
          </v-col>
        </v-row>

        <v-row class="mt-3">
          <v-col lg=1></v-col>
          <v-col lg=5>
            <span class="ml-n8">
              <v-btn color="#f6f8fb" style="font-weight: bold; font-size: 14px;" elevation=0 small>あらすじ</v-btn>
            </span>
          </v-col>
          <!-- <v-col cols=12 sm=12 md=12 lg=3 xl=12 class="ml-14">
            <v-btn class="rounded-lg" small :style="'font-weight: bold; border-width: 0.4;'" outlined color="#0e151f">
              <icon-base class="mr-3" icon-name="icon-twitter" :viewBox="'0 0 512 512'" :height="'17'" :width="'17'">
                <icon-twitter />
              </icon-base>
              <span style="color: #474747;">ツイートする</span>
            </v-btn>
          </v-col>
          <v-col cols=12 sm=12 md=12 lg=2 xl=12 class="ml-n11">
            <v-btn class="rounded-lg" small :style="'font-weight: bold; border-width: 0.4;'" outlined color="#0e151f">
              <icon-base class="mr-3" icon-name="icon-facebook" :viewBox="'0 0 512 512'" :height="'17'" :width="'17'">
                <icon-facebook />
              </icon-base>
              <span style="color: #474747;">シェアする</span>
            </v-btn>
          </v-col> -->
        </v-row>
        <v-row class="mt-2" style="min-height: 164; max-height: 164;">
          <v-col class="ml-9" cols=11 sm=12 md=12 lg=11 xl=12 :style="vColSummaryStyle"
            v-text="space_data.overview != null ? space_data.overview : dummyText" />
        </v-row>

        <v-row class="mt-1">
          <v-col class="ml-7" cols=11 sm=12 md=12 lg=5 xl=12>
            <v-btn @click="subscribed === true ? unsubscribe() : subscribe()" block class="mx-2 rounded-lg" elevation=0
              :outlined="subscribed === true ? false : true"
              :color="subscribed === true ? '#42ccff' : '#42ccff'"
              style="font-weight: bold; border-width: 1.9;">
              <icon-base class="mr-3" :iconColor="'#42ccff'" icon-name="icon-plus" :viewBox="'0 0 448 448'"
                :height="'12'" :width="'12'">
                <icon-plus />
              </icon-base>
              <span :style="subscribed === true ? this.subscribeText : this.unsubscribeText">
                {{subscribed === true ? this.followText : this.unfollowText}}
              </span>
            </v-btn>
          </v-col>
          <!-- <v-col class="ml-n2" cols=11 sm=12 md=12 lg=6 xl=12>
            <v-btn block :outlined="watched === true ? false : true" class="mx-2 rounded-lg" elevation=0
             :color="watched === true ? 'rgb(0 213 247)' : 'rgb(0 213 247)'"
              style="font-weight: bold; border-width: 1.9;">
              <icon-base class="mr-3" :iconColor="'rgb(0 213 247)'" icon-name="icon-arrow" :viewBox="'0 0 492 492'"
                :height="'12'" :width="'12'">
                <icon-arrow />
              </icon-base>
              <span :style="watched === true ? this.subscribeText : this.unsubscribeText">
                見た
              </span>
            </v-btn>
          </v-col> -->
          <!-- <v-col class="ml-n2" cols=11 sm=12 md=12 lg=6 xl=12>
            <v-btn block outlined class="mx-2 rounded-lg" elevation=0 color="rgb(0 213 247)"
              style="font-weight: bold; border-width: 1.9;">
              <icon-base class="mr-3" :iconColor="'rgb(0 213 247)'" icon-name="icon-arrow" :viewBox="'0 0 492 492'"
                :height="'12'" :width="'12'">
                <icon-arrow />
              </icon-base>
              見たい
            </v-btn>
          </v-col> -->
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

  export default {
    name: 'SpaceHeader',
    components: {
      'icon-base': () => import( /* webpackPrefetch: true */ '../Icon/IconBase.vue'),
      'icon-plus': () => import( /* webpackPrefetch: true */ '../Icon/IconPlus.vue'),
      'icon-twitter': () => import( /* webpackPrefetch: true */ '../Icon/IconTwitter.vue'),
      'icon-facebook': () => import( /* webpackPrefetch: true */ '../Icon/IconFacebook.vue'),
      'icon-arrow': () => import( /* webpackPrefetch: true */ '../Icon/IconArrow.vue'),
      'icon-no-image': () => import( /* webpackPrefetch: true */ '../Icon/IconNoImage.vue'),
      'base-label': () => import( /* webpackPrefetch: true */ '../Base/BaseLabel'),
    },
    props: ['space_data'],
    data() {
      return {
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w500`,
        api: {
          for_subscription: `/api/v1/subscriptions`
        },
        media: {
          tv: 'tv',
          mv: 'mv',
        },
        followText: 'フォロー中',
        unfollowText: 'フォローする',
        subscribeText: {
          color: '#ffffff'
        },
        unsubscribeText: {
          color: '#42ccff'
        },
        dummyText: '',
        params: {},
        subscribed: Boolean,
        vAvatar: {
          size: '135',
          height: '180',
        },
        vColTitle: {
          style: {
            color: '#020814',
            fontWeight: 'bold',
            fontSize: '33px',
            cursor: 'pointer',
            lineHeight: '30px'
          },
          hoverStyle: {
            color: '#3a86ff',
            fontWeight: 'bold',
            fontSize: '33px',
            cursor: 'pointer',
            lineHeight: '30px'
          }
        },
        vColSubTitle: {
          style: {
            color: '#6c757d',
            fontWeight: 'bold',
            fontSize: '8px',
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
          tags: {
            color: '#ffffff',
            style: {
              color: '#ffffff',
              fontWeight: 'bold',
              fontSize: '12px'
            }
          }
        },
        vBtn: {
          elevation: 0,
          blue: 'blue',
          black: '#000000',
          subscribedText: 'フォロー中',
          unsubscribedText: 'フォローする',
          subscribedStyle: {
            color: '#ffffff',
            fontWeight: 'bold',
            fontSize: '11px',
          },
          unsubscribedStyle: {
            color: '#ffffff',
            fontWeight: 'bold',
            fontSize: '11px'
          },
        },
        vRowLabel: {
          style: {
            maxHeight: '35px',
            fontWeight: 'bold',
          }
        },
        vColLabel: {
          blue: '#016aff',
          white: '#ffffff',
        },
        vColTags: {
          color: '#ffffff',
          fontWeight: 'bold',
          fontSize: '11px'
        }
      }
    },
    created() {
      setTimeout(() => {
        this.subscribed = this.space_data.subscribed
      }, 700)
    },
    methods: {
      subscribe() {
        sbscRepository.subscribe({
            user_id: this.$store.state.user.currentUser.id,
            space_id: this.space_data.id
          })
          .then(res => this.subscribeSuccessful(res))
          .catch(err => this.Failed(err))
      },
      unsubscribe() {
        sbscRepository.unsubscribe(this.space_data.id, this.$store.state.user.currentUser.id)
          .then(res => this.unsubscribeSuccessful(res))
          .catch(err => this.failed(err))
      },
      subscribeSuccessful(res) {
        this.subscribed = true
      },
      unsubscribeSuccessful(res) {
        this.subscribed = false
      },
      failed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ''
      },
      posterImg() {
        return this.base_tmdb_img_url + this.space_data.image_path
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
      }
    },
    computed: {
      vRowTopGrid() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'mt-7'
          case 'sm':
            return 'mt-7'
          case 'md':
            return 'mt-7'
          case 'lg':
            return 'mt-7'
          case 'xl':
            return 'mt-7'
        }
      },
      vColAvatarGrid() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-2 mt-1'
          case 'sm':
            return 'mt-7'
          case 'md':
            return 'mt-7'
          case 'lg':
            return 'mt-7 ml-5'
          case 'xl':
            return 'ml-10 mt-1'
        }
      },
      vRowNameGrid() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-13'
          case 'sm':
            return 'mt-7'
          case 'md':
            return 'mt-7'
          case 'lg':
            return 'mt-n2 ml-n15'
          case 'xl':
            return 'mt-n2 ml-n15'
        }
      },
      vBtnGrid() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-n1'
          case 'sm':
            return 'mt-7'
          case 'md':
            return 'mt-7'
          case 'lg':
            return 'mt-1 ml-14'
          case 'xl':
            return 'mt-n2 ml-n15'
        }
      },
      vColNameGrid() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-n6'
          case 'sm':
            return 'mt-7'
          case 'md':
            return 'mt-7'
          case 'lg':
            return 'ml-n4'
          case 'xl':
            return 'mt-n2 ml-n15'
        }
      },
      vColSubTitleGrid() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'mt-n2 ml-10'
          case 'sm':
            return 'mt-7'
          case 'md':
            return 'mt-7'
          case 'lg':
            return 'mt-n4 ml-n16'
          case 'xl':
            return 'mt-n4 ml-n16'
        }
      },
      vColLabelGrid() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-10'
          case 'sm':
            return 'mt-7'
          case 'md':
            return 'mt-7'
          case 'lg':
            return 'ml-n16'
          case 'xl':
            return 'ml-n16'
        }
      },
      vColSummaryGrid() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-10 mt-n4'
          case 'sm':
            return 'mt-7'
          case 'md':
            return 'mt-7'
          case 'lg':
            return 'mt-n3 ml-n16'
          case 'xl':
            return 'mt-n3 ml-n16'
        }
      },
      vRowTagsGrid() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'mt-2 ml-7'
          case 'sm':
            return 'mt-7'
          case 'md':
            return 'mt-7'
          case 'lg':
            return 'mt-3 ml-n16'
          case 'xl':
            return 'mt-3 ml-n16'
        }
      },
      vChipSmall() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return false
          case 'sm':
            return false
          case 'md':
            return false
          case 'lg':
            return true
          case 'xl':
            return true
        }
      },
      vChipXsmall() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return true
          case 'sm':
            return true
          case 'md':
            return true
          case 'lg':
            return false
          case 'xl':
            return false
        }
      },
      vAvatarHeight() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return '180'
          case 'sm':
            return '160'
          case 'md':
            return '160'
          case 'lg':
            return '250'
          case 'xl':
            return '260'
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
                  fontSize: '16px',
                  fontWeight: 'bold',
              }
        }
      }
    }
  }
</script>