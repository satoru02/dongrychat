<template>
  <v-dialog v-model="change" :width="width">
    <v-card>
      <v-card-text :style="style.Name">
        <v-row>
          <v-col md=2 lg=2 xl=2>
            <v-avatar :class="grid.avatar" :size="avatar.size" :height="avatar.height">
              <base-avatar :img="'https://cdn.vuetifyjs.com/images/john.jpg'" />
            </v-avatar>
          </v-col>
          <v-col md=10 lg=10 xl=10>
            <v-row :class="grid.name">
              <v-col md=12 lg=12 xl=12 v-text="name" />
            </v-row>
            <v-row :class="grid.relationship">
              <v-col md=6 lg=6 xl=6 @click="movePath(id, followingsArg)" v-text="followHeader + blank + followings" />
              <v-col md=6 lg=6 xl=6 @click="movePath(id, followersArg)" :class='grid.Relationship'
                v-text="followerHeader + blank + followers" />
            </v-row>
            <v-row :class="grid.about">
              <v-col md=12 lg=12 xl=12 v-text="about" />
            </v-row>
            <v-row :class="grid.sns">
              <v-col md=1 lg=1 xl=1>
                <v-icon :size="mdi.size" v-text="mdi.twitter" />
              </v-col>
              <v-col md=1 lg=1 xl=1 :class="grid.mdi">
                <v-icon :size="mdi.size" v-text="mdi.instagram" />
              </v-col>
              <v-col md=1 lg=1 xl=1 :class="grid.mdi">
                <v-icon :size="mdi.size" v-text="mdi.facebook" />
              </v-col>
              <v-col md=1 lg=1 xl=1 :class="grid.mdi">
                <v-icon :size="mdi.size" v-text="mdi.youtube" />
              </v-col>
            </v-row>
          </v-col>
        </v-row>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
  import BaseAvatar from '../Base/BaseAvatar';
  export default {
    name: 'BaseProfileDialog',
    components: {
      'base-avatar': BaseAvatar
    },
    props: {
      passDialog: {
        type: Boolean
      },
      id: {
        type: Number
      },
      name: {
        type: String
      },
      followings: {
        type: Number
      },
      followers: {
        type: Number
      },
      about: {
        type: String
      }
    },
    computed: {
      change: {
        get: function () {
          return this.dialog = this.passDialog
        },
        set: function () {
          this.$emit('input', false);
        }
      }
    },
    data() {
      return {
        width: 500,
        dialog: false,
        blank: ' ',
        followHeader: 'フォロー',
        followerHeader: 'フォロワー',
        followingsArg: 'followings',
        followersArg: 'followers',
        grid: {
          avatar: 'mt-8 ml-3',
          name: 'ml-5 mt-5',
          relationship: 'ml-5 mt-n2',
          betweenRelationshop: 'ml-n10',
          about: 'ml-5 mt-n2',
          sns: 'ml-5 mt-2',
          mdi: 'ml-2'
        },
        style: {
          Name: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '14px',
            color: '#011627'
          }
        },
        mdi: {
          twitter: 'mdi-twitter',
          instagram: 'mdi-instagram',
          facebook: 'mdi-facebook',
          youtube: 'mdi-youtube',
          size: 20
        },
        avatar: {
          size: 70,
          height: 70
        }
      }
    },
    methods: {
      movePath(user_id, relationship) {
        this.$router.push({
          path: `/users/${user_id}/${relationship}`
        })
      },
    }
  }
</script>