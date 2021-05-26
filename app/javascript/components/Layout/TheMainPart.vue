<template>
  <v-app class="the-main-part">
    <the-header />

    <v-main>
      <v-row>
        <keep-alive>
        <v-col :cols="this.colsGrid[0]" :sm="this.smGrid[0]" :md="this.mdGrid[0]" :lg="this.lgGrid[0]"
          :xl="this.xlGrid[0]" v-if="$vuetify.breakpoint.width > 600">
          <the-left-bar v-if="this.checkAuthorization() && this.checkRouter()" />
        </v-col>
        </keep-alive>

        <v-divider vertical class="ml-n13 mr-8" v-if="$vuetify.breakpoint.width > 600" />

        <v-col :cols="this.colsGrid[1]" :sm="this.smGrid[1]" :md="this.mdGrid[1]" :lg="this.lgGrid[1]"
          :xl="this.xlGrid[1]">
          <keep-alive>
            <router-view v-if="$route.meta.keepAlive" />
          </keep-alive>
          <router-view v-if="!$route.meta.keepAlive"/>
        </v-col>

      <keep-alive>
        <v-col class="ml-n4" :cols="this.colsGrid[2]" :sm="this.smGrid[2]" :md="this.mdGrid[2]" :lg="this.lgGrid[2]"
          :xl="this.xlGrid[2]" v-if="$vuetify.breakpoint.width > 600">
          <the-right-bar v-if="this.checkAuthorization() && this.checkRouter()" />
        </v-col>
      </keep-alive>
      </v-row>
    </v-main>
    <!-- <base-bottom-bar v-if="this.checkAuthorization() " /> -->
  </v-app>
</template>

<script>
  import TheHeader from './TheHeader';
  import TheLeftBar from './TheLeftBar';
  import TheRightBar from './TheRightBar';
  // import BaseBottomBar from '../Base/BaseBottomBar';

  export default {
    name: 'TheMainPart',
    components: {
      'the-header': TheHeader,
      'the-left-bar': TheLeftBar,
      'the-right-bar': TheRightBar,
      // 'base-bottom-bar': BaseBottomBar
    },
    data() {
      return {
        colsGrid: '',
        smGrid: '',
        mdGrid: '',
        lgGrid: '',
        xlGrid: '',
        grid: {
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
          case 'TvDetails':
          case 'MvDetails':
          case 'Search':
            return this.lgGrid = [3, 9, 0]
          case 'Privacy':
          case 'Terms':
          case 'Settings':
            return this.lgGrid = [0, 12, 0]
          default:
            this.colsGrid = [0, 12, 0]
            this.smGrid = [4, 8, 0]
            this.mdGrid = [4, 8, 0]
            this.lgGrid = [3, 6, 3]
            this.xlGrid = [3, 6, 3]
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
        ]
        if (spaceRoute.includes(this.$route.name)) {
          return false
        } else {
          return true
        }
      }
    }
  }
</script>

<style scoped>
  .the-main-part {
    background-color: #ffffff;
  }

  .theme--light.v-divider {
    border-color: rgba(0,0,0,.04);
  }
</style>