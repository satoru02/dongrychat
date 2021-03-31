<template>
  <div>
    <v-app style="background-color:#ffffff">
      <v-main class="mt-5">
        <v-row>
          <v-col md=3 lg=3 xl=3>
            <side-bar class="ml-n11" />
          </v-col>
          <v-divider vertical class="ml-n16" />
          <v-col md=8 lg=9 xl=8 v-if="this.$route.name === 'Top' || this.$route.name === 'Trend' || this.$route.name === 'User' ">
            <!-- <keep-alive> -->
              <router-view />
            <!-- </keep-alive> -->
          </v-col>
          <v-col md=8 lg=7 xl=8 v-else>
            <!-- <keep-alive> -->
              <router-view />
            <!-- </keep-alive> -->
          </v-col>
          <v-col lg=2>
            <right-part />
          </v-col>
        </v-row>
      </v-main>
    </v-app>
    <base-bottom-bar v-if="this.checkAuthorization()" />
  </div>
</template>

<script>
  import Header from './TheHeader'
  import BaseBottomBar from '../base/BaseBottomBar'
  import SideBar from '../../components/page/TheSideBar'
  import Footer from './TheFooter'
  import RightPart from '../page/TheRightPart';

  export default {
    name: 'TheMainPart',
    components: {
      'top-header': Header,
      'bottom-footer': Footer,
      'base-bottom-bar': BaseBottomBar,
      'side-bar': SideBar,
      'right-part': RightPart
    },
    methods: {
      checkAuthorization() {
        let validationRouter = ['Login', 'Signup', 'Authorization']
        if (validationRouter.includes(this.$route.name)) {
          return false
        } else {
          return true
        }
      }
    }
  }
</script>

<style scoped>
</style>