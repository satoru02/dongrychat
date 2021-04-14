<template>
  <v-container :class="space_top.position">
    <space-header :space_data="this.space_data" />
    <v-tabs v-if="space_data" :style="tabs.style" :class="tabs.grid" :height="tabs.height" :width="tabs.width"
      :color="tabs.color">
      <v-tab :style="tab.style">
        {{tabs.chat}}
        <v-btn rounded :style="tab.btn.style" :elevation="tabs.btnElevation" :class="tabs.btnGrid"
          :color="tabs.btnColor" x-small v-text="space_data.comments_count" />
      </v-tab>
      <v-tab :style="tab.style">
        {{tabs.review}}
        <v-btn :style="tab.btn.style" :elevation="tabs.btnElevation" :class="tabs.btnGrid" :color="tabs.btnColor"
          x-small v-text="'0'" />
      </v-tab>
      <v-tab :style="tab.style">
        {{tabs.members}}
        <v-btn :style="tab.btn.style" :elevation="tabs.btnElevation" :class="tabs.btnGrid" :color="tabs.btnColor"
          x-small v-text="space_data.users.length" />
      </v-tab>
      <v-tab :style="tab.style">
        {{tabs.news}}
        <v-btn :style="tab.btn.style" :elevation="tabs.btnElevation" :class="tabs.btnGrid" :color="tabs.btnColor"
          x-small v-text="'0'" />
      </v-tab>
      <v-tab :style="tab.style" v-text="tabs.relationship" />
    </v-tabs>
    <v-divider />
    <div infinite-wrapper :style="wrapper.style">
      <space-comments :comments="comments" />
      <base-loader :handler="infiniteHandler" :wrapper="true" />
    </div>
    <v-text-field clearable :style="textField.style" :class="textField.grid" :background-color="textField.color"
      v-model="content" @keydown.enter="sendComment(content)" dense :placeholder="textField.placeholder" solo flat />
  </v-container>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios';
  import BaseInfiniteLoader from '../Base/BaseInfiniteLoader';
  import SpaceHeader from './SpaceHeader';
  import BaseLabel from '../Base/BaseLabel';
  import SpaceComments from './SpaceComments';
  // import Appearance from './SpaceAppearance';
  export default {
    name: 'SpaceTop',
    components: {
      'base-loader': BaseInfiniteLoader,
      'space-header': SpaceHeader,
      'space-comments': SpaceComments,
      'base-label': BaseLabel
      // "appearance": Appearance
    },
    data() {
      return {
        page: 1,
        pageSize: 10,
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w200`,
        dialog: false,
        followed: Boolean,
        user_pop: '',
        follower_length: '',
        following_length: '',
        items: [],
        params: {},
        comments: [],
        space_data: '',
        endpoint: '',
        users: '',
        content: '',
        subscribed: '',
        media: {
          tv: 'tv',
          mv: 'mv',
        },
        api: {
          from_search: `/api/v1/spaces/enter`,
          from_subscription: `/api/v1/spaces/enter_from_subscription`,
          for_subscription: `/api/v1/subscriptions`
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
        tabs: {
          chat: 'チャット',
          review: 'レビュー',
          members: 'メンバー',
          news: 'ニュース',
          relationship: '関連作',
          grid: 'mt-2',
          height: '48px',
          width: '70px',
          color: '#000000',
          btnGrid: 'ml-1 rounded-xl',
          btnColor: '#e9ecef',
          btnElevation: 0,
          style: {
            color: '#000000',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '13px',
          },
        },
        tab: {
          style: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '11px'
          },
          btn: {
            style: {
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '10px'
            }
          }
        },
        wrapper: {
          style: {
            maxHeight: '462px',
            height: '462px',
            overflow: 'scroll'
          }
        },
        colors: {
          chip: 'black',
          notifyBtn: 'red'
        },
        textField: {
          grid: 'mt-1 ml-6 mr-6 rounded-lg',
          color: '#e9ecef',
          placeholder: '#メッセージを送信',
          style: {
            position: 'static'
          }
        },
        space_top: {
          position: 'mt-n10 ml-n2',
          row: 'ml-1',
          col: 'mb-6 ml-n5',
          avatar: {
            size: '105',
            height: '135',
            round: 'rounded-lg'
          },
          title: {
            position: 'ml-1',
            style: {
              color: '#000000',
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '17px'
            }
          },
          subtitle: {
            position: 'ml-1',
            style: {
              color: '#000000',
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '11px'
            }
          }
        },
        listItemAction: {
          position: 'mt-1',
          style: {
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '7px',
            fontWeight: 'bold',
            color: '#6c757d'
          }
        }
      }
    },
    channels: {
      SpaceChannel: {
        connected() {},
        rejected() {},
        received(data) {
          // # when catch comment
          // # when catch user login
          // if (data["user_id"] === this.$store.state.currentUser.data.attributes.id){
          //   this.icon = true
          // } else {
          //   this.icon = false
          // }
          if (data) {
            if (data.attributes.space_id === this.space_data.id) {
              this.comments.unshift(data)
            }
          }
        },
        disconnected() {}
      }
    },
    created() {
      if (this.$route.name === this.space.tv.subscribed) {
        this.endpoint = this.api.from_subscription
        this.params = {
          space_id: this.$route.params.space_id,
          media: this.media.tv
        }
      } else if (this.$route.name === this.space.movie.subscribed) {
        this.endpoint = this.api.from_subscription
        this.params = {
          space_id: this.$route.params.space_id,
          media: this.media.mv
        }
      } else if (this.$route.name === this.space.tv.unsubscribed) {
        this.endpoint = this.api.from_search
        this.params = {
          name: this.$route.params.name,
          season: this.$route.params.season_number,
          episode: this.$route.params.episode_number,
          media: this.media.tv,
          episode_title: this.$route.params.episode_title,
          tmdb_tv_id: this.$route.params.tmdb_tv_id,
          image_path: this.$route.params.image_path,
          overview: this.$route.params.overview
        }
      } else if (this.$route.name === this.space.movie.unsubscribed) {
        this.endpoint = this.api.from_search
        this.params = {
          name: this.$route.params.name,
          media: this.media.mv,
          image_path: this.$route.params.image_path,
          tmdb_mv_id: this.$route.params.tmdb_mv_id,
          overview: this.$route.params.overview
        }
      }
    },
    methods: {
      infiniteHandler($state) {
        setTimeout(() => {
          this.params.page = this.page
          this.params.per_page = this.pageSize
          secureAxios.get(this.endpoint, {
              params: this.params
            })
            .then(res => {
              if (res.data.data.type === 'space') {
                this.setBlankSpace(res)
                $state.complete();
              } else {
                if (res.data.data.length) {
                  if (this.page === 1) {
                    this.setSpaceData(res)
                  }
                  this.page += 1;
                  this.comments.push(...res.data.data)
                  $state.loaded();
                } else {
                  $state.complete();
                }
              }
            })
        }, 50);
      },
      setSpaceData(res) {
        this.space_data = res.data.data[0].attributes.space.data.attributes
        this.createCable()
      },
      setBlankSpace(res) {
        this.space_data = res.data.data.attributes
        this.createCable()
      },
      createCable() {
        this.$cable.subscribe({
          channel: 'SpaceChannel',
          space: this.space_data.id
        })
      },
      sendComment(content) {
        if (content) {
          this.$cable.perform({
            channel: 'SpaceChannel',
            action: 'speak',
            data: {
              content: content,
              user_id: this.$store.state.currentUser.id,
              user_name: this.$store.state.currentUser.name,
              space_id: this.space_data.id,
              avatar_url: ''
            }
          })
        }
      }
    }
  }
</script>

<style scoped>
  .theme--light.v-divider {
    border-color: rgba(0, 1, 1, .06);
  }

  .v-input__slot::before {
    border-style: none !important;
  }
</style>