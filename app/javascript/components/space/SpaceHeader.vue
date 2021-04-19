<template>
  <v-row :class="grid.header" v-if="space_data">
    <v-col md=2 lg=2 xl=2>
      <v-avatar :class="avatar.round" :size="avatar.size" :height='avatar.height' tile>
        <v-img :src="posterImg()" />
      </v-avatar>
    </v-col>
    <v-col md=10 lg=10 xl=10>
      <v-row :class='grid.titlePart'>
        <v-col md=8 lg=9 xl=8 :class='grid.title'>
          <div :style="style.title">
            {{space_data.name}}
            <v-chip :color="colors.yellow" :style="style.chip" class="mt-n1 ml-2" small>
              {{space_data.users.length}}
            </v-chip>
          </div>
        </v-col>
        <v-col md=2 lg=2 xl=2>
          <v-btn @click="subscribed === true ? unsubscribe() : subscribe()" :elevation='btn.elevation' :class="grid.btn"
            small :color="subscribed === true ? colors.green : colors.black"
            :outlined="subscribed === true ? false : true"
            :style="subscribed === true ? style.subscribedBtn : style.unsubscribedBtn"
            v-text="subscribed === true ? btn.subscribedText : btn.unsubscribedText" />
        </v-col>
      </v-row>
      <v-row dense>
        <v-col md=12 lg=12 xl=12>
          <div :class="grid.subName" :style="style.subName" v-text="'@' + space_data.name" />
        </v-col>
      </v-row>
      <v-row dense style="max-height: 35px;">
        <v-col md=12 lg=12 xl=12 :class="grid.label">
          <base-label v-if="space_data.media === media.tv" :small="true" :style="style.label" :color="colors.black"
            :text-color="colors.chip" :season="space_data.season" :episode="space_data.episode"
            :title="space_data.episode_title" />
          <v-chip v-if="space_data.media === media.mv" small outlined label :color="colors.black" :style="style.label"
            v-text="'Movie'" />
        </v-col>
      </v-row>
      <v-row>
        <v-col md=12 lg=12 xl=12 :class="grid.summary">
          <div :style="style.summary" v-text="space_data.overview != null ? space_data.overview : dummyText" />
        </v-col>
      </v-row>
      <v-row class="mt-n1">
        <v-col md=12 lg=12 xl=12 :style="style.tag" small>
          <v-chip class="mr-2" v-for="(tag, index) in space_data.tag_list" :key="index" color="#293241" :style="style.tag" small v-text="'#' + tag" />
        </v-col>
      </v-row>
    </v-col>
  </v-row>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios';
  import BaseLabel from '../Base/BaseLabel';
  export default {
    name: 'SpaceHeader',
    components: {
      'base-label': BaseLabel
    },
    props: ['space_data'],
    created() {
      setTimeout(() => {
        this.subscribed = this.space_data.subscribed
      }, 700)
    },
    data() {
      return {
        dummyText: '',
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w200`,
        subscribed: Boolean,
        api: {
          for_subscription: `/api/v1/subscriptions`
        },
        btn: {
          subscribedText: 'チャットに参加中',
          unsubscribedText: 'チャットに参加',
          elevation: 0
        },
        media: {
          tv: 'tv',
          mv: 'mv',
        },
        colors: {
          black: '#000000',
          green: 'orange',
          yellow: '#f7e733',
        },
        avatar: {
          size: '135',
          height: '205',
          round: 'rounded-lg'
        },
        grid: {
          header: 'ml-1 mt-7',
          titlePart: 'mt-n2 ml-n14',
          title: 'ml-9',
          chip: 'ml-n3 mt-1',
          btn: '',
          subName: 'mt-n3 ml-n2',
          label: 'mt-1 ml-n2',
          summary: 'mt-n2 ml-n2',
          mdi: 'ml-5 mr-n16 mt-1'
        },
        mdi: {
          dotsVertical: 'mdi-dots-vertical'
        },
        style: {
          title: {
            color: '#000000',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '16px',
            // lineHeight: '2.3'
            // letterSpacing: 'px'
            // width: '270px',
            // maxWidth: '300px',
          },
          subscribedBtn: {
            color: '#ffffff',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '11px',
          },
          unsubscribedBtn: {
            color: '#000000',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '11px'
          },
          subName: {
            color: '#6c757d',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '11px',
          },
          year: {
            color: '#000000',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '14px'
          },
          label: {
            color: '#000000',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '11px',
            // height: '25px',
          },
          summary: {
            color: '#000000',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '12px',
            height: '70px',
            maxHeight: '70px',
            overflow: 'scroll',
            overflowY: 'scroll',
          },
          fav: {
            color: '#6c757d',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '10px'
          },
          tag: {
            color: '#ffffff',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '11px'
          },
          chip: {
            // height: '20px',
            color: '#000000',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
          }
        },
        divider: {
          position: 'mt-4 mb-n8'
        },
      }
    },
    methods: {
      subscribe() {
        secureAxios.post(this.api.for_subscription, {
            user_id: this.$store.state.currentUser.id,
            space_id: this.space_data.id
          })
          .then(res => this.subscribeSuccessful(res))
          .catch(err => this.Failed(err))
      },
      unsubscribe() {
        secureAxios.delete(this.api.for_subscription + `/${this.space_data.id}` +
            `/${this.$store.state.currentUser.id}`)
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
      posterImg(){
        return this.base_tmdb_img_url + this.space_data.image_path
      }
    }
  }
</script>