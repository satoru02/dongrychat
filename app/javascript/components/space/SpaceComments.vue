<template>
  <div :class="vContainer">
    <v-row v-for="(comment, index) in comments" :key="index" class="mt-n9">
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 :class="vColAvatarGrid">
        <v-avatar class="mt-3" @click="goUserPage(comment.attributes.user.data.attributes)" :style="avatar.style"
          :size='avatar.size' :height='avatar.height'>
          <img :src="comment.attributes.user.data.attributes.avatar_url">
        </v-avatar>
      </v-col>
      <v-col cols=11 sm=11 md=11 lg=11 xl=11 :class="vColNameGrid">
        <v-row>
          <v-col cols=12 sm=12 md=12 lg=12 xl=12 class="ml-4">
            <span :style="username.style">{{comment.attributes.user.data.attributes.name}}</span>
            <span :style="time.style">・ {{formalizeTime(comment.attributes.created_at)}}</span>
          </v-col>
        </v-row>
        <v-container class="ml-1 mt-n6" :style="content.style">
          <p>{{comment.attributes.content}}</p>
        </v-container>
      </v-col>
    </v-row>
  </div>
</template>

<script>
  import moment from 'moment';
  moment.locale('ja');

  export default {
    name: 'SpaceComments',
    props: {
      comments: {
        type: Array,
        required: true
      },
    },
    data() {
      return {
        followed: Boolean,
        user: '',
        follower_length: '',
        following_length: '',
        avatar: {
          size: '32',
          height: '32',
          style: {
            cursor: 'pointer'
          }
        },
        username: {
          style: {
            color: '#495057',
            fontWeight: 'bold',
            fontSize: '12px'
          }
        },
        time: {
          style: {
            color: '#6c757d',
            // fontWeight: 'bold',
            fontSize: '6px'
          }
        },
        content: {
          style: {
            color: '#000000',
            fontSize: '14px',
          }
        }
      }
    },
    methods: {
      goUserPage(user) {
        this.$router.push({
          name: 'UserTop',
          params: {
            // user_name: user.name,
            user_id: user.id
          }
        })
      },
      formalizeTime(time) {
        return moment(time).fromNow()
      }
    },
    computed: {
      vContainer() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-n4'
          case 'sm':
            return 'mt-7'
          case 'md':
            return 'mt-7'
          case 'lg':
            return 'mt-5'
          case 'xl':
            return 'mt-n9'
        }

      },
      vRowContentGrid() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'mt-n5'
          case 'sm':
            return 'mt-7'
          case 'md':
            return 'mt-7'
          case 'lg':
            return 'ml-4'
          case 'xl':
            return 'mt-n9'
        }
      },
      vColNameGrid() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'mt-n16 ml-11'
          case 'sm':
            return 'mt-7'
          case 'md':
            return 'mt-7'
          case 'lg':
            return 'ml-n7 mt-n2'
          case 'xl':
            return 'mt-n9'
        }
      },
      vColAvatarGrid() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'mt-n3 ml-n2'
          case 'sm':
            return 'mt-7'
          case 'md':
            return 'mt-7'
          case 'lg':
            return 'mt-n3'
          case 'xl':
            return 'mt-n9'
        }
      }
    }
  }
</script>

<style scoped>
</style>