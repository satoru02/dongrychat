<template>
  <div class="user-top mt-n1 ml-1">
    <v-row class="mt-8">
      <v-col lg=3 class="">
        <v-avatar size=128 elevation=0 color="#dee2e6">
          <v-img src="https://cdn.vuetifyjs.com/images/john.jpg"></v-img>
        </v-avatar>
        <h2 class="mt-7">username</h2>
        <div style="font-size: 13px; color: #768390;" class="">@username</div>
        <v-row class="mt-3" no-gutters>
          <v-col lg=5 style="font-size: 12px; color: #111111;">
            <span style="font-weight: bold;">123</span>フォロー</v-col>
          <v-col lg=6 style="font-size: 12px; color: #111111;">
            <span style="font-weight: bold;">123</span>フォロワー</v-col>
        </v-row>
        <v-row class="mt-3" no-gutters>
          <v-col lg=8 style="font-size: 12px; color: #111111;">
            <p class="mt-4">大学生ユーザー</p>
          </v-col>
        </v-row>
        <v-btn color="#42ccff" style="font-size: 11px; font-weight: bold; color: #ffffff;" elevation=0>フォロー
        </v-btn>
      </v-col>
      <v-col lg=9 class="mt-16 ml-n14">
        <v-row class="mt-n16">
          <v-col lg=12>
            <v-tabs background-color="transparent" color="#111111">
              <v-tabs-slider color="#42ccff"></v-tabs-slider>
              <v-tab style="font-weight: bold;" @click="changePath(tab.path)" v-for="(tab, index) in user_tabs"
                :key="index">
                <icon-base v-if="tab.title === 'ウォッチリスト'" :iconColor="'#6c757d'" icon-name="icon-calendar" :width="'24'"
                :height="'24'" :viewBox="'-33 -19 626 626.68002'">
                <icon-calendar />
              </icon-base>
                <icon-base v-if="tab.title === 'ウォッチログ'" :iconColor="'#6c757d'" icon-name="icon-list" :width="'19'"
                  :height="'19'" :viewBox="'0 0 512 512'">
                  <icon-list />
                </icon-base>
                <icon-base v-if="tab.title === 'レビュー'" :iconColor="'#6c757d'" icon-name="icon-pen" :width="'19'"
                  :height="'19'" :viewBox="'-42 0 512 512.001'">
                  <icon-pen />
                </icon-base>
                <span class="ml-3">{{tab.title}}</span>
                <v-chip class="ml-3 rounded-xl" :color="'#f2f2f2'" small v-text="'13'">
                </v-chip>
              </v-tab>
            </v-tabs>
          </v-col>
        </v-row>
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
        default_avatar: `https://cdn.vuetifyjs.com/images/john.jpg`,
        user_tabs: [{
            title: 'ウォッチログ',
            path: 'watchlog',
          },
          {
            title: 'ウォッチリスト',
            path: 'watchlists',
          },
          {
            title: 'レビュー',
            path: 'UserReviews',
          },
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
    computed: {
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
      '$route'() {
        this.user_info = ''
        this.getUser()
      },
    },
    updated() {
      this.follow_check(this.user_info)
    },
    methods: {
      getUser() {
        usersRepository.getUserInfo(this.$route.params.user_id)
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
    }
  }
</script>

<style scoped>
</style>