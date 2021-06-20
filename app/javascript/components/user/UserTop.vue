<template>
  <div class="user-top mt-n1">
    <!-- <v-divider class="mt-16 ml-n10" /> -->
    <v-row class="mt-8">
      <v-col lg=3 class="ml-16">
        <v-avatar size=128 elevation=0 color="#dee2e6">
          <v-img src="https://cdn.vuetifyjs.com/images/john.jpg"></v-img>
        </v-avatar>
        <h2 class="mt-7">username</h2>
        <div style="font-size: 13px; color: #768390;" class="">@username</div>
        <v-row class="mt-1" no-gutters>
          <v-col lg=4 style="font-size: 12px; color: #111111;">
            <span style="font-weight: bold;">123</span> フォロー</v-col>
          <v-col lg=4 style="font-size: 12px; color: #111111;">
            <span style="font-weight: bold;">123</span> フォロワー</v-col>
        </v-row>
        <v-row class="mt-n3" no-gutters>
          <v-col lg=7 style="font-size: 12px; color: #111111;">
            <p class="mt-4">Designer Adovcate, Education @figmadesign
              he/him/his</p>
          </v-col>
        </v-row>
        <v-btn color="#42ccff" style="font-size: 11px; font-weight: bold; color: #ffffff;" elevation=0>フォロー
        </v-btn>
      </v-col>
      <v-col lg=8 class="mt-16 ml-n16">
        <v-row class="mt-n16">
          <v-col lg=12>
            <!-- <h4>ウォッチログ</h4> -->
            <v-tabs background-color="transparent" color="#111111">
              <v-tabs-slider color="#42ccff"></v-tabs-slider>
              <v-tab>
                <h4>ウォッチログ <span class="ml-1"><v-chip small elevation=0 color="#f2f2f2">13</v-chip></span></h4>
              </v-tab>
              <v-tab>
                <h4>ウォッチリスト <span class="ml-1"><v-chip small elevation=0 color="#f2f2f2">13</v-chip></span></h4>
              </v-tab>
              <v-tab>
                <h4>レビュー <span class="ml-1"><v-chip small elevation=0 color="#f2f2f2">13</v-chip></span></h4>
              </v-tab>
            </v-tabs>
          </v-col>
        </v-row>
        <v-row class="mt-2">
          <!-- <v-col lg=4></v-col> -->
          <v-col lg=6 v-for="(episode, index) in 3" :key=index class="mr-n8">

            <v-card color="#f4f8fb" elevation=0 class="rounded-lg mb-n2" height="140" width="440">
              <v-list-item three-line>
                <v-list-item-avatar tile class="rounded-lg" size="80" height="110" color="grey">
                  <v-img src="https://image.tmdb.org/t/p/w500/tTFixV61n0SErumUFHUZcwh1KK8.jpg"></v-img>
                </v-list-item-avatar>
                <v-list-item-content>
                  <div class="text-overline mb-4">
                    <v-btn outlined x-small style="font-weight: bold; color: #ffffff; font-size: 11px;" color="black"
                      elevation=0>シーズン1 第1話</v-btn>
                  </div>
                  <v-list-item-title class="text-h6 mb-1 mt-n2" style="font-weight: bold; color: #020814;">
                    全裸監督
                  </v-list-item-title>
                  <v-list-item-subtitle style="color: #657482;">フットマンオーディション第二部。美咲はひょんなことから碓氷とペアを組むことになった。難題が続き苦戦していたが
                  </v-list-item-subtitle>
                  <!-- <v-list-item-action>
                    <v-btn x-small elevation=0 color="pink"></v-btn>
                  </v-list-item-action>  -->
                </v-list-item-content>
              </v-list-item>
            </v-card>
          </v-col>
        </v-row>
        <!-- <router-view :user_info="this.user_info" /> -->
      </v-col>
    </v-row>
    <!-- <v-card outlined class="user-card rounded-lg">
      <v-card-title>
        <v-avatar size="60">
          <v-img :src="setAvatar()" />
        </v-avatar>
        <span class="user-name ml-3 mt-n8">
          {{user_info.name}}
        </span>
        <span class="user-subname ml-2 mt-n7">
          @{{user_info.name}}
        </span>
        <v-spacer />
        <v-btn class="user-relationBtn mt-n8" :style="followed ? followingStyle : unfollowingStyle"
          @click="followed ? unfollow(user_info.id) : follow(user_info.id)"
          v-if="this.$store.state.user.currentUser.id !== user_info.id" small elevation=0 outlined>
          {{followed ? followingText : unfollowingText}}</v-btn>
      </v-card-title>
      <v-row class="mt-n16 ml-n1">
        <v-col lg=1>
        </v-col>
        <v-col lg=2 class="mt-n13 ml-n7">
        </v-col>
        <v-col lg=1 class="mt-n11 ml-n9" v-for="(link, index) in this.user_info.sns_link" :key="index">
          <v-icon size=18 color="#6b7280">
          </v-icon>
        </v-col>
      </v-row>
      <v-row class="mt-5" v-if="this.user_info">
        <v-col cols=1 sm=1 md=1 lg=1 xl=1>
        </v-col>
        <v-col cols=3 sm=3 md=3 lg=2 xl=3 :class="gridUserInfo">
          <span class="user-count">
            {{this.user_info.subscriptions}}
          </span>
          <span class="user-countText">
            スペース
          </span>
        </v-col>
        <v-col cols=3 sm=2 md=2 lg=2 xl=2 :class="gridUserInfo">
          <span class="user-count">
            {{this.user_info.following.length}}
          </span>
          <span class="user-countText">
            フォロー
          </span>
        </v-col>
        <v-col cols=3 sm=2 md=2 lg=2 xl=2 :class="gridUserInfo">
          <span class="user-count">
            {{this.user_info.follower.length}}
          </span>
          <span class="user-countText">
            フォロワー
          </span>
        </v-col>
        <v-col cols=2 sm=2 md=2 lg=2 xl=2 :class="gridUserInfo" v-if="this.user_info.location">
        </v-col>
      </v-row>
    </v-card> -->

    <!-- <v-tabs mobile-breakpoint="xs" class="mt-4" background-color='#ffffff' :height="'35'" :color="'#016aff'">
      <v-tab @click="changeTab(tab.name)" class="user-tab" :active-class="'blue--text'" v-for="(tab,index) in user_tabs"
        :key="index">
        {{tab.title}}
      </v-tab>
    </v-tabs>
    <v-divider /> -->

    <!-- <router-view :user_info="this.user_info" /> -->
  </div>
</template>

<script>
  // import '@mdi/font/css/materialdesignicons.css';

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
        default_avatar: `https://cdn.vuetifyjs.com/images/john.jpg`,
        user_tabs: [{
            title: 'プロフィール',
            name: 'UserTop',
            path: 'posts',
          },
          {
            title: '投稿レビュー',
            name: 'UserReviews',
            path: 'reviews'
          },
          {
            title: 'フォロー',
            name: 'UserFollowing',
            path: 'following'
          },
          {
            title: 'フォロワー',
            name: 'UserFollowers',
            path: 'followers'
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
    computed: {
      gridUserInfo() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'mt-n11'
          case 'sm':
          case 'md':
          case 'lg':
          case 'xl':
            return 'mt-n11 ml-n7'
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
      changeTab(path_name) {
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
  .user-top {
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
    /* border: thin solid rgba(121, 121, 121, 0.12); */
  }
</style>