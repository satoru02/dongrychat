<template>
  <div>
    <v-app style="background-color:#fafaf9">
      <top-header v-if="this.checkAuthorization()" />
      <v-main>
        <router-view />
      </v-main>
      <!-- <bottom-footer /> -->
    </v-app>
    <base-bottom-bar v-if="this.checkAuthorization()" />
  </div>
</template>

<script>
  import Header from './TheHeader'
  import BaseBottomBar from '../base/BaseBottomBar'
  import Footer from './TheFooter'

  export default {
    name: 'TheMainPart',
    components: {
      'top-header': Header,
      'bottom-footer': Footer,
      'base-bottom-bar': BaseBottomBar
    },
    methods:{
      checkAuthorization(){
       let validationRouter = ['Login', 'Signup', 'Authorization']
       if (validationRouter.includes(this.$route.name)){
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