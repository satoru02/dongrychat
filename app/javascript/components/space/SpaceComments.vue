<template>
  <div :class="vContainer">
    <v-row v-for="(comment, index) in comments" :key="index" class="mb-n1 ml-13">
      <!-- <v-col lg=1></v-col> -->
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 :class="vColAvatarGrid">
        <v-avatar class="mt-3" @click="goUserPage(comment.attributes.user.data.attributes)" :style="avatar.style"
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
      <v-col cols=11 sm=11 md=11 lg=11 xl=11 :class="vColNameGrid">
        <v-row>
          <v-col cols=12 sm=12 md=12 lg=12 xl=12 class="ml-9">
            <div :style="username.style">{{comment.attributes.user.data.attributes.name}}</div>
            <div :style="time.style">{{formalizeTime(comment.attributes.created_at)}}</div>
          </v-col>
        </v-row>
      </v-col>
          <v-row>
      <v-col lg=12 class="ml-4">
        <p>{{comment.attributes.content}}</p>
      </v-col>
    </v-row>
    </v-row>
  </div>
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
            return 'ml-n4'
          case 'sm':
            return 'mt-7'
          case 'md':
            return 'mt-7'
          case 'lg':
            return 'mt-n7'
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
            return 'ml-n11'
          case 'xl':
            return 'mt-n6'
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