<template>
  <div>
    <v-app style="background-color:#ffffff">
      <!-- <top-header v-if="this.checkAuthorization()" /> -->
      <v-main class="mt-5">
        <v-row>
          <!-- <v-col md=1 lg=1 xl=1 /> -->
          <v-col md=3 lg=3 xl=3>
            <side-bar />
          </v-col>
          <v-divider vertical />
          <v-col md=6 lg=8 xl=6>
            <!-- <top-header v-if="this.checkAuthorization()" /> -->
            <!-- <keep-alive> -->
              <router-view />
            <!-- </keep-alive> -->
          </v-col>
        </v-row>
      </v-main>
      <!-- <bottom-footer /> -->
    </v-app>
    <base-bottom-bar v-if="this.checkAuthorization()" />
  </div>
</template>

<script>
  import Header from './TheHeader'
  import BaseBottomBar from '../base/BaseBottomBar'
  import SideBar from '../../components/page/TheSideBar'
  import Footer from './TheFooter'

  export default {
    name: 'TheMainPart',
    components: {
      'top-header': Header,
      'bottom-footer': Footer,
      'base-bottom-bar': BaseBottomBar,
      'side-bar': SideBar
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