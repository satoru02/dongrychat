<template>
  <v-sheet
   @click="showDialog()" :elevation="profilePart.elavation" :width="profilePart.width"
    :height="profilePart.height" :style="style.profilePart" :class="profilePart.round">
    <v-row class="mt-n3">
      <v-col md=2 lg=2 xl=2>
        <v-avatar :class="grid.profile" :size="profile.size" :height="profile.height" :style="profile.style">
          <base-avatar :img="'https://cdn.vuetifyjs.com/images/john.jpg'" />
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
            backgroundColor: '#161b22',
            cursor: 'pointer'
          },
          name: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '14px',
            color: '#ced4da'
          },
          relationships: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
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
          round: 'rounded-lg',
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