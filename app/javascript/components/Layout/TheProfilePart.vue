<template>
  <v-sheet outlined class="profile-part rounded-lg mt-n2" color="#f5f8fa"
   @click="goUserPage($store.state.currentUser)" elevation="0" width="230"
    height='95'>
    <v-row class="mt-1">
      <v-col cols=2 sm=2 md=2 lg=2 xl=2>
        <v-avatar class="ml-3 mt-1" size="50" height="50">
          <v-img :src="$store.state.currentUser.avatar_url" />
        </v-avatar>
      </v-col>
      <v-col cols=10 sm=10 md=10 lg=10 xl=10>
        <v-row class="ml-5 mt-n1">
          <v-col md=12 lg=12 xl=12>
            <div class="your-name ml-4 mt-n2" v-text="this.$store.state.currentUser.name" />
          </v-col>
        </v-row>
        <v-row class="ml-5 mt-2">
          <v-col cols=6 sm=6 md=6 lg=12 xl=12>
            <div class="relationships ml-4 mt-n2"
              v-text="followHeader + blank + this.$store.state.currentUser.following.length" />
            <div class="relationships ml-4 mt-1"
              v-text="followerHeader + blank + this.$store.state.currentUser.follower.length" />
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-sheet>
</template>

<script>
  export default {
    name: 'TheProfilePart',
    data() {
      return {
        followHeader: 'フォロー',
        followerHeader: 'フォロワー',
        blank: ' ',
      }
    },
    methods: {
      goUserPage(user) {
        this.$router.replace({name: 'UserTop', params: {
          user_name: user.name,
        } })
      }
    }
  }
</script>

<style scoped>
  .profile-part {
    font-family: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif';
    cursor: pointer;
  }

  .your-name {
    font-weight: bold;
    font-size: 14px;
    color: #000000;
  }

  .relationships {
    font-weight: bold;
    font-size: 6px;
    color: #6c757d;
  }

  .theme--light.v-divider {
    border-color: rgba(0, 1, 1, .06);
  }
  .theme--light.v-sheet--outlined {
    /* border: thin solid rgba(121, 121, 121, 0.12); */
    border: thin solid rgba(172, 172, 172, 0.12);

  }
</style>