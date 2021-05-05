<template>
    <v-app :class="grid.app" style="background-color: #121214;">
      <v-app-bar flat fixed app color="#121214" v-if="$vuetify.breakpoint.width > 600">
        <v-toolbar-title style="cursor: pointer" @click="goTop()" class="ml-16 mt-2" :style="logoStyle">Devio</v-toolbar-title>
        <v-row>
          <v-col cols=1 lg=2 class="ml-16" />
          <v-col cols=7 lg=6 class="mt-3">
            <v-text-field
            @keypress="setQuery()" @keydown.enter="search(query)" v-model="query" height="10" v-if="this.checkAuthorization()"
             :prepend-inner-icon="'mdi-magnify'"
              dense background-color="#242c37" solo flat width="250" :class="textField.round"
             />
          </v-col>
          <v-col cols=1 lg=1>
          </v-col>
          <v-col cols=1 lg=1>
            <v-btn v-if="(this.checkAuthorization()) && !$store.state.signedIn"
             @click="goLogin()" outlined small color="blue" elevation=0 class="mt-11" :style="loginStyle">ログイン</v-btn>
          </v-col>
          <v-col cols=1 lg=1 class="ml-n3">
            <v-btn v-if="(this.checkAuthorization()) && !$store.state.signedIn"
             @click="goSignup()" small color="blue" elevation=0 class="mt-11" :style="loginStyle">アカウント登録</v-btn>
          </v-col>
        </v-row>
      </v-app-bar>
      <v-main :class="'mt-2'">
        <v-row>
          <v-col md=3 lg=2 xl=3 class='ml-n6 mt-3' v-if="$vuetify.breakpoint.width > 600">
            <side-bar v-if="this.checkAuthorization()" />
          </v-col>
          <v-col sm=12 cols=12 md=6 :lg="this.checkRouter() ?  '7' : '10' " xl=6
            :class="$vuetify.breakpoint.width > 600 ? grid.deskCenter : grid.mobileCenter">
            <!-- <keep-alive> -->
            <router-view />
            <!-- </keep-alive> -->
          </v-col>
          <v-col md=3 lg=2 xl=3 :class="grid.rightPart" v-if="$vuetify.breakpoint.width > 600">
            <right-part v-if="this.checkAuthorization() && this.checkRouter()" />
          </v-col>
        </v-row>
      </v-main>
    <!-- <base-footer /> -->
    <base-bottom-bar v-if="this.checkAuthorization() " />
    </v-app>
</template>

<script>
  import BaseBottomBar from '../Base/BaseBottomBar'
  import SideBar from '../../components/Layout/TheSideBar'
  import RightPart from '../Layout/TheRightPart'
  import Footer from '../Layout/TheFooter'

  export default {
    name: 'TheMainPart',
    components: {
      'base-bottom-bar': BaseBottomBar,
      'side-bar': SideBar,
      'right-part': RightPart,
      'base-footer': Footer
    },
    data() {
      return {
        query: '',
        canSubmit: false,
        grid: {
          app: 'overflow-hidden ml-6',
          deskCenter: ' ml-6',
          mobileCenter: 'ml-n16',
          rightPart: 'mt-3 ml-16'
        },
        textField: {
          placeholder: '検索',
          round: 'rounded-lg mt-7',
          width: 150,
        },
        logoStyle: {
          fontWeight: 'bold',
          fontFamily: 'Helvetica Neue, sans-serif',
          fontSize: '25px',
          color: '#ced4da'
        },
        loginStyle: {
          fontWeight: 'bold',
          fontFamily: 'Helvetica Neue, sans-serif',
          fontSize: '12px',
          color: '#ffffff'
        }
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
      checkRouter(){
        let spaceRoute = [
          'Home',
          'Chart'
         ]
        if (spaceRoute.includes(this.$route.name)) {
          return true
        } else {
          return false
        }
      },
      setQuery(){
        this.canSubmit = true
      },
      search(query) {
        if(!this.canSubmit){
          return
        }
        this.$router.replace({
          name: 'multi',
          params: {
            query: query
          }
        })
        this.query = ''
        this.canSubmit = false
      },
      goLogin(){
        this.$router.replace('/login')
      },
      goSignup(){
        this.$router.replace('/signup')
      },
      goTop(){
        this.$router.replace('/')
      }
    }
  }
</script>

<style scoped>
  .theme--light.v-divider {
    border-color: rgba(0, 1, 1, .06);
  }

   .v-text-field .v-input__control .v-input__slot {
    min-height: auto !important;
    display: flex !important;
    align-items: center !important;
  }
</style>