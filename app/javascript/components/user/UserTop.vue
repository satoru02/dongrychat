<template>
  <v-container class="mt-5">
    <v-row v-if="$vuetify.breakpoint.width > 600">
      <v-col cols=3 sm=1 md=1 lg=1>
        <v-avatar size=88 elevation=0 color="#dee2e6">
          <v-img :src="this.user_info.avatar_url"></v-img>
        </v-avatar>
      </v-col>
      <v-col cols=9 sm=10 md=10 lg=10 :class="gridName" v-if="user_info && ($store.state.user.currentUser.id != user_info.id)">
        <h2 class="mt-n2">{{this.user_info.name}}</h2>
        <div style="font-size: 13px; color: #768390;" class="">@{{this.user_info.name}}</div>
        <v-btn class="rounded mt-3" small elevation=0
          v-if="user_info && ($store.state.user.currentUser.id != user_info.id)"
          :style="followed ? followingStyle : unfollowStyle" :outlined="followed ? true : false"
          @click="followed ? unfollow(user_info.id) : follow(user_info.id)">
          {{ followed ? followingText : unfollowText }}
        </v-btn>
      </v-col>
      <v-col sm=10 md=10 lg=10 v-else :class="gridName">
        <h2 class="mt-6">{{this.user_info.name}}</h2>
      </v-col>
    </v-row>
    <v-row v-if="$vuetify.breakpoint.width < 600">
      <v-col cols=2>
        <v-avatar size=45 elevation=0 color="#dee2e6">
          <v-img :src="this.user_info.avatar_url"></v-img>
        </v-avatar>
      </v-col>
      <v-col cols=10 :class="'ml-3'" v-if="user_info && ($store.state.user.currentUser.id != user_info.id)">
        <h7 class="mt-2">{{this.user_info.name}}</h7>
        <v-btn class="rounded mt-3" x-small elevation=0
          v-if="user_info && ($store.state.user.currentUser.id != user_info.id)"
          :style="followed ? followingStyle : unfollowStyle" :outlined="followed ? true : false"
          @click="followed ? unfollow(user_info.id) : follow(user_info.id)">
          {{ followed ? followingText : unfollowText }}
        </v-btn>
      </v-col>
      <v-col cols=10 v-else class="mt-3">
        <h7>{{this.user_info.name}}</h7>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=12 sm=12 md=12 lg=12>
        <v-tabs background-color="transparent" color="#111111">
          <v-tabs-slider color="#42ccff"></v-tabs-slider>
          <v-tab style="font-weight: bold; font-size: 14px;" @click="changePath(tab.path)"
            v-for="(tab, index) in user_tabs" :key="index">
            <span class="ml-3 mr-3">{{tab.title}}</span>
            {{usersAtrCount(tab.title)}}
          </v-tab>
        </v-tabs>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=12 sm=12 md=12 lg=12>
        <router-view :user_info="this.user_info" />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const usersRepository = RepositoryFactory.get('users');
  const relationshipsRepository = RepositoryFactory.get('relationships');

  export default {
    name: "UserTop",
    data() {
      return {
        user_info: '',
        componentKey: 0,
        user_tabs: [{
            title: 'リスト',
            path: 'watchlists',
          },
          {
            title: 'ログ',
            path: 'watchlog',
          },
          {
            title: 'レビュー',
            path: 'UserReviews',
          },
          // {
          //   title: 'フォロワー',
          //   path: 'UserFollowers',
          // },
          // {
          //   title: 'フォロー',
          //   path: 'UserFollowing',
          // },
          // {
          //   title: 'プロフィール',
          //   path: 'UserProfile',
          // },
        ],
        followed: Boolean,
        followingText: 'フォロー中',
        followingStyle: {
          fontWeight: "bold",
          fontSize: "10px",
          elevation: 0,
          color: '#000000'
        },
        unfollowText: 'フォローする',
        unfollowStyle: {
          backgroundColor: "#42ccff",
          fontWeight: "bold",
          fontSize: "10px",
          elevation: 0,
          color: '#ffffff'
        },
      }
    },
    computed: {
      gridName(){
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return ''
          case 'sm':
            return 'ml-13'
          case 'md':
          case 'lg':
          case 'xl':
            return 'ml-7'
        }
      }
    },
    beforeRouteEnter(to, from, next) {
      next(vm => {
        vm.getUser()
        document.title = to.params.user_name
      })
    },
    beforeRouteUpdate(to, from, next) {
      document.title = this.user_info.name
      next()
    },
    watch: {
      '$route.params.user_id'() {
        this.user_info = ''
        this.getUser()
      },
    },
    methods: {
      getUser() {
        usersRepository.getUserInfo(this.$route.params.user_id)
          .then(res => this.fetchSuccessful(res))
          .catch(err => this.fetchFailed(err))
      },
      fetchSuccessful(res) {
        this.user_info = res.data.data.attributes
        document.title = this.user_info.name
        this.follow_check(this.user_info)
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
      changePath(path_name) {
        this.$router.push({
          name: path_name
        })
      },
      follow_check(user) {
        if (this.$store.state.user.currentUser.following.includes(user.id)) {
          this.followed = true
        } else {
          this.followed = false
        }
      },
      follow(user_id) {
        relationshipsRepository.follow({
            followed_id: user_id
          })
          .then(res => {
            this.$store.commit('user/follow', user_id)
            this.followed = true
          })
      },
      unfollow(user_id) {
        relationshipsRepository.unfollow(this.$store.state.user.currentUser.id, {
            id: this.$store.state.user.currentUser.id,
            followed_id: user_id
          })
          .then(res => {
            this.$store.commit('user/unfollow', user_id)
            this.followed = false
          })
      },
      usersAtrCount(user_attributes){
        switch(user_attributes){
          case 'リスト': return this.user_info.watchlists_count
          case 'ログ':　return this.user_info.watchlog_count
          case 'レビュー':　return this.user_info.reviews_count
          case 'フォロワー':　return this.user_info.followers_count
          case 'フォロー':　return this.user_info.followed_count
        }
      }
    }
  }
</script>