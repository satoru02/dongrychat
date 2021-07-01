<template>
  <div class="mt-4">

    <v-row>
      <!-- <v-col lg=1 /> -->
      <v-col lg=1>
        <v-avatar class="ml-14" size=88 elevation=0 color="#dee2e6">
          <v-img :src="this.user_info.avatar_url"></v-img>
        </v-avatar>
      </v-col>
      <v-col lg=2 class="ml-16" v-if="user_info && ($store.state.user.currentUser.id != user_info.id)">
        <h2 class="mt-n2">{{this.user_info.name}}</h2>
        <div style="font-size: 13px; color: #768390;" class="">@{{this.user_info.name}}</div>
        <v-btn class="rounded mt-3" small elevation=0
          v-if="user_info && ($store.state.user.currentUser.id != user_info.id)"
          :style="followed ? followingStyle : unfollowStyle" :outlined="followed ? true : false"
          @click="followed ? unfollow(user_info.id) : follow(user_info.id)">
          {{ followed ? followingText : unfollowText }}
        </v-btn>
      </v-col>
      <v-col lg=2 class="ml-16" v-else>
        <h2 class="mt-4">{{this.user_info.name}}</h2>
        <div style="font-size: 13px; color: #768390;" class="">@{{this.user_info.name}}</div>
      </v-col>
      <v-col lg=5>
        <v-row class="mt-3" no-gutters>
          <v-col lg=8 style="font-size: 12px; color: #111111;">
            <p class="mt-4">{{this.user_info.about}}</p>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
    <v-row class="">
      <!-- <v-col lg=1 /> -->
      <v-col lg=11>
        <v-tabs background-color="transparent" color="#111111">
          <v-tabs-slider color="#42ccff"></v-tabs-slider>
          <v-tab style="font-weight: bold; font-size: 12px;" @click="changePath(tab.path)"
            v-for="(tab, index) in user_tabs" :key="index">
            <icon-base v-if="tab.title === 'ウォッチリスト'" :iconColor="'#6c757d'" icon-name="icon-calendar" :width="'20'"
              :height="'20'" :viewBox="'-33 -19 626 626.68002'">
              <icon-calendar />
            </icon-base>
            <icon-base v-if="tab.title === 'ウォッチログ'" :iconColor="'#6c757d'" icon-name="icon-list" :width="'17'"
              :height="'17'" :viewBox="'0 0 512 512'">
              <icon-list />
            </icon-base>
            <icon-base v-if="tab.title === 'レビュー'" :iconColor="'#6c757d'" icon-name="icon-pen" :width="'17'"
              :height="'17'" :viewBox="'-42 0 512 512.001'">
              <icon-pen />
            </icon-base>
            <span class="ml-3">{{tab.title}}</span>
            <v-chip class="ml-3 rounded-xl" :color="'#f2f2f2'" small v-text="usersAtrCount(tab.title)">
            </v-chip>
          </v-tab>
        </v-tabs>
      </v-col>
    </v-row>
    <v-divider width=890 />
    <v-row class="mt-6">
      <!-- <v-col lg=1 /> -->
      <v-col lg=9 class="">
        <router-view :user_info="this.user_info" />
      </v-col>
    </v-row>
  </div>
</template>

<script>
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const usersRepository = RepositoryFactory.get('users');
  const relationshipsRepository = RepositoryFactory.get('relationships');

  export default {
    name: "UserTop",
    components: {
      'icon-base': () => import( /* webpackPrefetch: true */ '../Icon/IconBase.vue'),
      'icon-pen': () => import( /* webpackPrefetch: true */ '../Icon/IconPen'),
      'icon-list': () => import( /* webpackPrefetch: true */ '../Icon/IconList.vue'),
      'icon-calendar': () => import( /* webpackPrefetch: true */ '../Icon/IconCalendar.vue'),
    },
    data() {
      return {
        user_info: '',
        componentKey: 0,
        user_tabs: [{
            title: 'ウォッチリスト',
            path: 'watchlists',
          },
          {
            title: 'ウォッチログ',
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
    computed: {},
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
          case 'ウォッチリスト': return this.$store.state.user.currentUser.watchlists_count
          case 'ウォッチログ':　return this.$store.state.user.currentUser.watchlog_count
          case 'レビュー':　return this.$store.state.user.currentUser.reviews_count
          case 'フォロワー':　return this.$store.state.user.currentUser.followers_count
          case 'フォロー':　return this.$store.state.user.currentUser.followed_count
        }
      }
    }
  }
</script>

<style scoped>
</style>