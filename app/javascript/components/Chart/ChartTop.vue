<template>
  <v-container :class="grid.header" :key="componentKey">
    <v-row class="ml-2">
      <v-col md=1 lg=1 xl=1>
        <div :style="switch1 === false ? style.active : style.inactive" v-text="tv.header" />
      </v-col>
      <v-col md=1 lg=1 xl=1>
        <div :style="switch1 === true ? style.active : style.inactive" v-text="movie.header" />
      </v-col>
      <v-col md=9 lg=9 xl=9 />
      <v-col md=1 lg=1 xl=1>
        <v-switch v-model="switch1" :color="colors.switchButton" inset :class="grid.switch" />
      </v-col>
    </v-row>
    <v-list two-line>
      <v-list-item-group :active-class="colors.listItemGroupActive" :class="grid.listItemGroup" multiple>
        <template v-for="(item, index) in items">
          <v-list-item class="mt-n2 mb-n2" :key="index" @click="enterSpace(item.attributes)">
            <div :style="style.ranking" :class="grid.ranking">
              <v-btn icon text-color="#6c757d" style="background-color: #dee2e6;" x-small elevation=0>{{index + 1}}
              </v-btn>
              <!-- <v-icon :color="colors.rankIcon" :class="grid.icon" :size="icon.size" v-text="icon.mdi" /> -->
            </div>
            <v-list-item-avatar :size="avatar.size" :height="avatar.height" tile :class="avatar.round">
              <base-image :img="base_tmdb_img_url + item.attributes.image_path" :height="avatar.height" />
            </v-list-item-avatar>
            <v-list-item-content :class="grid.listItemContent">
              <v-list-item-title :style="style.listItemTitle" v-text="item.attributes.name" />
              <v-list-item-subtitle :style="style.listItemSubtitle" :class="grid.listItemSubtitle">
                <base-label :x_small="true" v-if="item.attributes.media === media.tv" :color="colors.chip"
                  :text-color="colors.chip" :season="item.attributes.season" :episode="item.attributes.episode"
                  :title="item.attributes.episode_title" />
              </v-list-item-subtitle>
            </v-list-item-content>
            <v-list-item-action :class="grid.notifyBadge" v-if="item.attributes.users.length > 0">
              <v-badge :class="grid.notifyDot" dot :color="colors.notifyBadge" />
            </v-list-item-action>
            <v-list-item-action v-if="item.attributes.users.length > 0">
              <div class=ml-2 :style="style.listItemAction" v-text="item.attributes.users.length" />
            </v-list-item-action>
          </v-list-item>
          <!-- <v-divider
            v-if="index < items.length - 1"
            :key="index + 1"
          ></v-divider> -->
        </template>
      </v-list-item-group>
    </v-list>
    <base-loader :handler="infiniteHandler" :wrapper="true" :text="loaderText" />

    <v-dialog v-model="loginDialog" width="400" transition="dialog-top-transition">
      <v-card color="#ffffff" height="250" class="rounded-lg">
        <v-row>
          <v-col lg=3 />
          <v-col lg=7>
            <div class="mt-9" :style="dialog.headerStyle">DongryChatを使ってみる</div>
          </v-col>
        </v-row>
        <v-row>
          <v-col lg=1 />
          <v-col lg=10>
            <v-btn @click="goLogin()" block　:style="dialog.btnStyle" color="pink" elevation=0 v-text="'ログイン'"/>
          </v-col>
        </v-row>
        <v-row>
          <v-col lg=1 />
          <v-col lg=10>
            <v-btn block @click="goSignup()" :style="dialog.btnStyle" color="blue" elevation=0 v-text="'アカウント作成'"/>
          </v-col>
        </v-row>
        <v-row>
            <v-col cols=3 sm=3 md=3 lg=3 xl=3 />
            <v-col cols=8 sm=8 md=8 lg=9 xl=8>
              <div class="ml-1" :style="dialog.policyStyle" v-text="'利用規約とプライバシーポリシーはこちら'" />
            </v-col>
          </v-row>
      </v-card>
    </v-dialog>

  </v-container>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios';
  import BaseImage from '../Base/BaseImage';
  import BaseLabel from '../Base/BaseLabel';
  import BaseInfiniteLoader from '../Base/BaseInfiniteLoader';

  export default {
    name: 'ChartTop',
    components: {
      'base-image': BaseImage,
      'base-label': BaseLabel,
      'base-loader': BaseInfiniteLoader
    },
    data() {
      return {
        loginDialog: false,
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w500`,
        trend_endpoint: `/api/v1/spaces/trend`,
        loaderText: '現在チャット中のスペースはありません。',
        items: [],
        switch1: false,
        page: 1,
        pageSize: 10,
        componentKey: 0,
        query_media: 'tv',
        error: '',
        avatar: {
          size: 65,
          height: 65,
          round: "rounded-lg"
        },
        icon: {
          size: 22,
          mdi: 'mdi-menu-up'
        },
        media: {
          tv: 'tv',
          movie: 'mv',
        },
        tv: {
          header: 'TV',
          pathName: 'TvSpace'
        },
        movie: {
          header: 'MOVIE',
          pathName: 'MvSpace'
        },
        colors: {
          switchButton: 'orange',
          rankIcon: 'green',
          chip: 'black',
          notifyBadge: 'red',
          listItemGroupActive: 'orange'
        },
        grid: {
          switch: 'mt-2 ml-n4',
          header: 'mt-n1 ml-n2',
          ranking: 'mr-6',
          icon: 'ml-2',
          listItemContent: 'ml-4',
          listItemAction: 'mt-1',
          listItemSubtitle: 'mt-1',
          listItemGroup: 'list-body mt-n6',
          notifyBadge: 'mr-n6',
          notifyDot: 'mt-1'
        },
        style: {
          ranking: {
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '12px',
            fontWeight: 'bold',
            color: '#8f8f8f',
          },
          listItemTitle: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '14px',
          },
          listItemAction: {
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '11px',
            fontWeight: 'bold',
            color: '#484b4d'
          },
          listItemSubtitle: {
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '12px',
            fontWeight: 'bold',
            color: '#6c757d'
          },
          active: {
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '25px',
            fontWeight: 'bold',
            color: '#000000',
            letterSpacing: '3px'
          },
          inactive: {
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '25px',
            fontWeight: 'bold',
            color: '#8f8f8f',
            letterSpacing: '3px'
          }
        },
        dialog: {
          headerStyle: {
            color: '#000000',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '17px',
          },
          btnStyle: {
            color: '#ffffff',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '12px',
          },
          policyStyle: {
            color: '#6c757d',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '4px',
          }
        }
      }
    },
    watch: {
      switch1: function () {
        this.page = 1
        this.items = []
        if (this.switch1 === false) {
          this.query_media = this.media.tv
          this.forceRerender()
        } else if (this.switch1 === true) {
          this.query_media = this.media.movie
          this.forceRerender()
        }
      }
    },
    methods: {
      forceRerender() {
        this.componentKey += 1
      },
      infiniteHandler($state) {
        setTimeout(() => {
          secureAxios.get(this.trend_endpoint, {
              params: {
                page: this.page,
                per_page: this.pageSize,
                media: this.query_media
              }
            })
            .then(res => {
              if (res.data.data.length) {
                this.page += 1,
                  this.items.push(...res.data.data)
                $state.loaded()
              } else {
                $state.complete();
              }
            })
        }, 150);
      },
      enterSpace(item) {
        // this.checkSignedIn()
        if (this.$store.state.signedIn) {
          if (item.media === this.media.tv) {
            this.$router.push({
              name: this.tv.pathName,
              params: {
                season_number: item.season,
                episode_number: item.episode,
                name: item.name,
                episode_title: item.episode_title,
                tmdb_tv_id: item.tmdb_tv_id,
                image_path: item.image_path,
                media: item.media,
              }
            })
          } else if (item.media === this.media.movie) {
            this.$router.push({
              name: this.movie.pathName,
              params: {
                image_path: item.image_path,
                tmdb_mv_id: item.tmdb_mv_id,
                name: item.name,
                media: item.media,
              }
            })
          }
        } else {
          this.loginDialog = true
        }
      },
      goLogin(){
        this.$router.replace('/login')
      },
      goSignup(){
        this.$router.replace('/signup')
      }
    }
  }
</script>

<style scoped>
  .theme--light.v-divider {
    border-color: rgba(0, 1, 1, .06);
  }
</style>