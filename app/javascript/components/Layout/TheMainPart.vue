<template>
  <v-app :class="grid.app" style="background-color: #121214;">
    <the-header />
    <v-main class="mt-2">
      <v-row>
        <v-col md=3 lg=2 xl=3 class='ml-n6 mt-3' v-if="$vuetify.breakpoint.width > 600">
          <the-left-bar v-if="this.checkAuthorization()" />
        </v-col>
        <v-col sm=12 cols=12 md=6 :lg="this.checkRouter() ?  '7' : '10' " xl=6
          :class="$vuetify.breakpoint.width > 600 ? grid.deskCenter : grid.mobileCenter">
          <router-view />
        </v-col>
        <v-col md=3 lg=2 xl=3 :class="grid.rightPart" v-if="$vuetify.breakpoint.width > 600">
          <the-right-bar v-if="this.checkAuthorization() && this.checkRouter()" />
        </v-col>
      </v-row>
    </v-main>
    <base-bottom-bar v-if="this.checkAuthorization() " />
  </v-app>
</template>

<script>
  import TheHeader from './TheHeader';
  import TheLeftBar from './TheLeftBar';
  import TheRightBar from './TheRightBar';
  import BaseBottomBar from '../Base/BaseBottomBar';

  export default {
    name: 'TheMainPart',
    components: {
      'the-header': TheHeader,
      'the-left-bar': TheLeftBar,
      'the-right-bar': TheRightBar,
      'base-bottom-bar': BaseBottomBar
    },
    data() {
      return {
        grid: {
          app: 'overflow-hidden ml-6',
          deskCenter: ' ml-6',
          mobileCenter: 'ml-n16',
          rightPart: 'mt-3 ml-16'
        }
      }
    },
    methods: {
      checkAuthorization() {
        let validationRouter = ['Login', 'Signup', 'Authorization', 'ResetPassword', 'ForgotPassword']
        if (validationRouter.includes(this.$route.name)) {
          return false
        } else {
          return true
        }
      },
      checkRouter() {
        let spaceRoute = [
          'Home',
          'Chart',
          'NotificationTop'
        ]
        if (spaceRoute.includes(this.$route.name)) {
          return true
        } else {
          return false
        }
      }
    }
  }
</script>

<style scoped>
</style>