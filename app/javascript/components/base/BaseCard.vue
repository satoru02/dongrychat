<template>
  <div class="mt-n4 ml-n3">
    <v-hover v-slot="{ hover }" v-for="(item, index) in items" :key="index">
    <v-sheet style="cursor: pointer;" :elevation="hover ? 16 : 0" class="rounded-lg mb-7" @click="enterSpace(item.attributes)">
    <v-img
     :src="posterImg(item.attributes)" position="center right"
      gradient="to left, rgba(0 0 0 / 18%), rgb(0 0 0)" class="rounded-lg" height="146px">
      <v-row class="mt-n5">
        <v-col cols=2 sm=2 md=2 lg=1 xl=2>
          <v-avatar class="rounded ml-6 mt-6" size="80" height='113'>
            <v-img :src="posterImg(item.attributes)" />
          </v-avatar>
        </v-col>
        <v-col cols=9 sm=9 md=9 lg=9 xl=9 class="ml-7 mt-6">
          <v-row dense :style="vRowLabel.style">
            <v-col cols=12 sm=12 md=12 lg=12 xl=12>
              <base-label class="ml-8 rounded-xl" font_size="13px" :label="true" v-if="item.attributes.media === 'tv'"
                :x_small="true" :color="'#4ad66d'" :outlined="true" :text_color="'#4ad66d'"
                :season="item.attributes.season" :episode="item.attributes.episode"
                :title="item.attributes.episode_title" />
              <v-chip class="ml-9 rounded-xl" v-if="item.attributes.media === media.mv" x-small outlined label
                :color="'yellow'" :style="vChip.label.style" v-text="'MOVIE'" />
            </v-col>
          </v-row>
          <v-row class="ml-n6 mt-n1">
            <v-col lg=1></v-col>
            <v-col cols=8 sm=10 md=10 lg=11 xl=10>
              <span :style="vColTitle.style">{{item.attributes.name}}</span>
              <span>
                <v-btn x-small elevation=0 :style="vChip.label.style" v-if="$vuetify.breakpoint.name != 'xs'" color="#fee440" class="rounded-xl ml-2 mt-n2">
                {{item.attributes.users.length}}
                </v-btn>
              </span>
            </v-col>
          </v-row>

          <v-row v-if="item.attributes.latest_comment.content" class="mt-n5">
            <v-col class="ml-9" cols=11 sm=12 md=12 lg=11 xl=12 :style="vColSummaryStyle"
            >{{item.attributes.latest_comment.content}}</v-col>
          </v-row>

          <v-row :class="gridBottom" dense>
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 :class="gridIcon">
              <v-avatar size="21">
                <v-img v-if="item.attributes.latest_comment_user.data.attributes.avatar_url" :src="item.attributes.latest_comment_user.data.attributes.avatar_url" />
                <v-img v-else src="https://gravatar.com/avatar/6ee07d61d8988eff9a020e93752680c4?s=400&d=robohash&r=x" />
              </v-avatar>
            </v-col>
            <v-col cols=10 sm=10 md=10 lg=5 xl=10 :class="gridTime">
              <span class="user-name" v-if="item.attributes.latest_comment_user !== null">
                {{item.attributes.latest_comment_user.data.attributes.name}}
              </span>
              <span class="user-name" v-else>
                no name
              </span>
              <span class="time-text" v-if="item.attributes.latest_comment !== null">
                {{formalizeTime(item.attributes.latest_comment.created_at)}}
              </span>
              <span class="time-text" v-else>
                12:00
              </span>
            </v-col>
            <v-col cols=2 sm=3 md=1 lg=1 xl=1 />
          </v-row>
        </v-col>
      </v-row>
    </v-img>
    </v-sheet>
    </v-hover>
  </div>
</template>

