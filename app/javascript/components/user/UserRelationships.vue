<template>
  <v-container :class="this.$vuetify.breakpoint.width < 600 ? 'ml-16' : ''">
    <v-list-item-group style="background-color: #121214;"
     v-for="(user, index) in relationships" :key="index" multiple class="list-body">
        <v-list-item>
          <template v-slot:default="{}">
            <v-list-item-avatar size=58 height=58 tile class="rounded-lg">
              <v-img :src="user.attributes.avatar_url" />
            </v-list-item-avatar>
            <v-list-item-content class=ml-1>
              <v-list-item-title class="card-title">
                {{user.attributes.name}}
              </v-list-item-title>
            </v-list-item-content>
            <v-list-item-action class="ml-n5">
              <v-btn small elevation=0 v-if="$store.state.currentUser.id != user.id"
                :style="checkRelationship(user) ? followingStyle : unfollowStyle"
                @click="checkRelationship(user) ? unfollow(user.attributes.id) : follow(user.attributes.id)">
                {{ checkRelationship(user) ? followingText : unfollowText }}
              </v-btn>
            </v-list-item-action>
          </template>
        </v-list-item>
    </v-list-item-group>
  </v-container>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios';
  const RELATIONSHOP_URL = `/api/v1/relationships`;
  export default {
    name: "UserRelationships",
    props: {
      relationships: {
        type: Array,
        required: true
      }
    },
    data() {
      return {
        followed: false,
        followingText: 'フォロー中',
        followingStyle: {
          backgroundColor: "#000000",
          fontWeight: "bold",
          fontSize: "10px",
          elevation: 0,
          color: '#ced4da'
        },
        unfollowText: 'フォローする',
        unfollowStyle: {
          backgroundColor: "blue",
          fontWeight: "bold",
          fontSize: "10px",
          elevation: 0,
          color: '#ced4da'
        },
      }
    },
    methods: {
      checkRelationship(user){
        if (this.$store.state.currentUser.following.includes(user.attributes.id)) {
          return true
        } else {
          return false
        }
      },
      follow(user_id) {
        secureAxios.post(RELATIONSHOP_URL, {
          followed_id: user_id
        }).then(res => {
          console.log(res)
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
  .list-body {
    background-color: #ffffff;
  }

  .card-title {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 15px;
    color: #ced4da;
  }

  .head-title {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 28px;
    color: #000000;
  }

  .subtitle {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 12px;
    font-weight: bold;
    color: #6c757d;
  }

  .comment {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 11px;
    font-weight: bold;
    color: #121213;
  }
</style>