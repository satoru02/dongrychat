<template>
  <v-container :class="space_top.position">
    <space-header :space_data="this.space_data" />
    <v-tabs v-if="space_data" :style="tabs.style" :class="tabs.grid" :height="tabs.height" :width="tabs.width"
      :color="tabs.color">
      <v-tab @click="changeMenu(menu.path)" :style="tab.style" v-for="(menu, index) in menus" :key="index">
        {{menu.name}}
        <v-btn rounded :style="tab.btn.style" :elevation="tabs.btnElevation" :class="tabs.btnGrid"
          :color="tabs.btnColor" x-small v-text="setCount(menu.name)" />
      </v-tab>
    </v-tabs>
    <v-divider />
    <router-view v-if="this.space_data" :spaceId="this.space_data.id" :users="this.space_data.users.data" />
  </v-container>
</template>

<script>
  import { secureAxios } from '../../backend/axios';
  import SpaceHeader from './SpaceHeader';

  export default {
    name: 'SpaceTop',
    components: {
      'space-header': SpaceHeader,
    },
    data() {
      return {
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w200`,
        params: {},
        space_data: '',
        endpoint: '',
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
        menus: [
          {
            name: 'チャット',
            path: 'chats'
          },
          {
            name: 'レビュー',
            path: 'reviews'
          },
          {
            name: 'ユーザー',
            path: 'members'
          },
          {
            name: 'ニュース',
            path: 'news'
          }
        ],
        tabs: {
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
        space_top: {
          position: 'mt-n10 ml-n2',
        },
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
          tmdb_comp_id: this.$route.params.tmdb_comp_id,
          tmdb_tv_id: this.$route.params.tmdb_tv_id,
          image_path: this.$route.params.image_path,
          overview: this.$route.params.overview,
          tag_list: this.$route.params.tag_list,
        }
      } else if (this.$route.name === this.space.movie.unsubscribed) {
        this.endpoint = this.api.from_search
        this.params = {
          name: this.$route.params.name,
          media: this.media.mv,
          image_path: this.$route.params.image_path,
          tmdb_mv_id: this.$route.params.tmdb_mv_id,
          overview: this.$route.params.overview,
          tag_list: this.$route.params.tag_list
        }
      }
      this.setSpace()
    },
    watch: {
      $route: 'setSpace'
    },
    // updated(){
    //   if(this.space_data === ''){
    //     this.setSpace()
    //   }
    // },
    methods: {
      setSpace(){
        secureAxios.get(this.endpoint, {
          params: this.params
        })
        .then(res => this.successful(res))
        .catch(err => this.failed(err))
      },
      successful(res){
        this.space_data = res.data.data.attributes
      },
      failed(err){
        this.error = (err.response && err.response.data && err.response.data.error) || ''
      },
      setCount(menu_name){
        if(menu_name === 'チャット'){
          return this.space_data.comments_count
        } else if(menu_name === 'ユーザー'){
          return this.space_data.users.data.length
        } else if(menu_name === 'レビュー'){
          return 0
        } else if(menu_name === 'ニュース') {
          return 0
        }
      },
      changeMenu(menu_name){
        this.$router.push(({path: menu_name})).catch(()=> {});
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