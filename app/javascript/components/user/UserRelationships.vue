<template>
  <v-container>
    <v-list-item-group
      v-for="(user, index) in relationships"
      :key="index"
      style="background-color: #ffffff;"
      multiple>
      <v-list-item>
        <template>
          <v-list-item-avatar
            color="#dee2e6"
            icon
            size=38
            height=38
            @click="goUserPage(user)">
            <v-img :src="user.attributes.avatar_url" />
          </v-list-item-avatar>
          <v-list-item-content class=ml-5>
            <v-list-item-title class="card-title">
              {{user.attributes.name}}
            </v-list-item-title>
          </v-list-item-content>
          <v-list-item-action class="ml-n5">
            <v-btn
              v-if="$store.state.user.currentUser.id != user.id"
              class="rounded"
              small
              elevation=0
              :style="checkRelationship(user) ? followingStyle : unfollowStyle"
              :outlined="checkRelationship(user) ? true : false"
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
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const relationshipsRepository = RepositoryFactory.get('relationships');

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
        isFollowed: false,
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
    methods: {
      checkRelationship(user) {
        if (this.$store.state.user.currentUser.following.includes(user.attributes.id)) {
          return true
        } else {
          return false
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
      goUserPage(user){
        this.$router.replace({name: 'watchlists', params: {
          user_id: user.attributes.id
        }})
      }
    }
  }
</script>

<style scoped>
  .card-title {
    font-weight: bold;
    font-size: 14px;
    color: #111111;
  }
</style>