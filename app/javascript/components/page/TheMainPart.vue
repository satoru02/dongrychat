<template>
  <v-app style="background-color: #fafaf9">
    <top-header />
    <v-main>
      <router-view />
    </v-main>
  </v-app>
</template>

<script>
import Header from './TheHeader'

export default {
  name: 'TheMainPart',
  components: {
    'top-header': Header,
  }
}
</script>

<style scoped>
</style>