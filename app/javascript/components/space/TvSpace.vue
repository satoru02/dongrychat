<template>
  <!-- <v-row>
    <v-btn v-if="subscribed === false" @click="subscribe()">Subscribe</v-btn>
  </v-row> -->
  <v-container :class="space_top.position" infinite-wrapper>
    <v-row :class="space_top.row">
      <v-col md=12 lg=12 xl=12 :class="space_top.col">
        <v-list-item>
          <template v-slot:default="{}">
            <v-list-item-avatar :size="space_top.avatar.size" :height='space_top.avatar.height' tile
              :class="space_top.avatar.round">
              <v-img :src="base_tmdb_img_url + space_data.image_path" />
            </v-list-item-avatar>
            <v-list-item-content>
              <v-list-item-title :class="space_top.title.position" :style="space_top.title.style"
                v-text="space_data.name" />
              <v-list-item-subtitle :class="space_top.subtitle.position" :style="space_top.subtitle.style"
                v-text="space_data.users.length + '人がお気に入り'" />
            </v-list-item-content>
          </template></v-list-item>
        <v-divider :class="divider.position" />
      </v-col>
    </v-row>
    <v-row :class="comment_part.row" v-for="(comment, index) in comments" :key="index">
      <v-col md=1 lg=1 xl=1 :class="comment_part.col">
        <v-avatar :class="comment_part.avatar.class" tile :size='comment_part.avatar.size'
          :height='comment_part.avatar.height'>
          <img src="https://gravatar.com/avatar/fc04e69ffc05780882f85a264135142c?s=400&d=retro&r=x">
        </v-avatar>
      </v-col>
      <v-col md=10 lg=10 xl=10 :class="comment_part.inner_col">
        <v-row>
          <v-col md=3 lg=3 xl=3>
            <div :style="comment_part.style.username" v-text="comment.attributes.user.name" />
          </v-col>
          <v-col md=8 lg=8 xl=8 />
          <v-col md=1 lg=1 xl=1 :class="comment_part.countClass">
            <!-- <div :style="comment_part.style.count" v-text="comment.created_at" /> -->
          </v-col>
        </v-row>
        <v-row :class="comment_part.text_row">
          <v-col md=12 lg=12 xl=12>
            <div :style="comment_part.style.content" v-text="comment.attributes.content" />
          </v-col>
        </v-row>
      </v-col>
    </v-row>
    <infinite-loading v-if="this.$route.name ==='subscribedTvSpace'" @infinite="infiniteHandlerForSubscription" />
    <infinite-loading v-if="this.$route.name ==='TvSpace'" @infinite="infiniteHandlerForTvSpace" />
    <v-row>
      <v-col lg=12 />
    </v-row>
    <v-text-field class="mt-n9" background-color="#ffffff" v-model="comment" @click:append-outer="sendComment(comment)"
      dense type="text" no-details outlined　append-outer-icon="mdi-send" />
  </v-container>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios';
  import BaseComment from '../base/BaseComment';
  const SPACE_ENDPOINT_FROM_SEARCH = `/api/v1/spaces/enter`;
  const SPACE_ENDPOINT_FROM_SUBSCRIPTION = `/api/v1/spaces/enter_from_subscription`;
  const SUBSCRIBE_ENDPOINT = `/api/v1/subscriptions`;
  import InfiniteLoading from 'vue-infinite-loading';
  // import Appearance from './Appearance';

  export default {
    name: 'TvSpace',
    components: {
      // "appearance": Appearance
      'comment': BaseComment,
      'infinite-loading': InfiniteLoading,
    },
    data() {
      return {
        space_data: '',
        users: '',
        media: 'tv',
        comments: [],
        comment: '',
        subscribed: '',
        space_image: '',
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w200`,
        items: [],
        space_top: {
          position: 'mt-n5',
          row: 'ml-1',
          col: 'mb-6',
          avatar: {
            size: '75',
            height: '105',
            round: 'rounded-lg'
          },
          title: {
            position: 'ml-1 mt-n3',
            style: {
              color: '#000000',
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '13px'
            }
          },
          subtitle: {
            position: 'ml-1 mb-n2 mt-1',
            style: {
              color: '#000000',
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '6px'
            }
          }
        },
        comment_part: {
          row: 'mt-1 ml-1',
          col: 'ml-5 mt-n3',
          inner_col: 'ml-n3',
          countClass: 'mt-1',
          text_row: 'mt-n6',
          avatar: {
            class: 'rounded-lg mt-3',
            size: '40',
            height: '40'
          },
          style: {
            username: {
              color: '#495057',
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '13px'
            },
            count: {
              color: '#495057',
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '9px'
            },
            content: {
              color: '#000000',
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '13px'
            }
          }
        },
        listItemAction: {
          position: 'mt-1',
          style: {
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '7px',
            fontWeight: 'bold',
            color: '#adb5bd'
          }
        },
        divider: {
          position: 'mt-3 ml-4 mb-n5'
        },
        page: 1,
        pageSize: 10,
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
          console.log(data)
        },
        disconnected() {}
      }
    },
    created() {
      this.setSpace($state)
    },
    methods: {
      setSpace($state) {
        if (this.$route.name === 'subscribedTvSpace') {
          this.infiniteHandlerForSubscription($state)
        } else if (this.$route.name === 'TvSpace') {
          this.infiniteHandlerForTvSpace($state)
        }
      },
      infiniteHandlerForSubscription($state) {
        secureAxios.get(SPACE_ENDPOINT_FROM_SUBSCRIPTION, {
            params: {
              space_id: this.$route.params.space_id,
              page: this.page,
              per_page: this.pageSize,
            }
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
      },
      infiniteHandlerForTvSpace($state) {
        secureAxios.get(SPACE_ENDPOINT_FROM_SEARCH, {
            params: {
              name: this.$route.params.name,
              season: this.$route.params.season_number,
              episode: this.$route.params.episode_number,
              media: this.media,
              episode_title: this.$route.params.episode_title,
              tmdb_tv_id: this.$route.params.tmdb_tv_id,
              image_path: this.$route.params.image_path,
              page: this.page,
              per_page: this.pageSize,
            }
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
      subscribe() {
        secureAxios.post(SUBSCRIBE_ENDPOINT, {
            user_id: this.$store.state.currentUser.id,
            space_id: this.space_data.id
          })
          .then(res => this.subscribeSuccessful(res))
          .catch(err => this.subscribeFailed(err))
      },
      subscribeSuccessful(res) {
        console.log(res)
      },
      subscribeFailed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ''
      },
      sendComment(comment) {
        if (comment) {
          this.$cable.perform({
            channel: 'SpaceChannel',
            action: 'speak',
            data: {
              comment: comment,
              user_id: this.$store.state.currentUser.id,
              space_id: this.space_data.id
            }
          })
        }
      }
    }
  }
</script>

<style scoped>
</style>