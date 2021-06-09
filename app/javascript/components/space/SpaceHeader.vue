<template>
  <v-img :src="posterImg()" position="top right" gradient="to left, rgba(0 0 0 / 44%), rgb(0 0 0)"
    class="mt-5 rounded-lg" height="253">
    <v-row v-if="space_data" class="mt-n7">
      <v-col cols=2 sm=2 md=2 lg=2 xl=2 :class="vColAvatarGrid">
        <v-avatar class="rounded ml-6 mt-7" :size="vAvatar.size" :height='vAvatarHeight'>
          <v-img :src="posterImg()" />
        </v-avatar>
      </v-col>
      <v-col cols=9 sm=9 md=9 lg=9 xl=9 class="ml-7 mt-8">
        <v-row dense :style="vRowLabel.style">
          <v-col cols=12 sm=12 md=12 lg=12 xl=12>
            <base-label class="ml-9 rounded-xl" font_size="13px" v-if="space_data.media === media.tv" :label="true"
              :small="false" :color="'#4ad66d'" :outlined="true" :text_color="'#4ad66d'" :season="space_data.season"
              :episode="space_data.episode" :title="space_data.episode_title" />
            <v-chip class="ml-9 rounded-xl" v-if="space_data.media === media.mv" outlined label :color="'yellow'"
              :style="vChip.label.style" v-text="'MOVIE'" />
          </v-col>
        </v-row>
        <v-row class="mt-1 ml-n5">
          <v-col lg=1></v-col>
          <v-col cols=8 sm=10 md=10 lg=11 xl=10>
            <v-hover v-slot="{ hover }">
              <span
                @click="space_data.media === media.tv ? moveDetails(space_data.tmdb_comp_id, space_data.name, space_data.season, 'Tv') : moveDetails(space_data.tmdb_mv_id, space_data.name, null, 'Mv')"
                :style="hover ? vColTitle.hoverStyle : vColTitle.style" v-text="space_data.name" />
            </v-hover>
            <!-- <v-chip class="mt-n1 ml-2" :style="vChip.title.style" :color="vChip.title.color" :small="vChipSmall"
              :x-small="vChipXsmall" v-text="space_data.users.data.length" /> -->
          </v-col>

          <!-- <v-col cols=2 sm=2 md=2 lg=1 xl=2>
            <v-btn icon :style="subscribed === true ? vBtn.subscribedStyle : vBtn.unsubscribedStyle"
              @click="subscribed === true ? unsubscribe() : subscribe()" :elevation='vBtn.elevation'
              :color="subscribed === true ? 'blue' : 'yellow'" :outlined="subscribed === true ? false : false">
              {{subscribed === true ? vBtn.subscribedText : vBtn.unsubscribedText}}
              <v-icon size=20>
                mdi-heart
              </v-icon>
            </v-btn>
          </v-col>
     -->
          <!-- <v-col cols=2 sm=2 md=2 lg=1 xl=2>
            <v-btn icon @click="openReviewDialog()" :color="'black'">
              <v-icon size=20>mdi-pen</v-icon>
            </v-btn>
          </v-col> -->

        </v-row>
        <!-- <v-row dense class="mt-n5 ml-9">
          <v-col cols=12 sm=12 md=12 lg=12 xl=12 :style="vColSubTitle.style" v-text="'@' + space_data.name" />
        </v-row> -->
        <!-- <v-row dense :style="vRowLabel.style">
          <v-col cols=12 sm=12 md=12 lg=12 xl=12>
            <base-label class="ml-10 rounded-xl" font_size="13px" v-if="space_data.media === media.tv" :label="true" :small="false"
              :color="'#4ad66d'" :outlined="true" :text_color="'#4ad66d'" :season="space_data.season"
              :episode="space_data.episode" :title="space_data.episode_title" />
            <v-chip class="ml-10" v-if="space_data.media === media.mv" small label :color="vChip.label.yellow"
              :style="vChip.label.style" v-text="vChip.label.movie" />
          </v-col>
        </v-row> -->
        <v-row class="mt-n4">
          <v-col class="ml-10" cols=11 sm=12 md=12 lg=11 xl=12 :style="vColSummaryStyle"
            v-text="space_data.overview != null ? space_data.overview : dummyText" />
        </v-row>
        <v-row class="mt-10 ml-7">
          <v-col cols=12 sm=12 md=12 lg=12 xl=12 :style="vColTags.style" small>
            <v-chip label outlined class="mr-2 mb-2 rounded-xl" :style="vChip.tags.style"
              v-for="(tag, index) in space_data.tag_list.slice(0, 3)" :key="index" :color="vChip.tags.color" x-small
              v-text="'#' + tag" />
          </v-col>
        </v-row>
      </v-col>
    </v-row>

    <v-dialog width="400" v-model="reviewDialog">
      <v-card color="#ffffff" auto-grow height="460" class="rounded-lg">
        <v-card-title></v-card-title>
        <v-card-text>
          <v-container>
            <v-row class="mt-n6">
              <v-col lg=12>
                <v-textarea auto-grow row-height="63" v-model="reviewContent"
                  :rules="[rules.requiredContents, rules.maxLengthOfContents]" placeholder="感想・レビューを記入する。" outlined flat
                  solo></v-textarea>
              </v-col>
            </v-row>
            <v-row class="mt-n3">
              <v-col lg=12>
                <v-btn @click="makeReviews()" block elevation=0 color="blue">登録する</v-btn>
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>
      </v-card>
    </v-dialog>
  </v-img>
