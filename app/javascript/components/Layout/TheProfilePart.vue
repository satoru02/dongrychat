<template>
  <v-card @click="showDialog()" :elevation="profilePart.elavation" outlined :width="profilePart.width"
    :height="profilePart.height" :style="style.profilePart" :class="profilePart.round">
    <v-row>
      <v-col md=2 lg=2 xl=2>
        <v-avatar :class="grid.profile" :size="profile.size" :height="profile.height" :style="profile.style">
          <base-avatar :img="'https://cdn.vuetifyjs.com/images/john.jpg'" />
        </v-avatar>
      </v-col>
      <v-col md=10 lg=10 xl=10 :class='grid.profileText'>
        <v-row :class="grid.profileName">
          <v-col md=12 lg=12 xl=12>
            <div :style="style.name" v-text="this.$store.state.currentUser.name" />
          </v-col>
        </v-row>
        <v-row :class="grid.relationships">
          <v-col md=6 lg=6 xl=6>
            <div :style="style.relationships"
              v-text="followHeader + blank + this.$store.state.currentUser.following.length" />
          </v-col>
          <v-col md=6 lg=6 xl=6 :class="grid.followers">
            <div :style="style.relationships"
              v-text="followerHeader + blank + this.$store.state.currentUser.follower.length" />
          </v-col>
        </v-row>
      </v-col>
    </v-row>
    <base-profile-dialog v-on:input="offDialog()" :passDialog="dialog" :name="this.$store.state.currentUser.name"
      :id="this.$store.state.currentUser.id" :about="this.$store.state.currentUser.about"
      :followings="this.$store.state.currentUser.following.length"
      :followers="this.$store.state.currentUser.follower.length" />
  </v-card>
</template>

<script>
  import BaseProfileDialog from '../Base/BaseProfileDialog';
  import BaseAvatar from '../Base/BaseAvatar';

  export default {
    name: 'TheProfilePart',
    components: {
      'base-profile-dialog': BaseProfileDialog,
      'base-avatar': BaseAvatar,
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
          },
          name: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '14px',
            color: '#011627'
          },
          relationships: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '7px',
            color: '#6c757d'
          },
        },
        grid: {
          profilePart: 'mt-n3',
          profile: 'ml-3 mt-6',
          profileText: 'mt-1',
          profileName: 'ml-5 mt-2',
          relationships: 'ml-5 mt-2',
          followers: 'ml-n5',
        },
        profilePart: {
          elevation: 0,
          width: 350,
          height: 100,
          round: 'rounded-lg',
        },
        profile: {
          size: 55,
          height: 55,
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