<template>
  <v-container>
    <v-list two-line>
      <v-list-item v-for="(user, index) in users" :key="index">
        <v-list-item-avatar @click="showDialog(user.attributes)">
          <v-img :src="user.attributes.avatar_url" />
        </v-list-item-avatar>
        <v-list-item-content>
          <v-list-item-title :style="nameStyle">
            {{user.attributes.name}}
          </v-list-item-title>
          <v-list-item-subtitle :style="aboutStyle">
            {{user.attributes.about}}
          </v-list-item-subtitle>
        </v-list-item-content>
        <v-list-item-icon v-if="$store.state.currentUser.id != user.id">
          <!-- <v-btn small elevation=0
            :style="checkRelationship(user) ? followingStyle : unfollowStyle"
            @click="checkRelationship(user) ? unfollow(user.attributes.id) : follow(user.attributes.id)">
            {{ checkRelationship(user) ? followingText : unfollowText }}
          </v-btn> -->
        </v-list-item-icon>
      </v-list-item>
    </v-list>
    <base-profile-dialog v-if="user" v-on:input="offDialog()" :passDialog="dialog" :user="user"
      :followed="this.spaceFollowed" />
  </v-container>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios';
  import BaseProfileDialog from '../Base/BaseProfileDialog';
  const RELATIONSHOP_URL = `/api/v1/relationships`;

  export default {
    name: 'SpaceUsers',
    props: ['users'],
    components: {
      'base-profile-dialog': BaseProfileDialog
    },
    data() {
      return {
        dialog: false,
        spaceFollowed: Boolean,
        btnFollowed: false,
        user: '',
        followingText: 'フォロー中',
        followingStyle: {
          backgroundColor: "green",
          fontWeight: "bold",
          fontSize: "10px",
          width: 100,
          height: 25,
          elevation: 0
        },
        unfollowText: 'フォローする',
        unfollowStyle: {
          backgroundColor: "blue",
          fontWeight: "bold",
          color: "#ffffff",
          fontSize: "10px",
          width: 100,
          height: 25
        },
        nameStyle: {
          fontWeight: 'bold',
          fontFamily: '"Hiragino Kaku Gothic ProN", "Hiragino Sans", "BIZ UDPGothic", Meiryo, sans-serif;',
          fontSize: '14px',
          color: '#000000'
        },
        aboutStyle: {
          fontWeight: 'bold',
          fontFamily: '"Hiragino Kaku Gothic ProN", "Hiragino Sans", "BIZ UDPGothic", Meiryo, sans-serif;',
          fontSize: '11px',
          color: '#6c757d',
          lineHeight: '16px',
          maxWidth: "450px",
        },
        relationshipStyle: {
          fontWeight: 'bold',
          fontFamily: '"Hiragino Kaku Gothic ProN", "Hiragino Sans", "BIZ UDPGothic", Meiryo, sans-serif;',
          fontSize: '10px',
          color: '#ffffff'
        }
      }
    },
    methods: {
      showDialog(user) {
        if (this.$store.state.currentUser.following.includes(user.id)) {
          this.spaceFollowed = true
        } else {
          this.spaceFollowed = false
        }
        this.user = user
        this.dialog = true
      },
      offDialog(value) {
        this.dialog = value
      },
      checkRelationship(user) {
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
          this.$store.commit('follow', user_id)
          this.btnFollowed = true
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
          this.btnFollowed = false
        })
      },
    }
  }
</script>