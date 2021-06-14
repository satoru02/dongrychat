<template>
  <v-app class="the-main-part">
    <the-header />
    <v-main style="background-color: #ffffff;">
      <v-row>
        <keep-alive>
          <v-col :cols="this.colsGrid[0]" :sm="this.smGrid[0]" :md="this.mdGrid[0]" :lg="this.lgGrid[0]"
            :xl="this.xlGrid[0]" v-if="$vuetify.breakpoint.width > 600" class="ml-n16">
            <the-left-bar v-if="this.checkAuthorization() && this.checkRouter()" />
          </v-col>
        </keep-alive>
        <!-- <v-col lg=1 /> -->
        <v-divider vertical class="ml-10" v-if="$vuetify.breakpoint.width > 600 && this.checkRouter()" />
        <v-col class="ml-n3" :cols="this.colsGrid[1]" :sm="this.smGrid[1]" :md="this.mdGrid[1]" :lg="this.lgGrid[1]"
          :xl="this.xlGrid[1]">
          <keep-alive>
            <router-view v-if="$route.meta.keepAlive" />
          </keep-alive>
          <router-view v-if="!$route.meta.keepAlive" />
        </v-col>
        <!-- <v-divider vertical class="ml-2 mr-n3" v-if="$vuetify.breakpoint.width > 600 && this.checkRouter()" /> -->
        <!-- <keep-alive>
          <v-col class="ml-n4" :cols="this.colsGrid[2]" :sm="this.smGrid[2]" :md="this.mdGrid[2]" :lg="this.lgGrid[2]"
            :xl="this.xlGrid[2]" v-if="$vuetify.breakpoint.width > 600">
            <the-right-bar v-if="this.checkAuthorization() && this.checkRouter()" />
          </v-col>
        </keep-alive> -->
      </v-row>
    </v-main>
    <footer>
      <cookie-law buttonClass="button" buttonText="許可する" theme="shade-blue">
        <div slot="message">
          本ウェブサイトでは、最適なサービスを提供するためにクッキーを使用しています。
        </div>
      </cookie-law>
    </footer>
    <!-- <base-bottom-bar v-if="this.checkAuthorization() " /> -->
  </v-app>
</template>

<script>
  import TheHeader from './TheHeader';
  import TheLeftBar from './TheLeftBar';
  // import TheRightBar from './TheRightBar';
  import CookieLaw from 'vue-cookie-law';
  // import BaseBottomBar from '../Base/BaseBottomBar';
  // import { VApp, VRow, VCol, VDivider } from 'vuetify/lib';

  export default {
    name: 'TheMainPart',
    components: {
      // 'v-app': VApp,
      // 'v-row': VRow,
      // 'v-col': VCol,
      // 'v-divider': VDivider,
      'the-header': TheHeader,
      'the-left-bar': TheLeftBar,
      // 'the-right-bar': TheRightBar,
      'cookie-law': CookieLaw
      // 'base-bottom-bar': BaseBottomBar
    },
    data() {
      return {
        colsGrid: '',
        smGrid: '',
        mdGrid: '',
        lgGrid: [3, 9, 0],
        xlGrid: [3, 6, 3],
        grid: {
          rightPart: 'mt-3 ml-16'
        }
      }
    },
    watch: {
      "$route.name"() {
        this.changeGrid()
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
          'Settings',
          'Terms',
          'Privacy',
          // 'subscribedTvSpace'
        ]
        if (spaceRoute.includes(this.$route.name)) {
          return false
        } else {
          return true
        }
      },
      changeGrid() {
        switch (this.$route.name) {
          case 'Privacy':
          case 'Terms':
          case 'Settings':
          // case 'subscribedTvSpace':
            return this.lgGrid = [0, 12, 0]
          default:
            this.colsGrid = [0, 12, 0]
            this.smGrid = [4, 8, 0]
            this.mdGrid = [4, 8, 0]
            this.lgGrid = [3, 9, 0]
            this.xlGrid = [3, 6, 3]
            break;
        }
      },
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