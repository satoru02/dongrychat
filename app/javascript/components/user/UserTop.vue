<template>
  <v-container class="mt-5">
    <v-row v-if="$vuetify.breakpoint.width > 600">
      <v-col cols=3 sm=1 md=1 lg=1>
        <v-avatar size=88 elevation=0 color="#dee2e6">
          <v-img :src="this.usersInfo.avatar_url"></v-img>
        </v-avatar>
      </v-col>
      <v-col v-if="usersInfo && ($store.state.user.currentUser.id != usersInfo.id)"
       cols=9 sm=10 md=10 lg=10 :class="gridName">
        <h2 class="mt-n2">{{this.usersInfo.name}}</h2>
        <div style="font-size: 13px; color: #768390;">@{{this.usersInfo.name}}</div>
        <v-btn
          v-if="usersInfo && ($store.state.user.currentUser.id != usersInfo.id)"
          class="rounded mt-3" small elevation=0
          :style="isFollowed ? followingStyle : unfollowStyle"
          :outlined="isFollowed ? true : false"
          @click="isFollowed ? unfollow(usersInfo.id) : follow(usersInfo.id)">
          {{ isFollowed ? followingText : unfollowText }}
        </v-btn>
      </v-col>
      <v-col sm=10 md=10 lg=10 v-else :class="gridName">
        <h2 class="mt-6">
          {{this.usersInfo.name}}
        </h2>
      </v-col>
    </v-row>
    <v-row v-if="$vuetify.breakpoint.width < 600">
      <v-col cols=2>
        <v-avatar size=45 elevation=0 color="#dee2e6">
          <v-img :src="this.usersInfo.avatar_url"></v-img>
        </v-avatar>
      </v-col>
      <v-col
        v-if="usersInfo && ($store.state.user.currentUser.id != usersInfo.id)"
        cols=10
        :class="'ml-3'">
        <h7 class="mt-2">
          {{this.usersInfo.name}}
        </h7>
        <v-btn
          v-if="usersInfo && ($store.state.user.currentUser.id != usersInfo.id)"
          class="rounded mt-3" x-small elevation=0
          :style="isFollowed ? followingStyle : unfollowStyle"
          :outlined="isFollowed ? true : false"
          @click="isFollowed ? unfollow(usersInfo.id) : follow(usersInfo.id)">
          {{ isFollowed ? followingText : unfollowText }}
        </v-btn>
      </v-col>
      <v-col v-else cols=10 class="mt-3">
        <h7>
          {{this.usersInfo.name}}
        </h7>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=12 sm=12 md=12 lg=12>
        <v-tabs background-color="transparent" color="#111111">
          <v-tabs-slider color="#42ccff"></v-tabs-slider>
          <v-tab
            v-for="(tab, index) in tabs"
            :key="index"
            style="font-weight: bold; font-size: 14px;"
            @click="changePath(tab.path)">
            <span class="ml-3 mr-3">
              {{tab.title}}
            </span>
            {{usersAtrCount(tab.title)}}
          </v-tab>
        </v-tabs>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=12 sm=12 md=12 lg=12>
        <router-view :userInfo="this.usersInfo" />
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
        usersInfo: '',
        componentKey: 0,
        tabs: [{
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
          {
            title: 'フォロワー',
            path: 'UserFollowers',
          },
          {
            title: 'フォロー',
            path: 'UserFollowing',
          },
          {
            title: 'プロフィール',
            path: 'UserProfile',
          },
        ],
        isFollowed: Boolean,
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
      gridName() {
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
        vm.fetchUser()
        document.title = to.params.user_name
      })
    },
    beforeRouteUpdate(to, from, next) {
      document.title = this.usersInfo.name
      next()
    },
    watch: {
      '$route.params.user_id'() {
        this.usersInfo = ''
        this.fetchUser()
      },
    },
    methods: {
      fetchUser() {
        usersRepository.getUserInfo(this.$route.params.user_id)
          .then(res => this.fetchSuccessful(res))
          .catch(err => this.fetchFailed(err))
      },
      fetchSuccessful(res) {
        this.usersInfo = res.data.data.attributes
        document.title = this.usersInfo.name
        this.checkRelationship(this.usersInfo)
      },
      fetchFailed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ""
        this.$router.replace('/')
      },
      setAvatar() {
        if (this.usersInfo.avatar_url != null) {
          return this.usersInfo.avatar_url
        } else {
          return this.default_avatar
        }
      },
      changePath(pathName) {
        this.$router.push({
          name: pathName
        })
      },
      checkRelationship(user) {
        if (this.$store.state.user.currentUser.following.includes(user.id)) {
          this.isFollowed = true
        } else {
          this.isFollowed = false
        }
      },
      follow(userId) {
        relationshipsRepository.follow({
            followed_id: userId
          })
          .then(res => {
            this.$store.commit('user/follow', userId)
            this.isFollowed = true
          })
      },
      unfollow(userId) {
        relationshipsRepository.unfollow(this.$store.state.user.currentUser.id, {
            id: this.$store.state.user.currentUser.id,
            followed_id: userId
          })
          .then(res => {
            this.$store.commit('user/unfollow', userId)
            this.isFollowed = false
          })
      },
      usersAtrCount(usersAttributes) {
        switch (usersAttributes) {
          case 'リスト':
            return this.usersInfo.watchlists_count
          case 'ログ':
            return this.usersInfo.watchlog_count
          case 'レビュー':
            return this.usersInfo.reviews_count
          case 'フォロワー':
            return this.usersInfo.followers_count
          case 'フォロー':
            return this.usersInfo.followed_count
        }
      }
    }
  }
</script>