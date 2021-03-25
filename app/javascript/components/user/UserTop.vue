<template>
  <v-container class="ml-4">
    <v-row class="top-part" />
    <v-row>
      <v-col cols=2 lg=1>
        <v-badge color="green" bordered right offset-x="15" offset-y="75" overlap>
          <v-avatar color="red" size=75 height=75 tile class="rounded-xl" />
        </v-badge>
      </v-col>
      <v-col cols=5 lg=8 class="ml-6 mt-3">
        <v-row>
          <v-col cols=12>
            <div class="user-name">Satoru</div>
          </v-col>
        </v-row>
        <v-row class="mt-n6">
          <v-col cols=12>
            <div class="user-nickname">@sugish0021</div>
          </v-col>
        </v-row>
      </v-col>
      <v-col cols=2 class="mt-5 ml-1">
        <v-btn v-if="this.$store.state.currentUser.id != this.$route.params.id" :class="roundClass"
          :style="followed ? followingStyle : unfollowStyle" @click="followed ? unfollow(user.id) : follow(user.id)">
          {{ followed ? followingText : unfollowText }}
        </v-btn>
      </v-col>
    </v-row>
    <v-row>
      <v-col lg=2 class="hidden-xs-only" />
      <v-col cols=12 md=12 lg=12 xl=12>
        <v-tabs grow class="mt-n10" background-color="#ffffff" icons-and-text>
          <v-tabs-slider />
          <v-tab class="list-text" active-class="black--text">Rooms</v-tab>
          <v-tab @click="movePath('Followers')" class="list-text" active-class="black--text">Followers</v-tab>
          <v-tab @click="movePath('Followings')" class="list-text" active-class="black--text">Followings</v-tab>
          <v-tab class="list-text" active-class="black--text">Schedule</v-tab>
        </v-tabs>
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
        followingText: 'Following',
        followingStyle: {
          backgroundColor: "#343a40",
          fontWeight: "bold",
          width: 120,
          height: 25
        },
        unfollowText: 'Follow',
        unfollowStyle: {
          backgroundColor: "#2d00f7",
          fontWeight: "bold",
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
      movePath(path_name){
        this.$router.push({name: path_name})
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
    font-size: 22px;
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

  .list-text {
    font-size: 10px;
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