<template>
  <v-container :class="this.$vuetify.breakpoint.width < 600 ? 'ml-16' : ''">
    <v-list-item-group style="background-color: #ffffff;" v-for="(user, index) in relationships" :key="index" multiple
      class="list-body">
      <v-list-item @click="goUserPage(user)">
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
            <v-btn small elevation=0 v-if="$store.state.user.currentUser.id != user.id"
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
        this.$router.replace({name: 'UserTop', params: {
          user_name: user.attributes.name
        }})
      }
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
    color: #111111;
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