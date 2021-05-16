<template>
  <v-app style="background-color: #ffffff">
    <the-header />
    <!-- <div class="mt-10"></div> -->
    <v-main class="ml-n5">
      <v-row>
        <v-col :cols="this.colsGrid[0]" :sm="this.smGrid[0]" :md="this.mdGrid[0]" :lg="this.lgGrid[0]"
          :xl="this.xlGrid[0]" v-if="$vuetify.breakpoint.width > 600">
          <the-left-bar v-if="this.checkAuthorization() && this.checkRouter()" />
        </v-col>
        <v-col :cols="this.colsGrid[1]" :sm="this.smGrid[1]" :md="this.mdGrid[1]" :lg="this.lgGrid[1]"
          :xl="this.xlGrid[1]" :class="$vuetify.breakpoint.width > 600 ? grid.deskCenter : grid.mobileCenter">
          <router-view />
        </v-col>
        <v-col :cols="this.colsGrid[2]" :sm="this.smGrid[2]" :md="this.mdGrid[2]" :lg="this.lgGrid[2]"
          :xl="this.xlGrid[2]" v-if="$vuetify.breakpoint.width > 600">
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
        colsGrid: '',
        smGrid: '',
        mdGrid: '',
        lgGrid: '',
        xlGrid: '',
        grid: {
          deskCenter: '',
          mobileCenter: 'ml-n16',
          rightPart: 'mt-3 ml-16'
        }
      }
    },
    created() {
      this.changeGrid()
    },
    watch: {
      "$route.name"() {
        this.changeGrid()
      }
    },
    methods: {
      changeGrid() {
        switch (this.$route.name) {
          case 'Home':
            this.lgGrid = [3, 6, 3]
            break;
          case 'Chart':
            this.lgGrid = [3, 6, 3]
            break;
          case 'subscribedTvSpace' || 'subscribedTvSpaceMembers' || 'subscribedTvSpaceReviews' ||
          'subscribedTvSpaceNews':
            this.lgGrid = [2, 8, 2]
            break;
          case 'subscribedMvSpace' || 'subscribedMvSpaceMembers' || 'subscribedMvSpaceReviews' ||
          'subscribedMvSpaceNews':
            this.lgGrid = [2, 8, 2]
            break;
          case 'MvSpace' || 'MvSpaceMembers' || 'MvSpaceReviews' || 'MvSpaceNews':
            this.lgGrid = [2, 8, 2]
            break;
          case 'TvSpace' || 'TvSpaceMembers' || 'TvSpaceReviews' || 'TvSpaceNews':
            this.lgGrid = [2, 8, 2]
            break;
          case 'TvDetails':
            this.lgGrid = [2, 8, 0]
            break;
          case 'MvDetails':
            this.lgGrid = [2, 8, 0]
            break;
          case 'Privacy':
            this.lgGrid = [2, 8, 0]
            break;
          case 'Terms':
            this.lgGrid = [2, 8, 0]
            break;
          case 'multi':
            this.lgGrid = [3, 6, 3]
            break;
          case 'person':
            this.lgGrid = [3, 6, 3]
            break;
          case 'tv':
            this.lgGrid = [3, 6, 3]
            break;
          case 'movie':
            this.lgGrid = [3, 6, 3]
            break;
          case 'Company':
            this.lgGrid = [3, 6, 3]
            break;
          case 'Search':
            this.lgGrid = [2, 8, 2]
            break;
          case 'NotificationTop':
            this.lgGrid = [3, 6, 3]
            break;
          case 'Settings':
            this.lgGrid = [0, 12, 0]
            break;
          case 'Followings':
            this.lgGrid = [3, 6, 3]
            break;
          case 'Followers':
            this.lgGrid = [3, 6, 3]
            break;
          case 'UserTop':
            this.lgGrid = [4, 5, 3]
            break;
          default:
            this.lgGrid = [2, 8, 0]
            break;
        }
      },
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
          'NotificationTop',
          'multi',
          'person',
          'tv',
          'movie',
          'Company',
          'Followings',
          'Followers',
          'UserTop',
          // 'Settings'
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
  .vappTop {
    background-color: #fdfdfd;
  }
</style>