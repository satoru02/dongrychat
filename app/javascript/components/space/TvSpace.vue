<template>
  <!-- <v-row>
    <v-btn v-if="subscribed === false" @click="subscribe()">Subscribe</v-btn>
  </v-row> -->
  
  <v-container :class="space_top.position">
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
              <!-- <v-list-item-subtitle :class="space_top.subtitle.position" :style="space_top.subtitle.style"
                v-text="space_data.users.length + '人がお気に入り'" /> -->
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
          <v-col md=7 lg=7 xl=7 />
          <v-col md=2 lg=2 xl=2 :class="comment_part.countClass">
            <div :style="comment_part.style.count" v-text="formalizeTime(comment.attributes.created_at)" />
          </v-col>
        </v-row>
        <v-row :class="comment_part.text_row">
          <v-col md=12 lg=12 xl=12>
            <div :style="comment_part.style.content" v-text="comment.attributes.content" />
          </v-col>
        </v-row>
      </v-col>
    </v-row>
    <infinite-loading spinner="circles" v-if="this.$route.name ==='subscribedTvSpace'"
      @infinite="infiniteHandlerForSubscription">
      <span slot="no-more" />
      <!-- <div slot="no-results" v-text="'あなたが最初のメンバーです！'" /> -->
    </infinite-loading>
    <infinite-loading spinner="circles" v-if="this.$route.name ==='TvSpace'"
     @infinite="infiniteHandlerForTvSpace">
      <span slot="no-more" />
      <!-- <div slot="no-results" v-text="'あなたが最初のメンバーです！'" /> -->
    </infinite-loading>
    <v-row>
      <v-col lg=12 class="mt-16" />
    </v-row>
    <v-text-field class="mt-n9" background-color="#ffffff" v-model="content" @click:append-outer="sendComment(content)"
      dense type="text" no-details outlined　append-outer-icon="mdi-send" />
  </v-container>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios';
  import BaseComment from '../base/BaseComment';
  import InfiniteLoading from 'vue-infinite-loading';
  import moment from 'moment';
  const SPACE_ENDPOINT_FROM_SEARCH = `/api/v1/spaces/enter`;
  const SPACE_ENDPOINT_FROM_SUBSCRIPTION = `/api/v1/spaces/enter_from_subscription`;
  const SUBSCRIBE_ENDPOINT = `/api/v1/subscriptions`;
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
        content: '',
        subscribed: '',
        space_image: '',
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w200`,
        items: [],
        space_top: {
          position: 'mt-n6',
          row: 'ml-1',
          col: 'mb-6',
          avatar: {
            size: '45',
            height: '45',
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
          row: 'ml-1',
          col: 'ml-5 mt-n3',
          inner_col: 'ml-n3',
          countClass: 'mt-1',
          text_row: 'mt-n5',
          avatar: {
            class: 'rounded-lg mt-3',
            size: '40',
            height: '40'
          },
          style: {
            username: {
              color: '#000000',
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '13px'
            },
            count: {
              color: '#495057',
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '7px'
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
          position: 'mt-3 ml-4 mb-n8'
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
          if (data) {
            if (data.attributes.space_id === this.space_data.id){
              this.comments.push(data)
            }
          }
        },
        disconnected() {}
      }
    },
    methods: {
      infiniteHandlerForSubscription($state) {
        setTimeout(() =>{
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
          })}, 200);
      },
      infiniteHandlerForTvSpace($state) {
        setTimeout(() =>{
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
          })}, 200);
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
      sendComment(content) {
        if (content) {
          this.$cable.perform({
            channel: 'SpaceChannel',
            action: 'speak',
            data: {
              content: content,
              user_id: this.$store.state.currentUser.id,
              user_name: this.$store.state.currentUser.name,
              space_id: this.space_data.id
            }
          })
        }
      },
      formalizeTime(time) {
        return moment(time).format("YYYY/MM/DD hh:mm")
      },
    }
  }
</script>

<style scoped>
</style>