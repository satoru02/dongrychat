<template>
  <div>
    <v-app style="background-color:#ffffff;" class="overflow-hidden">
      <v-main class="mt-5">
        <v-row>
          <v-col lg=1 class="ml-n16" />
          <v-col md=3 lg=3 xl=3 class="ml-n14">
            <side-bar class="ml-4" />
          </v-col>
          <v-col md=9 lg=7 xl=9 class="ml-n16">
            <!-- <keep-alive> -->
              <router-view />
            <!-- </keep-alive> -->
          </v-col>
          <v-col md=2 lg=2 xl=2 class="ml-n6">
            <right-part />
          </v-col>
        </v-row>
      </v-main>
    </v-app>
    <base-bottom-bar v-if="this.checkAuthorization()" />
  </div>
</template>

<script>
  import BaseBottomBar from '../base/BaseBottomBar'
  import SideBar from '../../components/page/TheSideBar'
  import RightPart from '../page/TheRightPart';

  export default {
    name: 'TheMainPart',
    components: {
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