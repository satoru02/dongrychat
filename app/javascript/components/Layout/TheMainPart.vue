<template>
  <v-app >
    <the-header />
    <v-main>
      <v-row class="">
        <v-col lg=2 class="ml-14" />

        <v-col :cols="this.colsGrid[1]" :sm="this.smGrid[1]" :md="this.mdGrid[1]" :lg="this.lgGrid[1]"
          :xl="this.xlGrid[1]">
      
          <keep-alive>
            <router-view v-if="$route.meta.keepAlive" />
          </keep-alive>
          <router-view v-if="!$route.meta.keepAlive" />
        </v-col>

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
  import CookieLaw from 'vue-cookie-law';

  export default {
    name: 'TheMainPart',
    components: {
      'the-header': TheHeader,
      'cookie-law': CookieLaw
    },
    data() {
      return {
        colsGrid: '',
        smGrid: '',
        mdGrid: '',
        lgGrid: [0, 7, 0],
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
          // 'registeredTvSpace',
          // 'registeredTvSpaceMembers',
          // 'registeredTvSpaceReviews',
          // 'registeredMvSpace',
          // 'registeredMvSpaceMembers',
          // 'registeredMvSpaceReviews',
          // 'TvSpace',
          // 'TvSpaceMembers',
          // 'TvSpaceReviews',
          // 'MvSpace',
          // 'MvSpaceMembers',
          // 'MvSpaceReviews',
          // 'UserTop',
          // 'UserReviews',
          // 'UserFollowing',
          // 'UserFollowers',
          // 'TvDetails',
          // 'MvDetails'
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
            case 'registeredTvSpace':
            case 'registeredTvSpaceMembers':
            case 'registeredTvSpaceReviews':
            case 'registeredMvSpace':
            case 'registeredMvSpaceMembers':
            case 'registeredMvSpaceReviews':
            case 'TvSpace':
            case 'TvSpaceMembers':
            case 'TvSpaceReviews':
            case 'MvSpace':
            case 'MvSpaceMembers':
            case 'MvSpaceReviews':
            return this.lgGrid = [2, 9, 0]
            case 'UserTop':
            case 'watchlists':
            case 'UserFollowing':
            case 'UserFollowers':
              return this.lgGrid = [0, 10, 0]
            // case 'TvDetails':
            // case 'MvDetails':
            //   return this.lgGrid = [0, 12, 0]
          default:
            this.colsGrid = [0, 12, 0]
            this.smGrid = [4, 8, 0]
            this.mdGrid = [4, 8, 0]
            this.lgGrid = [0, 7, 0]
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