</template>

<script>
  import '@mdi/font/css/materialdesignicons.css';
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const sbscRepository = RepositoryFactory.get('subscriptions');
  const reviewsRepository = RepositoryFactory.get('reviews');

  export default {
    name: 'SpaceHeader',
    components: {
      'base-label': () => import( /* webpackPrefetch: true */ '../Base/BaseLabel'),
    },
    props: ['space_data'],
    data() {
      return {
        base_tmdb_img_url: `https://image.tmdb.org/t/p/original`,
        reviewDialog: false,
        // reviewTitle: '',
        reviewContent: '',
        api: {
          for_subscription: `/api/v1/subscriptions`
        },
        rules: {
          // requiredTitle: (v) => !!v || 'タイトルを入力してください。',
          // maxLengthOfTitle: (v) => v.length <= 100 || '100字以下のタイトルを入力してください。',
          requiredContents: (v) => !!v || '内容を入力してください。',
          maxLengthOfContents: (v) => v.length <= 255 || '255字以下の内容を入力してください。'
        },
        media: {
          tv: 'tv',
          mv: 'mv',
        },
        dummyText: '',
        params: {},
        subscribed: Boolean,
        vAvatar: {
          size: '145',
          height: '180',
        },
        vColTitle: {
          style: {
            color: '#ffffff',
            fontWeight: 'bold',
            fontSize: '22px',
            cursor: 'pointer'
          },
          hoverStyle: {
            color: '#3a86ff',
            fontWeight: 'bold',
            fontSize: '22px',
            cursor: 'pointer'
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
            }
          },
          tags: {
            color: '#ffffff',
            style: {
              color: '#ffffff',
              fontWeight: 'bold',
              fontSize: '11px'
            }
          }
        },
        vBtn: {
          elevation: 0,
          blue: 'blue',
          black: '#000000',
          subscribedText: 'お気に入りに追加済み',
          unsubscribedText: 'お気に入りに追加する',
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
      makeReviews() {
        reviewsRepository.post({
            user_id: this.$store.state.user.currentUser.id,
            space_id: this.space_data.id,
            content: this.reviewContent
          })
          .then(res => this.postSuccessful(res))
          .catch(err => this.failed(err))
      },
      postSuccessful(res) {
        this.reviewDialog = false
        this.$router.go(0)
      },
      openReviewDialog() {
        this.reviewDialog = true
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
            return 'mt-1'
          case 'xl':
            return 'ml-1 mt-1'
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
            return '220'
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
                height: '60px',
                maxHeight: '60px',
                overflow: 'scroll',
                overflowY: 'scroll',
            }
            case 'lg' || 'xl':
              return {
                color: '#ffffff',
                  // fontWeight: 'bold',
                  fontSize: '14px',
                  fontWeight: 'bold',
                  height: '93px',
                  maxHeight: '93px',
                  overflow: 'scroll',
                  overflowY: 'scroll',
              }
        }
      }
    }
  }
</script>