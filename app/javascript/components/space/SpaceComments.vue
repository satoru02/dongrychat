<template>
  <v-container>
    <v-row :class="comment_part.row" v-for="(comment, index) in comments" :key="index">
      <v-col md=1 lg=1 xl=1 :class="comment_part.col">
        <v-avatar @click="popupProfile(comment.attributes.user.data.attributes)" :class="comment_part.avatar.class" tile
          :size='comment_part.avatar.size' :height='comment_part.avatar.height'>
          <img :src="comment.attributes.user.data.attributes.avatar_url">
        </v-avatar>
      </v-col>
      <v-col md=11 lg=11 xl=11 :class="comment_part.inner_col">
        <v-row>
          <v-col md=3 lg=3 xl=3>
            <div :style="comment_part.style.username" v-text="comment.attributes.user.data.attributes.name" />
          </v-col>
          <v-col md=7 lg=7 xl=7 />
          <v-col md=2 lg=2 xl=2 :class="comment_part.countClass">
            <div :style="comment_part.style.count" v-text="formalizeTime(comment.attributes.created_at)" />
          </v-col>
        </v-row>
        <v-row :class="comment_part.text_row">
          <v-col md=12 lg=12 xl=12>
            <div :style="comment_part.style.content" v-text="comment.attributes.content" />
          </v-col>
        </v-row>
      </v-col>
    </v-row>
<!--
    <base-profile-dialog v-on:input="offDialog()" :passDialog="dialog" :name="this.$store.state.currentUser.name"
      :id="this.$store.state.currentUser.id" :about="this.$store.state.currentUser.about"
      :followings="this.$store.state.currentUser.following.length"
      :followers="this.$store.state.currentUser.follower.length" /> -->

    <!-- <v-dialog v-model="dialog" width="500">
      <v-card>
        <v-card-text :style="name_title.style">
          <v-row>
            <v-col lg=2>
              <v-avatar class="mt-8" size=70 height=70>
                <img :src="user_pop.avatar_url">
              </v-avatar>
            </v-col>
            <v-col lg=10>
              <v-row class="ml-5 mt-5">
                <v-col lg=6>
                  {{this.user_pop.name}}
                </v-col>
                <v-col lg=6>
                  <v-btn small elevation=0 v-if="this.$store.state.currentUser.id != this.user_pop.id"
                    :class="roundClass" :style="followed ? followingStyle : unfollowStyle"
                    @click="followed ? unfollow(user_pop.id) : follow(user_pop.id)">
                    {{ followed ? followingText : unfollowText }}
                  </v-btn>
                </v-col>
              </v-row>
              <v-row class="ml-5 mt-n2">
                <v-col md=6 lg=6 xl=6 @click="movePath(user_pop, 'followings')">
                  <div :style="relationship.style">フォロー {{this.following_length}}
                  </div>
                </v-col>
                <v-col md=6 lg=6 xl=6 class=ml-n10 @click="movePath(user_pop, 'followers')">
                  <div :style="relationship.style">フォロワー {{this.follower_length}}</div>
                </v-col>
              </v-row>
              <v-row class="ml-5 mt-n2">
                <v-col lg=12>
                  {{this.user_pop.about}}
                </v-col>
              </v-row>
              <v-row class="ml-5 mt-2">
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
          </v-row>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
        </v-card-actions>
      </v-card>
    </v-dialog> -->
  </v-container>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios';
  import moment from 'moment';
  import BaseProfileDialog from '../Base/BaseProfileDialog';
  const RELATIONSHOP_URL = `/api/v1/relationships`;
  export default {
    name: 'SpaceComments',
    components: {
      'base-profile-dialog': BaseProfileDialog
    },
    props: {
      comments: {
        type: Array,
        required: true
      }
    },
    data() {
      return {
        dialog: false,
        followed: Boolean,
        user_pop: '',
        follower_length: '',
        following_length: '',
        comment_part: {
          row: 'ml-1 mt-n3',
          col: ' mt-n3',
          inner_col: 'ml-n4',
          countClass: '',
          text_row: 'mt-n6',
          avatar: {
            class: 'rounded-lg mt-3',
            size: '40',
            height: '40'
          },
          style: {
            username: {
              color: '#6c757d',
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '11px'
            },
            count: {
              color: '#6c757d',
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '7px'
            },
            content: {
              color: '#000000',
              // fontWeight: 'bold',
              fontFamily: 'monospace',
              fontSize: '13px'
            },
            tabs: {
              color: '#000000',
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '13px'
            },
            tab: {
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '12px'
            }
          }
        },
        relationship: {
          style: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '7px',
            color: '#6c757d'
          }
        },
        name_title: {
          style: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '14px',
            color: '#011627'
          }
        },
        roundClass: {
          rounded: "lg"
        },
        followingText: 'フォローする',
        followingStyle: {
          backgroundColor: "#343a40",
          fontWeight: "bold",
          fontSize: "10px",
          width: 50,
          height: 40,
          elevation: 0
        },
        unfollowText: 'フォローした',
        unfollowStyle: {
          backgroundColor: "#2d00f7",
          fontWeight: "bold",
          fontSize: "10px",
          width: 50,
          height: 35
        }
      }
    },
    methods: {
      popupProfile(user) {
        if (this.$store.state.currentUser.following.includes(user.id)) {
          this.followed = true
        } else {
          this.followed = false
        }
        this.dialog = true
        this.user_pop = user
        this.follower_length = user.follower.length
        this.following_length = user.following.length
      },
      movePath(user, relationship) {
        this.$router.push({
          path: `/users/${user.id}/${relationship}`
        })
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
      showDialog() {
        this.dialog = true
      },
      offDialog(value) {
        this.dialog = value
      },
      formalizeTime(time) {
        return moment(time).format("YYYY/MM/DD hh:mm")
      },
    }
  }
</script>