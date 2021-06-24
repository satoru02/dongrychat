<template>
  <v-container :class="this.$vuetify.breakpoint.width < 600 ? 'ml-16' : ''">
    <v-list-item-group style="background-color: #ffffff;" v-for="(user, index) in relationships" :key="index" multiple>
      <v-list-item>
        <template>
          <v-list-item-avatar color="#dee2e6" icon size=38 height=38 @click="goUserPage(user)">
            <v-img :src="user.attributes.avatar_url" />
          </v-list-item-avatar>
          <v-list-item-content class=ml-5>
            <v-list-item-title class="card-title">
              {{user.attributes.name}}
            </v-list-item-title>
          </v-list-item-content>
          <v-list-item-action class="ml-n5">
            <v-btn class="rounded" small elevation=0 v-if="$store.state.user.currentUser.id != user.id"
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
        followed: false,
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