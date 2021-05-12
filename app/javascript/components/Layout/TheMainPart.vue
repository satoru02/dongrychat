<template>
  <v-app style="background-color: #f6f6f9;">
    <the-header />
    <v-main>
      <v-row>
        <v-col lg=3 v-if="$vuetify.breakpoint.width > 600">
          <the-left-bar v-if="this.checkAuthorization() && this.checkRouter()" />
        </v-col>
        <v-col :lg="this.checkRouter() ?  '6' : '8' "
          :class="$vuetify.breakpoint.width > 600 ? grid.deskCenter : grid.mobileCenter">
          <router-view />
        </v-col>
        <v-col lg=3 v-if="$vuetify.breakpoint.width > 600">
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
          deskCenter: '',
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
