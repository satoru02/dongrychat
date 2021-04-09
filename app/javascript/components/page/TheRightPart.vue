<template>
  <v-container v-if="$vuetify.breakpoint.width > 600" :class="right_part.position">
    <v-row>
      <v-col md=12 lg=12 xl=12>
        <v-text-field v-model="query" @keydown.enter="search(query)" :color="text_field.color"
          prepend-inner-icon="mdi-magnify" dense :class="text_field.round" outlined :max-width="text_field.width"
          :placeholder="text_field.placeholder" />
      </v-col>
    </v-row>
    <v-row :class="profile_part.position">
      <v-col md=12 lg=12 xl=12>
        <v-card @click="popupProfile()" :elevation="profile_part.elavation" outlined :width="profile_part.width"
          :height="profile_part.height" :style="profile_part.style" :class="profile_part.round">
          <v-row>
            <v-col md=2 lg=2 xl=2>
              <!-- <v-badge color="green" bordered right offset-x="15" offset-y="70" overlap> -->
              <v-avatar :class="profile.position" :size="profile.size" :height="profile.height" :style="profile.style">
                <img src="https://cdn.vuetifyjs.com/images/john.jpg">
              </v-avatar>
            </v-col>
            <v-col md=10 lg=10 xl=10 class=mt-1>
              <v-row class="ml-5 mt-2">
                <v-col md=12 lg=12 xl=12>
                  <div :style="name_title.style">{{this.$store.state.currentUser.name}}</div>
                </v-col>
              </v-row>
              <v-row class="ml-5 mt-n2">
                <v-col md=6 lg=6 xl=6>
                  <div :style="relationship.style">フォロー {{this.$store.state.currentUser.following.length}}</div>
                </v-col>
                <v-col md=6 lg=6 xl=6 class=ml-n5>
                  <div :style="relationship.style">フォロワー {{this.$store.state.currentUser.follower.length}}</div>
                </v-col>
              </v-row>
            </v-col>
          </v-row>
        </v-card>
      </v-col>
    </v-row>
    <v-row :class="online_part.position">
      <v-col md=12 lg=12 xl=12>
        <h3 :style="item_title.style" v-text="online_part.title" />
      </v-col>
    </v-row>
    <v-row v-for="(n,index) in 5" :key="index">
      <v-col md=1 lg=1 xl=1>
        <v-avatar :size="avatar.size" :height="avatar.height" :style="avatar.style">
          <img src="https://cdn.vuetifyjs.com/images/john.jpg" alt="John">
        </v-avatar>
      </v-col>
      <v-col md=1 lg=1 xl=1 />
      <v-col md=8 lg=8 xl=8 class="mt-3">
        <h3 :style="name_title.style" v-text="'username'" />
      </v-col>
    </v-row>
    <v-dialog v-model="dialog" width="500">
      <v-card>
        <v-card-text :style="name_title.style">
          <v-row>
            <v-col lg=2>
              <v-avatar class="mt-8" size=70 height=70>
                <img src="https://cdn.vuetifyjs.com/images/john.jpg" alt="John">
              </v-avatar>
            </v-col>
            <v-col lg=10>
              <v-row class="ml-5 mt-5">
                <v-col lg=12>
                  {{this.$store.state.currentUser.name}}
                </v-col>
              </v-row>
              <v-row class="ml-5 mt-n2">
                <v-col md=6 lg=6 xl=6>
                  <div :style="relationship.style">フォロー {{this.$store.state.currentUser.following.length}}</div>
                </v-col>
                <v-col md=6 lg=6 xl=6 class=ml-n10>
                  <div :style="relationship.style">フォロワー {{this.$store.state.currentUser.follower.length}}</div>
                </v-col>
              </v-row>
              <v-row class="ml-5 mt-n2">
                <v-col lg=12>
                  {{this.$store.state.currentUser.about}}
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
    </v-dialog>
  </v-container>
</template>

<script>
  export default {
    name: "RightPart",
    data() {
      return {
        query: '',
        dialog: false,
        right_part: {
          position: 'ml-n10'
        },
        text_field: {
          position: 'mt-n4 ml-n8 mr-3',
          color: '#000000',
          placeholder: '検索',
          round: 'rounded-lg',
          width: 250,
        },
        profile_part: {
          position: 'mt-n3',
          elevation: 0,
          width: 250,
          height: 100,
          round: 'rounded-lg',
          style: {
            backgroundColor: '#ffffff',
          }
        },
        item_title: {
          style: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '20px',
            color: '#011627'
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
        relationship: {
          style: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '7px',
            color: '#6c757d'
          }
        },
        follow: {
          style: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '8px',
            color: '#011627'
          }
        },
        online_part: {
          title: 'Online',
          position: 'mt-7'
        },
        avatar: {
          size: 45,
          height: 45,
          style: {
            borderStyle: 'solid',
            borderWidth: '0.14em',
            borderColor: '#3f37c9'
          }
        },
        profile: {
          position: "ml-3 mt-6",
          size: 55,
          height: 55,
          style: {}
        },
      }
    },
    methods: {
      search(query) {
        this.$router.replace({
          name: 'multi',
          params: {
            query: query
          }
        })
      },
      popupProfile() {
        this.dialog = true
        // popup表示
      }
    }
  }
</script>

<style scoped>
  .v-text-field {
    width: 250px;
  }
</style>