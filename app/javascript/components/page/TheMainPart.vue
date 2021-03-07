<template>
  <div>
    <v-app style="background-color: #ffffff">
      <top-header />
      <v-main>
        <router-view />
      </v-main>
      <!-- <bottom-footer /> -->
    </v-app>
    <base-bottom-bar />
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
    }
  }
</script>

<style scoped>
</style>