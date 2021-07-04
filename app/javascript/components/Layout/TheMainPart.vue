<template>
  <v-app>
    <the-header v-if="!isMobile(display_size)" />
    <v-main>
      <v-row>
        <v-col class="d-none d-lg-flex" lg=1 xl=1>
        </v-col>
        <v-col class="d-none d-sm-none d-md-flex" md=3 :lg="this.lgGrid[0]" xl=2>
          <the-left-bar />
        </v-col>
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
  import { isMobile, isTablet } from '../../helper/display';

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
        smGrid: [2, 12, 0],
        mdGrid: [2, 9, 0],
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
      isTablet,
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
            this.lgGrid = [0, 10, 0]
          case 'Following':
            return this.lgGrid = [2, 7, 0]
          default:
            this.colsGrid = [0, 12, 0]
            this.smGrid = [2, 12, 0]
            this.mdGrid = [0, 9, 0]
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