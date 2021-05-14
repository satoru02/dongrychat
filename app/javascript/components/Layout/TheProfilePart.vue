<template>
  <v-sheet outlined
   @click="showDialog()" :elevation="profilePart.elavation" :width="profilePart.width"
    :height="profilePart.height" :style="style.profilePart" :class="profilePart.round">
    <v-row class="mt-1">
      <v-col md=2 lg=2 xl=2>
        <v-avatar :class="grid.profile" :size="profile.size" :height="profile.height" :style="profile.style">
          <v-img :src="$store.state.currentUser.avatar_url" />
        </v-avatar>
      </v-col>
      <v-col md=10 lg=10 xl=10 :class='grid.profileText'>
        <v-row :class="grid.profileName">
          <v-col md=12 lg=12 xl=12>
            <div class="ml-4 mt-n2" :style="style.name" v-text="this.$store.state.currentUser.name" />
          </v-col>
        </v-row>
        <v-row :class="grid.relationships">
          <v-col md=6 lg=12 xl=6>
            <div class="ml-4 mt-n2" :style="style.relationships"
              v-text="followHeader + blank + this.$store.state.currentUser.following.length" />
            <div class="ml-4 mt-1" :style="style.relationships"
              v-text="followerHeader + blank + this.$store.state.currentUser.follower.length" />
          </v-col>
        </v-row>
      </v-col>
    </v-row>
    <base-profile-dialog v-on:input="offDialog()" :passDialog="dialog" :user="this.$store.state.currentUser" />
  </v-sheet>
</template>

<script>
  import BaseProfileDialog from '../Base/BaseProfileDialog';

  export default {
    name: 'TheProfilePart',
    components: {
      'base-profile-dialog': BaseProfileDialog,
    },
    data() {
      return {
        dialog: false,
        followHeader: 'フォロー',
        followerHeader: 'フォロワー',
        blank: ' ',
        style: {
          profilePart: {
            backgroundColor: '#ffffff',
            cursor: 'pointer'
          },
          name: {
            fontWeight: 'bold',
            fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
            fontSize: '14px',
            color: '#000000'
          },
          relationships: {
            fontWeight: 'bold',
            fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
            fontSize: '6px',
            color: '#6c757d'
          },
        },
        grid: {
          profilePart: 'mt-n3',
          profile: 'ml-3 mt-1',
          profileText: 'mt-1',
          profileName: 'ml-5 mt-n1',
          relationships: 'ml-5 mt-2',
          followers: 'ml-n5',
        },
        profilePart: {
          elevation: 0,
          width: 200,
          height: 111,
          round: 'rounded-lg mt-n2',
        },
        profile: {
          size: 50,
          height: 50,
        },
      }
    },
    methods: {
      showDialog() {
        this.dialog = true
      },
      offDialog(value) {
        this.dialog = value
      }
    }
  }
</script>

<style scoped>
  .theme--light.v-divider {
    border-color: rgba(0, 1, 1, .06);
  }
  .theme--light.v-sheet--outlined[data-v-ceb3cba6] {
    /* border: thin solid rgba(164, 164, 165, 0.12); */
    border: thin solid rgba(121, 121, 121, 0.12);
    
  }
</style>