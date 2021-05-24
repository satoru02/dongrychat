<template>
  <div :class="vContainer">
    <v-row class="mb-n3" v-for="(comment, index) in comments" :key="index">
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 :class="vColAvatarGrid">
        <v-badge :color="comment.attributes.user.data.attributes.appearance === true ? 'green accent-4' : 'red'"
          offset-x="6" offset-y="6" bordered bottom dot overlap>
          <v-avatar class="rounded-lg mt-3" @click="goUserPage(comment.attributes.user.data.attributes)"
            :style="avatar.style" :size='avatar.size' :height='avatar.height' tile>
            <img :src="comment.attributes.user.data.attributes.avatar_url">
          </v-avatar>
        </v-badge>
      </v-col>
      <v-col cols=11 sm=11 md=11 lg=11 xl=11 :class="vColNameGrid">
        <v-row>
          <v-col cols=12 sm=12 md=12 lg=12 xl=12 :style="username.style" class="ml-4">
            {{comment.attributes.user.data.attributes.name}}・{{formalizeTime(comment.attributes.created_at)}}
          </v-col>
        </v-row>
        <v-row>
          <v-col cols=12 sm=12 md=12 lg=12 xl=12 :class="vRowContentGrid" :style="content.style" v-text="comment.attributes.content" />
        </v-row>
      </v-col>
    </v-row>
    <base-profile-dialog v-if="user" v-on:input="offDialog()" :passDialog="dialog" :user="user"
      :followed="this.followed" />
  </div>
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
        avatar: {
          size: '40',
          height: '40',
          style: {
            cursor: 'pointer'
          }
        },
        username: {
          style: {
            color: '#6c757d',
            fontWeight: 'bold',
            fontSize: '13px'
          }
        },
        time: {
          style: {
            color: '#6c757d',
            fontWeight: 'bold',
            fontSize: '7px'
          }
        },
        content: {
          style: {
            color: '#111111',
            fontSize: '15px',
          }
        }
      }
    },
    methods: {
      showDialog(user) {
        if (this.$store.state.user.currentUser.following.includes(user.id)) {
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
      goUserPage(user){
        this.$router.push({name: 'UserTop', params: {
          user_name: user.name,
          user_id: user.id
        } })
      },
      formalizeTime(time) {
        return moment(time).format("hh:mm")
      }
    },
    computed:{
      vContainer(){
        switch(this.$vuetify.breakpoint.name){
          case 'xs' : return 'ml-n4'
          case 'sm' : return 'mt-7'
          case 'md' : return 'mt-7'
          case 'lg' : return ''
          case 'xl' : return 'mt-n9'
        }

      },
      vRowContentGrid(){
        switch(this.$vuetify.breakpoint.name){
          case 'xs' : return 'mt-n5'
          case 'sm' : return 'mt-7'
          case 'md' : return 'mt-7'
          case 'lg' : return 'mt-n5 ml-4'
          case 'xl' : return 'mt-n9'
        }
      },
      vColNameGrid(){
        switch(this.$vuetify.breakpoint.name){
          case 'xs' : return 'mt-n16 ml-11'
          case 'sm' : return 'mt-7'
          case 'md' : return 'mt-7'
          case 'lg' : return 'ml-n6 mt-n1'
          case 'xl' : return 'mt-n9'
        }
      },
      vColAvatarGrid(){
        switch(this.$vuetify.breakpoint.name){
          case 'xs' : return 'mt-n3 ml-n2'
          case 'sm' : return 'mt-7'
          case 'md' : return 'mt-7'
          case 'lg' : return 'mt-n3'
          case 'xl' : return 'mt-n9'
        }
      }
    }
  }
</script>