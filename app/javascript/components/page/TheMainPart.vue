<template>
  <v-app style="background-color: #fafaf9">
    <top-header />
    <v-main>
      <router-view />
    </v-main>
    <bottom-footer />
  </v-app>
</template>

<script>
import Header from './TheHeader'
import Footer from './TheFooter'

export default {
  name: 'TheMainPart',
  components: {
    'top-header': Header,
    'bottom-footer': Footer
  }
}
</script>

<style scoped>
</style>