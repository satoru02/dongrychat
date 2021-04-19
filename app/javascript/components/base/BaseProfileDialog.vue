<template>
  <v-dialog v-model="change" :width="width" v-if="(user) && (followed === true || followed === false)">
    <v-card>
      <v-card-text :style="style.Name">
        <v-row>
          <v-col md=2 lg=2 xl=2>
            <v-avatar :class="grid.avatar" :size="avatar.size" :height="avatar.height">
              <base-avatar :img="user.avatar_url" />
            </v-avatar>
          </v-col>
          <v-col md=10 lg=10 xl=10>
            <v-row :class="grid.name">
              <v-col md=6 lg=6 xl=6 v-text="user.name" />
              <v-col md=6 lg=6 xl=6 v-if="user.id !== this.$store.state.currentUser.id">
                <v-btn small elevation=0 v-if="this.$store.state.currentUser.id != user.id" :class="roundClass"
                  :style="followed ? followingStyle : unfollowStyle"
                  @click="followed ? unfollow(user.id) : follow(user.id)">
                  {{ followed ? followingText : unfollowText }}
                </v-btn>
              </v-col>
            </v-row>
            <v-row :class="grid.relationship" :style="realtionshipsStyle">
              <v-col md=6 lg=6 xl=6 @click="movePath(user.id, followingsArg)"
                v-text="followHeader + blank + user.following.length" />
              <v-col md=6 lg=6 xl=6 @click="movePath(user.id, followersArg)" :class='grid.Relationship'
                v-text="followerHeader + blank + user.follower.length" />
            </v-row>
            <v-row :class="grid.about">
              <v-col md=12 lg=12 xl=12 v-text="user.about" />
            </v-row>
            <v-row :class="grid.sns">
              <v-col md=1 lg=1 xl=1>
                <v-icon :size="mdi.size" v-text="mdi.twitter" />
              </v-col>
              <v-col md=1 lg=1 xl=1 :class="grid.mdi">
                <v-icon :size="mdi.size" v-text="mdi.instagram" />
              </v-col>
              <v-col md=1 lg=1 xl=1 :class="grid.mdi">
                <v-icon :size="mdi.size" v-text="mdi.facebook" />
              </v-col>
              <v-col md=1 lg=1 xl=1 :class="grid.mdi">
                <v-icon :size="mdi.size" v-text="mdi.youtube" />
              </v-col>
            </v-row>
          </v-col>
        </v-row>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios';
  const RELATIONSHOP_URL = `/api/v1/relationships`;
  import BaseAvatar from '../Base/BaseAvatar';
  export default {
    name: 'BaseProfileDialog',
    components: {
      'base-avatar': BaseAvatar
    },
    props: {
      user: {
        type: Object,
      },
      passDialog: {
        type: Boolean
      },
      followed: {
        type: Boolean,
      },
    },
    computed: {
      change: {
        get: function () {
          return this.dialog = this.passDialog
        },
        set: function () {
          this.$emit('input', false);
        }
      }
    },
    data() {
      return {
        width: 500,
        dialog: false,
        blank: ' ',
        followHeader: 'フォロー',
        followerHeader: 'フォロワー',
        followingsArg: 'followings',
        followersArg: 'followers',
        dialogFollowed: this.followed,
        grid: {
          avatar: 'mt-8 ml-3',
          name: 'ml-5 mt-5',
          relationship: 'ml-5 mt-n2',
          betweenRelationshop: 'ml-n10',
          about: 'ml-5 mt-n2',
          sns: 'ml-5 mt-2',
          mdi: 'ml-2'
        },
        style: {
          Name: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '14px',
            color: '#011627'
          }
        },
        color: {
          white: '#ffffff'
        },
        mdi: {
          twitter: 'mdi-twitter',
          instagram: 'mdi-instagram',
          facebook: 'mdi-facebook',
          youtube: 'mdi-youtube',
          size: 20
        },
        avatar: {
          size: 70,
          height: 70
        },
        followingText: 'フォロー中',
        followingStyle: {
          backgroundColor: "#343a40",
          fontWeight: "bold",
          fontSize: "6px",
          color: '#ffffff',
          width: 70,
          height: 25,
        },
        unfollowText: 'フォローする',
        unfollowStyle: {
          backgroundColor: "#2d00f7",
          fontWeight: "bold",
          fontSize: "6px",
          color: '#ffffff',
          width: 75,
          height: 25,
        },
        roundClass: {
          rounded: "lg"
        },
        realtionshipsStyle: {
          fontWeight: 'bold',
          fontFamily: 'Helvetica Neue, sans-serif',
          fontSize: '7px',
          color: '#6c757d'
        }
      }
    },
    methods: {
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
      movePath(user_id, relationship) {
        this.$router.push({
          path: `/users/${user_id}/${relationship}`
        })
      },
    }
  }
</script>