<template>
  <v-container class="user-top mt-4">
    <v-card outlined class="user-card rounded-lg">
      <v-img height="133" src="https://source.unsplash.com/random" />
      <v-card-title>
        <v-avatar size="60">
          <v-img :src="setAvatar()" />
        </v-avatar>
        <span class="user-name ml-3 mt-n8">{{user_info.name}}</span><span
          class="user-subname ml-2 mt-n7">@{{user_info.name}}</span>
        <v-spacer />
        <v-btn class="user-relationBtn mt-n8"
          :style="followed ? followingStyle : unfollowingStyle"
          @click="followed ? unfollow(user_info.id) : follow(user_info.id)"
          v-if="this.$store.state.currentUser.id !== user_info.id" small
          elevation=0 outlined>{{followed ? followingText : unfollowingText}}</v-btn>
      </v-card-title>

      <!-- fix -->
      <v-row class="mt-n16 ml-n1">
        <v-col lg=1>
        </v-col>
        <v-col lg=2 class="mt-n13 ml-n7">
        </v-col>
        <v-col lg=1 class="mt-n11 ml-n9" v-for="(link, index) in this.user_info.sns_link" :key="index">
          <v-icon size=18 color="#6b7280">
            <!-- {{setLink(link)}} -->
          </v-icon>
        </v-col>
      </v-row>

      <v-row class="mt-5" v-if="this.user_info">
        <v-col lg=1>
        </v-col>
        <v-col lg=3 class="mt-n11 ml-n7">
          <span class="user-count">{{this.user_info.subscriptions}}</span><span class="user-countText"> スペース</span>
        </v-col>
        <v-col lg=2 class="mt-n11 ml-n16">
          <span class="user-count">{{this.user_info.following.length}}</span><span class="user-countText"> フォロー</span>
        </v-col>
        <v-col lg=2 class="mt-n11 ml-n5">
          <span class="user-count">{{this.user_info.follower.length}}</span><span class="user-countText"> フォロワー</span>
        </v-col>
        <v-col lg=2 class="mt-n12 ml-n1" v-if="this.user_info.location">
          <v-icon size=18 color="#6b7280" class="mt-1">
            mdi-map-marker-outline
          </v-icon>
          <span class="user-countText">{{this.user_info.location}}</span>
        </v-col>
      </v-row>
    </v-card>
    <v-tabs class="mt-4" background-color='#ffffff' :height="'35'" :color="'#016aff'">
      <v-tab @click="changeTab(tab.name)" class="user-tab" :active-class="'blue--text'" v-for="(tab,index) in user_tabs" :key="index">
        {{tab.title}}
      </v-tab>
    </v-tabs>
    <v-divider />
    <router-view :user_info="this.user_info"/>
  </v-container>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios';
  const RELATIONSHOP_URL = `/api/v1/relationships`;

  export default {
    name: "UserTop",
    data() {
      return {
        user_info: '',
        default_avatar: `https://cdn.vuetifyjs.com/images/john.jpg`,
        user_tabs: [
          {
            title: 'プロフィール',
            name: 'UserTop',
            path: 'posts',
          },
          {
            title: '投稿',
            name: 'UserPosts',
            path: 'posts'
          },
          {
            title: 'フォロー',
            name: 'UserFollowings',
            path: 'followings'
          },
          {
            title: 'フォロワー',
            name: 'UserFollowers',
            path: 'UserFollowers'
          }
        ],
        followed: Boolean,
        followingText: 'フォロー中',
        followingStyle: {
          fontWeight: "bold",
          fontSize: "6px",
          color: '#111111',
        },
        unfollowingText: 'フォローする',
        unfollowingStyle: {
          backgroundColor: "#4361ee",
          fontWeight: "bold",
          fontSize: "6px",
          color: '#ffffff',
        },
      }
    },
    beforeRouteEnter (to, from, next) {
      next(vm => {
        vm.getUser()
        document.title = to.params.user_name
      })
    },
    beforeRouteUpdate(to, from, next) {
      document.title = this.user_info.name
      next()
    },
    updated(){
      this.follow_check(this.user_info)
    },
    methods: {
      getUser() {
        secureAxios.get(`/api/v1/users/${this.$route.params.user_name}`)
          .then(res => this.fetchSuccessful(res))
          .catch(err => this.fetchFailed(err))
      },
      fetchSuccessful(res) {
        this.user_info = res.data.data.attributes
      },
      fetchFailed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ""
        this.$router.replace('/')
      },
      setAvatar() {
        if (this.user_info.avatar_url != null) {
          return this.user_info.avatar_url
        } else {
          return this.default_avatar
        }
      },
      setLink() {},
      changeTab(path_name){
        this.$router.push({name: path_name})
      },
      follow_check(user){
        if(this.$store.state.currentUser.following.includes(user.id)){
          this.followed = true
        } else {
          this.followed = false
        }
      },
      follow(user_id) {
        secureAxios.post(RELATIONSHOP_URL, {
          followed_id: user_id
        }).then(res => {
          this.$store.commit('follow', user_id)
          this.followed = true
        })
      },
      unfollow(user_id) {
        secureAxios.delete(RELATIONSHOP_URL + `/` + `${this.$store.state.currentUser.id}`, {
          params: {
            id: this.$store.state.currentUser.id,
            followed_id: user_id
          }
        }).then(res => {
          this.$store.commit('unfollow', user_id)
          this.followed = false
        })
      },
    }
  }
</script>

<style scoped>
  .user-top {
    font-family: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif';
    line-height: 28px;
  }

  .user-card {
    max-height: 257px;
  }

  .user-name {
    font-weight: bold;
    color: #011627;
    font-size: 16px;
  }

  .user-relationBtn {
    font-weight: bold;
    color: #000000;
    font-size: 12px;
  }

  .user-subname {
    font-weight: bold;
    color: #4b5563;
    font-size: 12px;
  }

  .user-count {
    font-weight: bold;
    color: #111111;
    font-size: 13px;
  }

  .user-countText {
    color: #4b5563;
    font-size: 12px;
  }

  .user-tab {
    font-weight: bold;
    color: #4b5563;
    font-size: 12px;
  }

  .v-card__subtitle,
  .v-card__text,
  .v-card__title {
    padding-bottom: 75px;
  }

  .v-divider {
    border-color: rgba(102, 102, 102, 0.06);
  }

  .theme--light.v-sheet--outlined {
    border: thin solid rgba(121, 121, 121, 0.12);
  }
</style>