<template>
  <v-row :class="grid.header" v-if="space_data">
    <v-col md=2 lg=2 xl=2 class="ml-5 mt-1">
      <v-avatar :class="avatar.round" :size="avatar.size" :height='avatar.height' tile>
        <v-img :src="posterImg()" />
      </v-avatar>
    </v-col>
    <v-col md=10 lg=9 xl=10>
      <v-row :class='grid.titlePart'>
        <v-col md=8 lg=10 xl=8 :class='grid.title'>
          <!-- <v-hover v-slot="{hover}"> -->
          <div>
          <v-hover v-slot="{hover}">
            <span
             @click="space_data.media === media.tv ? moveDetails(space_data.tmdb_comp_id, space_data.name, space_data.season, 'Tv') : moveDetails(space_data.tmdb_mv_id, space_data.name, null, 'Mv')"
             style="cursor: pointer" :style="hover ? style.hoverTitle : style.title">{{space_data.name}}</span>
          </v-hover>
            <v-chip :color="colors.yellow" :style="style.chip" class="mt-n1 ml-2" small>
              {{space_data.users.data.length}}
            </v-chip>
          </div>
        </v-col>
        <v-col md=2 lg=2 xl=2>
          <v-btn @click="subscribed === true ? unsubscribe() : subscribe()" :elevation='btn.elevation' :class="grid.btn"
            small :color="subscribed === true ? colors.blue : colors.black"
            :outlined="subscribed === true ? false : true"
            :style="subscribed === true ? style.subscribedBtn : style.unsubscribedBtn"
            >
            {{subscribed === true ? btn.subscribedText : btn.unsubscribedText}}
          </v-btn>
        </v-col>
      </v-row>
      <v-row dense>
        <v-col md=12 lg=12 xl=12>
          <!-- <v-hover v-slot="{hover}"> -->
        <div
            :class="grid.subName" :style="style.subName" v-text="'@' + space_data.name" />
          <!-- </v-hover> -->
        </v-col>
      </v-row>
      <v-row dense style="max-height: 35px;">
        <v-col md=12 lg=12 xl=12 :class="grid.label">
          <base-label v-if="space_data.media === media.tv" :label="true" :small="true" :color="'blue'" :outlined="true"
            :text-color="'#ffffff'" :season="space_data.season" :episode="space_data.episode"
            :title="space_data.episode_title" />
          <v-chip v-if="space_data.media === media.mv" small outlined label :color="colors.yellow" :style="style.label"
            v-text="'Movie'" />
        </v-col>
      </v-row>
      <v-row>
        <v-col md=12 lg=12 xl=12 :class="grid.summary">
          <div :style="style.summary" v-text="space_data.overview != null ? space_data.overview : dummyText" />
        </v-col>
      </v-row>
      <v-row class="mt-n4 ml-n16">
        <v-col md=12 lg=12 xl=12 :style="style.tag" small>
          <v-chip class="mr-2" v-for="(tag, index) in space_data.tag_list" :key="index" color="#293241"
            :style="style.tag" x-small v-text="'#' + tag" />
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
        testCode: 'テスト',
        dummyText: '',
        params: {},
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w200`,
        subscribed: Boolean,
        api: {
          for_subscription: `/api/v1/subscriptions`
        },
        btn: {
          subscribedText: 'スペースに参加中',
          unsubscribedText: 'スペースに参加',
          elevation: 0
        },
        media: {
          tv: 'tv',
          mv: 'mv',
        },
        colors: {
          black: '#ced4da',
          blue: 'blue',
          yellow: '#f7e733',
        },
        avatar: {
          size: '110',
          height: '160',
          round: 'rounded-lg'
        },
        grid: {
          header: 'mt-7',
          titlePart: 'mt-n2 ml-n15',
          title: 'ml-n4',
          chip: 'ml-n16 mt-1',
          btn: 'mt-1 ml-14',
          subName: 'mt-n4 ml-n16',
          label: 'ml-n16',
          summary: 'mt-n3 ml-n16',
          mdi: 'ml-5 mr-n16 mt-1'
        },
        mdi: {
          dotsVertical: 'mdi-dots-vertical'
        },
        style: {
          title: {
            color: '#ced4da',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '15px',
          },
          hoverTitle: {
            color: '#3a86ff',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '15px',
          },
          subscribedBtn: {
            color: '#ffffff',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '11px',
          },
          unsubscribedBtn: {
            color: '#ced4da',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '11px'
          },
          hoverSubName: {
            color: '#52b788',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '8px',
          },
          subName: {
            color: '#6c757d',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '8px',
          },
          year: {
            color: '#000000',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '14px'
          },
          label: {
            // color: '#000000',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '11px',
            // height: '25px',
          },
          summary: {
            color: '#ced4da',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '11px',
            height: '50px',
            maxHeight: '50px',
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
    }
  }
</script>