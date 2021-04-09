<template>
  <div>
    <v-app class="overflow-hidden">
      <v-main class="mt-5 ml-n1">
        <v-row>
          <v-col md=3 lg=3 xl=3 class="ml-9 mr-n3">
            <side-bar />
          </v-col>
          <v-col sm=12 cols=12 md=9 lg=6 xl=9 :class="$vuetify.breakpoint.width > 600 ? 'ml-n16' : 'ml-n4'">
            <!-- <keep-alive> -->
              <router-view />
            <!-- </keep-alive> -->
          </v-col>
          <v-col md=2 lg=3 xl=2 class="ml-1">
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