<template>
  <v-container :class="vContainer">
    <v-row v-for="(comment, index) in comments" :key="index" class="mb-n1">
      <v-col cols=2 sm=2 md=1 lg=1 xl=1 :class="vColAvatarGrid">
        <v-avatar @click="goUserPage(comment.attributes.user.data.attributes)" :style="avatar.style"
          :size='avatar.size' :height='avatar.height'>
          <img outlined v-if="comment.attributes.user.data.attributes.avatar_url"
            :src="comment.attributes.user.data.attributes.avatar_url">
          <span v-else>
            <icon-base :width="'20'" :height="'20'" icon-name="icon-user" :iconColor="'#ffffff'"
              :viewBox="'-42 0 512 512.002'">
              <icon-user />
            </icon-base>
          </span>
        </v-avatar>
      </v-col>
      <v-col cols=10 sm=10 md=11 lg=11 xl=11 :class="vColNameGrid">
        <div :style="username.style">{{comment.attributes.user.data.attributes.name}}</div>
        <div :style="time.style">{{formalizeTime(comment.attributes.created_at)}}</div>
      </v-col>
      <v-row>
      <v-col cols=12 md=12 lg=12 class="ml-4">
        <p>{{comment.attributes.content}}</p>
      </v-col>
    </v-row>
    </v-row>
  </v-container>
</template>

<script>
  import moment from 'moment';
  moment.locale('ja');

  export default {
    name: 'SpaceComments',
    components: {
      'icon-base': () => import( /* webpackPrefetch */ '../Icon/IconBase'),
      'icon-user': () => import( /* webpackPrefetch */ '../Icon/IconUser'),
    },
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
          size: '38',
          height: '38',
          style: {
            cursor: 'pointer',
            // color: '#111111',
          }
        },
        username: {
          style: {
            color: '#111111',
            fontWeight: 'bold',
            fontSize: '13px'
          }
        },
        time: {
          style: {
            color: '#6c757d',
            // fontWeight: 'bold',
            fontSize: '13px'
          }
        },
        content: {
          style: {
            color: '#000000',
            fontSize: '18px',
            fontWeight: '700',
          }
        }
      }
    },
    methods: {
      goUserPage(user) {
        this.$router.replace(`/users/${user.id}/watchlists`)
      },
      formalizeTime(time) {
        return moment(time).fromNow()
      }
    },
    computed: {
      vContainer() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-n4 mt-n4'
          case 'sm':
          case 'md':
            return 'ml-2'
          case 'lg':
            return 'mt-n7 ml-2'
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
            return 'ml-n2'
          case 'sm':
            return 'ml-n3'
          case 'md':
            return ''
          case 'lg':
            return 'ml-n2'
          case 'xl':
            return ''
        }
      },
      vColAvatarGrid() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return ''
          case 'sm':
            return ''
          case 'md':
            return ''
          case 'lg':
            return ''
          case 'xl':
            return 'mt-n9'
        }
      }
    }
  }
</script>

<style scoped>
</style>