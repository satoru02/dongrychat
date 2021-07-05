<template>
  <v-app>
    <the-header v-if="!isMobile(display_size)" />
    <v-main>
      <v-row>
        <v-col class="d-none d-lg-flex" lg=1 xl=1>
        </v-col>
        <v-col class="d-none d-sm-none d-md-flex" :md="this.mdGrid[0]" :lg="this.lgGrid[0]" xl=2>
          <the-left-bar v-if="checkRouter()" />
        </v-col>
        <v-col class="d-none d-sm-flex d-md-none" sm=1 />
        <v-col :cols="this.colsGrid[1]" :sm="this.smGrid[1]" :md="this.mdGrid[1]" :lg="this.lgGrid[1]"
          :xl="this.xlGrid[1]">
          <keep-alive>
            <router-view v-if="$route.meta.keepAlive" />
          </keep-alive>
          <router-view v-if="!$route.meta.keepAlive" />
        </v-col>
      </v-row>
    </v-main>
    <base-bottom-bar v-if="this.checkAuthorization() " />
    <!-- <footer>
      <cookie-law buttonClass="button" buttonText="許可する" theme="shade-blue">
        <div slot="message">
          本ウェブサイトでは、最適なサービスを提供するためにクッキーを使用しています。
        </div>
      </cookie-law>
    </footer> -->
  </v-app>
</template>

<script>
  import TheHeader from './TheHeader';
  import TheLeftBar from './TheLeftBar';
  import TheBottomBar from '../Base/BaseBottomBar'
  import CookieLaw from 'vue-cookie-law';
  import { isMobile } from '../../helper/display';

  export default {
    name: 'TheMainPart',
    components: {
      'the-header': TheHeader,
      'the-left-bar': TheLeftBar,
      'base-bottom-bar': TheBottomBar,
      'cookie-law': CookieLaw
    },
    data() {
      return {
        display_size: '',
        colsGrid: '',
        smGrid: [2, 11, 0],
        mdGrid: [3, 8, 0],
        lgGrid: [2, 5, 0],
        xlGrid: [3, 6, 3],
      }
    },
    watch: {
      "$route.name"() {
        this.changeGrid()
      }
    },
    created(){
      this.display_size = this.$vuetify.breakpoint.width
    },
    methods: {
      isMobile,
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
          'Settings',
          'Terms',
          'Privacy',
          'TvSpace',
          'TvSpaceMembers',
          'TvSpaceReviews',
          'MvSpace',
          'MvSpaceMembers',
          'MvSpaceReviews',
          'registeredTvSpace',
          'registeredTvSpaceMembers',
          'registeredTvSpaceReviews',
          'registeredMvSpace',
          'registeredMvSpaceMembers',
          'registeredMvSpaceReviews',
          'watchlists',
          'watchlog',
          'UserFollowing',
          'UserFollowers',
          'UserReviews',
          'UserProfile'
        ]
        if (spaceRoute.includes(this.$route.name)) {
          return false
        } else {
          return true
        }
      },
      changeGrid() {
        switch (this.$route.name) {
          case 'watchlists':
          case 'watchlog':
          case 'UserFollowing':
          case 'UserFollowers':
          case 'UserReviews':
          case 'UserProfile':
            this.smGrid = [2, 10, 0]
            this.mdGrid = [1, 10, 0]
            this.lgGrid = [1, 8, 0]
            break;
          case 'Following':
            this.smGrid = [2, 10, 0]
            this.mdGrid = [3, 9, 0]
            this.lgGrid = [2, 7, 0]
            break;
          case 'Popular':
          case 'Trend':
          case 'TopRated':
          case 'multi':
          case 'person':
          case 'movie':
          case 'tv':
          case 'Company':
            this.smGrid = [2, 10, 0]
            this.mdGrid = [3, 9, 0]
            this.lgGrid = [2, 7, 0]
            break;
          case 'TvSpace':
          case 'TvSpaceMembers':
          case 'TvSpaceReviews':
          case 'MvSpace':
          case 'MvSpaceMembers':
          case 'MvSpaceReviews':
          case 'registeredTvSpace':
          case 'registeredTvSpaceMembers':
          case 'registeredTvSpaceReviews':
          case 'registeredMvSpace':
          case 'registeredMvSpaceMembers':
          case 'registeredMvSpaceReviews':
            this.smGrid = [0, 11, 0]
            this.mdGrid = [1, 10, 0]
            this.lgGrid = [1, 8, 0]
            break;
          case 'TvDetails':
          case 'MvDetails':
            this.mdGrid = [3, 9, 0]
            this.lgGrid = [2, 9, 0]
            break;
          default:
            this.colsGrid = [0, 12, 0]
            this.smGrid = [2, 11, 0]
            this.mdGrid = [3, 8, 0]
            this.lgGrid = [2, 5, 0]
            this.xlGrid = [3, 6, 3]
            break;
        }
      }
    }
  }
</script>

<style scoped>
  .theme--light.v-divider {
    border-color: rgba(0, 0, 0, 0.082);
  }

  .Cookie--shade-blue {
    background: rgb(2, 0, 36);
    background: linear-gradient(90deg, rgba(2, 0, 36, 1) 0%, rgba(44, 102, 255, 1) 0%, rgba(0, 212, 255, 1) 100%);
    color: #ffffff;
    font-weight: bold;
    padding: 1.150em;
  }
</style>