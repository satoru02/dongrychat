<template>
  <v-row :class="grid.header">
    <v-col md=2 lg=2 xl=2>
      <v-avatar :class="avatar.round" :size="avatar.size" :height='avatar.height' tile>
        <v-img :src="base_tmdb_img_url + space_data.image_path" />
      </v-avatar>
    </v-col>
    <v-col md=10 lg=10 xl=10>
      <v-row :class='grid.titlePart'>
        <v-col md=8 lg=8 xl=8 :class='grid.title'>
          <div :style="style.title">
            {{space_data.name}}
            <v-text class="ml-n2" :style="style.year">（2021）</v-text>
            <v-chip :color="colors.yellow" :class="grid.chip" v-text="space_data.users.length" :style="style.chip"
              small />
          </div>
        </v-col>
        <v-col md=2 lg=2 xl=2>
          <v-btn @click="subscribed === true ? unsubscribe() : subscribe()" :elevation='btn.elevation' :class="grid.btn"
            small :color="subscribed === true ? colors.red : colors.black"
            :outlined="subscribed === true ? false : true"
            :style="subscribed === true ? style.subscribedBtn : style.unsubscribedBtn"
            v-text="subscribed === true ? btn.subscribedText : btn.unsubscribedText" />
        </v-col>
        <v-col md=1 lg=1 xl=1 :class="grid.mdi">
          <v-icon v-text="mdi.dotsVertical" size="22" />
        </v-col>
      </v-row>
      <v-row dense>
        <v-col md=12 lg=12 xl=12>
          <div :class="grid.subName" :style="style.subName" v-text="'@' + space_data.name" />
        </v-col>
      </v-row>
      <v-row dense>
        <v-col md=12 lg=12 xl=12 :class="grid.label">
          <base-label :small="true" :style="style.label" v-if="space_data.media === media.tv" :color="colors.black"
            :text-color="colors.chip" :season="space_data.season" :episode="space_data.episode"
            :title="space_data.episode_title" />
        </v-col>
      </v-row>

      <v-row>
        <v-col md=11 lg=11 xl=11 :class="grid.summary">
          <div :style="style.summary" v-text="space_data.overview != null ? space_data.overview : dummyText" />
        </v-col>
      </v-row>

      <v-row class="mt-5 ml-1">
        <v-col md=4 lg=1 xl=4 :style="style.fav">
        </v-col>
        <v-col md=2 lg=2 xl=2 class="ml-n6">
          <v-chip color="#000000" :style="style.tag" small>#TV</v-chip>
        </v-col>
        <v-col md=2 lg=3 xl=2 class="ml-n10">
          <v-chip color="#000000" :style="style.tag" small>#Netflix Original</v-chip>
        </v-col>
        <v-col md=2 lg=3 xl=2 class="ml-n6">
          <v-chip color="#000000" :style="style.tag" small>#Drama</v-chip>
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
    props: {
      space_data: {
        type: Object,
        required: true,
      },
    },
    created() {
      setTimeout(() => {
        this.subscribed = this.space_data.subscribed
      }, 700)
    },
    data() {
      return {
        dummyText: '正義の象徴を失った世界を救ファルコンとウィンター・ソルジャーの新たな戦いを描くクライム・アクション開幕！ これは、新たな”キャプテン・アメリカ”誕生',
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
          red: '#ef233c',
          yellow: 'yellow'
        },
        avatar: {
          size: '135',
          height: '205',
          round: 'rounded-lg'
        },
        grid: {
          header: 'ml-1 mt-6',
          titlePart: 'mt-n2',
          title: 'ml-9',
          chip: 'ml-3 mt-n1',
          btn: 'ml-n5',
          subName: 'ml-9 mt-n3',
          label: 'ml-9 mt-2',
          summary: 'ml-9 mt-n2',
          mdi: 'ml-3 mt-1'
        },
        mdi: {
          dotsVertical: 'mdi-dots-vertical'
        },
        style: {
          title: {
            color: '#000000',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '17px'
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
            fontSize: '12px'
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
            fontSize: '11px'
          },
          summary: {
            color: '#000000',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '12px'
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
            fontSize: '12px',
            height: '22px',
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
          .catch(err => this.Failed(err))
      },
      subscribeSuccessful(res) {
        this.subscribed = true
      },
      unsubscribeSuccessful(res) {
        this.subscribed = false
      },
      Failed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ''
      },
    }
  }
</script>