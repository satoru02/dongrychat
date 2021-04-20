<template>
  <div>
    <v-app :class="grid.app">
      <v-main :class="grid.main">
        <v-row>
          <v-col md=3 lg=2 xl=3 class='ml-n11' v-if="$vuetify.breakpoint.width > 600">
            <side-bar v-if="this.checkAuthorization()" />
          </v-col>
          <v-divider vertical class="mr-n4 ml-16" v-if="this.checkAuthorization()" />
          <v-col sm=12 cols=12 md=6 lg=8 xl=6 :class="$vuetify.breakpoint.width > 600 ? grid.deskCenter : grid.mobileCenter">
            <!-- <keep-alive> -->
            <router-view />
            <!-- </keep-alive> -->
          </v-col>
          <v-divider vertical class="ml-n8 mr-5" v-if="this.checkAuthorization()" />
          <v-col md=3 lg=2 xl=3 :class="grid.rightPart" v-if="$vuetify.breakpoint.width > 600">
            <right-part v-if="this.checkAuthorization()" />
          </v-col>
        </v-row>
      </v-main>
    </v-app>
    <base-bottom-bar v-if="this.checkAuthorization()" />
  </div>
</template>

<script>
  import BaseBottomBar from '../Base/BaseBottomBar'
  import SideBar from '../../components/Layout/TheSideBar'
  import RightPart from '../Layout/TheRightPart';

  export default {
    name: 'TheMainPart',
    components: {
      'base-bottom-bar': BaseBottomBar,
      'side-bar': SideBar,
      'right-part': RightPart
    },
    data(){
      return {
        grid: {
          app: 'overflow-hidden',
          // // main: 'mt-5 ml-n3',
          // sidebar: ' mr-2 mt-n5',
          // deskCenter: ' mt-n4',
          // mobileCenter: 'ml-n4',
          rightPart: 'mt-3'
        }
      }
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
.theme--light.v-divider {
    border-color: rgba(0,1,1,.06);
}
</style>