<script>
  import '@mdi/font/css/materialdesignicons.css';
  import moment from 'moment';
  moment.locale('ja')

  export default {
    name: 'BaseCard',
    components: {
      'base-label': () => import( /* webpackPrefetch: true */ '../Base/BaseLabel'),
      'icon-poster': () => import( /* webpackPrefetch: true */ '../Icons/IconPoster'),
    },
    props: {
      items: '',
      loading: false,
    },
    data() {
      return {
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w500`,
        // loading: false,
        unhoverStyle: {
          elevation: '0'
        },
        hoverStyle: {
          elevation: '1'
        },
        descText: {
          color: '#111111',
          fontSize: '19px',
          height: '82px',
          fontWeight: 'bold'
        },
        mobileText: {
          color: '#111111',
          fontSize: '15px',
          height: '53px',
          fontWeight: 'bold'
        },
        descWidth: {
          maxHeight: '40px',
        },
        mobileWidth: {
          maxHeight: '70px',
        },
        //
        base_tmdb_img_url: `https://image.tmdb.org/t/p/original`,
        api: {
          for_subscription: `/api/v1/subscriptions`
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
            fontSize: '20px',
            cursor: 'pointer',
            lineHeight: '30px'
          },
          hoverStyle: {
            color: '#3a86ff',
            fontWeight: 'bold',
            fontSize: '20px',
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
              color: "#000000",
              fontSize: '14px',
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
    computed: {
      gridRank() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'mt-8 ml-2 mr-4'
          case 'sm':
          case 'md':
          case 'lg':
          case 'xl':
            return 'ml-4 mt-8'
        }
      },
      gridAvatar() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-n10'
          case 'sm':
          case 'md':
          case 'lg':
          case 'xl':
            return 'ml-n8'
        }
      },
      gridRight() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-3 mt-n1'
          case 'sm':
            return 'ml-4 mt-n1'
          case 'md':
          case 'lg':
          case 'xl':
            return 'ml-8'
        }
      },
      gridIcon() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-5'
          case 'sm':
          case 'md':
          case 'lg':
          case 'xl':
            return 'ml-14 mt-1'
        }
      },
      gridTime() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-1 mt-1'
          case 'sm':
          case 'md':
            return 'ml-n4'
          case 'lg':
          case 'xl':
            return 'ml-n5 mt-1'
        }
      },
      gridComment() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'desc-text mt-1 ml-2'
          case 'sm':
          case 'md':
          case 'lg':
          case 'xl':
            return 'desc-text ml-1 mt-n1'
        }
      },
      gridNumberText() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return {
              fontSize: '8px',
                color: '#5d666e'
            }
            case 'sm':
            case 'md':
            case 'lg':
            case 'xl':
              return {
                fontSize: '13px',
                color: '#5d666e'
              }
        }
      },
      gridNumber() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'mt-2 ml-n1'
          case 'sm':
          case 'md':
          case 'lg':
          case 'xl':
            return ' mt-1'
        }
      },
      gridBottom() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'mt-1'
          case 'sm':
          case 'md':
          case 'lg':
          case 'xl':
            return 'ml-n6 mt-3'
        }
      },
      gridLabel() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'label ml-5 mt-1'
          case 'sm':
            return 'label ml-1 mt-1'
          case 'md':
          case 'lg':
          case 'xl':
            return 'label'
        }
      },
      gridName() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-6'
          case 'sm':
            return 'ml-2'
          case 'md':
          case 'lg':
          case 'xl':
            return ''
        }
      },
      vColSummaryStyle() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs' || 'sm' || 'md':
            return {
              color: '#111111',
                fontWeight: 'bold',
                fontSize: '12px',
                height: '15px',
                maxHeight: '15px',
                overflow: 'scroll',
                overflowY: 'scroll',
            }
            case 'lg' || 'xl':
              return {
                color: '#ffffff',
                  // fontWeight: 'bold',
                  fontSize: '12px',
                  fontWeight: 'bold',
                  height: '32px',
                  maxHeight: '32px',
                  overflow: 'scroll',
                  overflowY: 'scroll',
              }
        }
      }

    },
    methods: {
      enterSpace(space) {
        if (space.media === 'tv') {
          this.$router.push({
            name: 'TvSpace',
            params: {
              season_number: space.season,
              episode_number: space.episode,
              name: space.name,
              episode_title: space.episode_title,
              tmdb_tv_id: space.tmdb_tv_id,
              image_path: space.image_path,
              media: space.media,
            }
          })
        } else if (space.media === 'mv') {
          this.$router.push({
            name: 'MvSpace',
            params: {
              image_path: space.image_path,
              tmdb_mv_id: space.tmdb_mv_id,
              name: space.name,
              media: space.media,
            }
          })
        }
      },
      formalizeTime(time) {
        return moment(time).fromNow()
      },
      posterImg(item) {
        return this.base_tmdb_img_url + item.image_path
      },
    }
  }
</script>

<style scoped>
  .ranking {
    font-size: 12px;
    font-weight: bold;
    color: #6c757d;
  }

  .label {
    font-size: 15px;
    font-weight: bold;
    color: #ced4da;
  }

  .movie-label {
    font-size: 11px;
    font-weight: bold;
  }

  .user-count {
    font-size: 12px;
    font-weight: bold;
    color: #6c757d;
  }

  .tag-text {
    font-size: 5px;
    color: #111111;
  }

  .number-text {
    font-size: 13px;
    font-weight: bold;
    color: #5d666e;
  }

  .user-name {
    font-weight: bold;
    color: #6c757d;
    font-size: 13px;
  }

  .time-text {
    font-weight: bold;
    color: #6c757d;
    font-size: 12px;
  }

  .desc-text {
    color: #111111;
    font-size: 14px;
    line-height: 16px;
    height: 34px;
    max-height: 34px;
    overflow: auto;
  }

  .title-text {
    font-weight: bold;
    font-size: 16px;
    color: #111111;
    height: 53px;
  }

  .v-divider {
    border-color: rgba(0, 0, 0, 0.082);
  }
</style>