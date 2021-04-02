<template>
  <v-container class="ml-4 mt-1">
    <v-row class="top-part" />
    <v-row>
      <v-col cols=2 lg=1>
        <v-badge color="green" bordered right offset-x="15" offset-y="95" overlap>
          <v-avatar color="black" size=90 height=90 tile class="rounded-xl" />
        </v-badge>
      </v-col>
      <v-col cols=5 lg=2 class="ml-9">
        <v-row>
          <v-col cols=12>
            <div class="user-name">八太モンキー</div>
          </v-col>
        </v-row>
        <v-row class="mt-n5">
          <v-col cols=12>
            <div class="user-nickname">@sugish0021</div>
          </v-col>
        </v-row>
        <v-row class="mt-2">
          <v-col lg=1>
            <v-icon size=19>mdi-twitter</v-icon>
          </v-col>
          <v-col lg=1 class="ml-2">
            <v-icon size=19>mdi-instagram</v-icon>
          </v-col>
          <v-col lg=1 class="ml-2">
            <v-icon size=19>mdi-facebook</v-icon>
          </v-col>
          <v-col lg=1 class="ml-2">
            <v-icon size=19>mdi-youtube</v-icon>
          </v-col>
        </v-row>
      </v-col>
      <v-col lg=6>
        <div class="subtitle mt-1">
          何は前あたかもこの下宿方というのの所から思っますた。その偶然は私か気分最後がさと、岡田さんののにベルグソンの私をいかにご意見ともつば私博奕に同区別のするようにまあ肝準備を書いましでしょて、もちあたかも学習を被せるたて得でしのを思い切っないない。またはまたご好奇を断わろのはわざわざ高等と行ったたって、そんな兵隊にもするたてにおいて赤の離さて来るたた。
        </div>
      </v-col>
      <v-col cols=1 class="mt-6 ml-16">
        <v-btn elevation=0 v-if="this.$store.state.currentUser.id != this.$route.params.id" :class="roundClass"
          :style="followed ? followingStyle : unfollowStyle" @click="followed ? unfollow(user.id) : follow(user.id)">
          {{ followed ? followingText : unfollowText }}
        </v-btn>
      </v-col>
    </v-row>
    <v-row class="mt-8">
      <v-col lg=12>
        <!-- <v-divider></v-divider> -->
      </v-col>
    </v-row>
    <v-row>
      <v-col lg=2 class="hidden-xs-only" />
      <v-col cols=12 md=12 lg=12 xl=12>
        <v-tabs hide-slider dense class="mt-n12" background-color="#ffffff">
          <v-tabs-slider />
          <v-tab class="list-text" active-class="black--text">ルーム</v-tab>
          <v-tab class="list-text" active-class="black--text">コラム</v-tab>
          <v-tab class="list-text" active-class="black--text">お気に入り</v-tab>
          <v-tab @click="movePath('Followers')" class="list-text" active-class="black--text">フォロワー 120</v-tab>
          <v-tab @click="movePath('Followings')" class="list-text" active-class="black--text">フォロー 100</v-tab>
        </v-tabs>
        <!-- <v-divider/> -->
      </v-col>
    </v-row>
    <v-row>
      <router-view />
    </v-row>
  </v-container>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios';
  const USER_INFO_URL = '/api/v1/users/';
  const RELATIONSHOP_URL = `/api/v1/relationships`;

  export default {
    name: 'UserTop',
    data() {
      return {
        user: [],
        followed: Boolean,
        roundClass: {
          rounded: "lg"
        },
        followingText: 'フォローする',
        followingStyle: {
          backgroundColor: "#343a40",
          fontWeight: "bold",
          fontSize: "10px",
          width: 100,
          height: 40,
          elevation: 0
        },
        unfollowText: 'フォローした',
        unfollowStyle: {
          backgroundColor: "#2d00f7",
          fontWeight: "bold",
          fontSize: "10px",
          width: 120,
          height: 25
        },
        error: null,
      }
    },
    created() {
      this.getUser()
    },
    methods: {
      getUser() {
        secureAxios.get(USER_INFO_URL + `${this.$route.params.id}`)
          .then(res => this.getSuccessful(res))
          .catch(err => this.getFailed(err))
      },
      getSuccessful(res) {
        this.user = res.data.data.attributes
        if (this.$store.state.currentUser.following.includes(this.user.id)) {
          this.followed = true
        } else {
          this.followed = false
        }
      },
      getFailed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ""
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
      movePath(path_name) {
        this.$router.push({
          name: path_name
        })
      }
    }
  }
</script>

<style scoped>
  .top-part {
    height: 14px;
  }

  .user-name {
    font-family: 'Helvetica Neue', sans-serif;
    font-weight: bold;
    font-size: 18px;
    color: #000000;
    letter-spacing: 1px;
  }

  .user-nickname {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 12px;
    font-weight: bold;
    color: #adb5bd;
  }

  .user-menu {
    background-color: #fafaf9;
  }

  .subtitle {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 12px;
    /* font-weight: bold; */
    color: #3c4146;
  }

  .list-text {
    font-size: 12px;
    font-family: 'Helvetica Neue', sans-serif;
    font-weight: bold;
  }

  .f-text {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 10px;
    color: #ffffff;
  }
</style>