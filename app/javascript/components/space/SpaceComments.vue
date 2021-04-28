<template>
  <v-container>
    <v-row :class="comment_part.row" v-for="(comment, index) in comments" :key="index">
      <v-col md=1 lg=1 xl=1 :class="comment_part.col">
        <v-badge bordered bottom :color="comment.attributes.user.data.attributes.appearance === true ? 'green accent-4' : 'red'" dot offset-x="8" offset-y="8">
          <v-avatar @click="showDialog(comment.attributes.user.data.attributes)" :class="comment_part.avatar.class" tile
            :size='comment_part.avatar.size' :height='comment_part.avatar.height'>
            <img :src="comment.attributes.user.data.attributes.avatar_url">
          </v-avatar>
        </v-badge>
      </v-col>
      <v-col md=11 lg=11 xl=11 :class="comment_part.inner_col">
        <v-row>
          <v-col md=2 lg=2 xl=2>
            <div :style="comment_part.style.username" v-text="comment.attributes.user.data.attributes.name" />
          </v-col>
          <v-col md=7 lg=9 xl=7 />
          <v-col md=2 lg=1 xl=2 :class="comment_part.countClass">
            <div :style="comment_part.style.count" v-text="formalizeTime(comment.attributes.created_at)" />
          </v-col>
        </v-row>
        <v-row :class="comment_part.text_row">
          <v-col md=12 lg=12 xl=12>
            <div :style="comment_part.style.content" v-text="comment.attributes.content" />
          </v-col>
        </v-row>
      </v-col>
    </v-row>
    <base-profile-dialog v-if="user" v-on:input="offDialog()" :passDialog="dialog" :user="user"
      :followed="this.followed" />
  </v-container>
</template>

<script>
  import moment from 'moment';
  import BaseProfileDialog from '../Base/BaseProfileDialog';
  export default {
    name: 'SpaceComments',
    components: {
      'base-profile-dialog': BaseProfileDialog
    },
    props: {
      comments: {
        type: Array,
        required: true
      },
    },
    data() {
      return {
        dialog: false,
        followed: Boolean,
        user: '',
        follower_length: '',
        following_length: '',
        comment_part: {
          row: 'ml-1 mt-n3',
          col: ' mt-n3',
          inner_col: 'ml-n6',
          countClass: 'mr-n6',
          text_row: 'mt-n6',
          avatar: {
            class: 'rounded-lg mt-3',
            size: '40',
            height: '40'
          },
          style: {
            username: {
              color: '#6c757d',
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '11px'
            },
            count: {
              color: '#6c757d',
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '7px'
            },
            content: {
              color: '#ced4da',
              // fontFamily: 'monospace',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '13px',
              fontWeight: 'bold',
            },
            tabs: {
              color: '#000000',
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '13px'
            },
            tab: {
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '12px'
            }
          }
        },
      }
    },
    methods: {
      showDialog(user) {
        if (this.$store.state.currentUser.following.includes(user.id)) {
          this.followed = true
        } else {
          this.followed = false
        }
        this.user = user
        this.dialog = true
      },
      offDialog(value) {
        this.dialog = value
      },
      formalizeTime(time) {
        return moment(time).format("hh:mm")
      }
    }
  }
</script>