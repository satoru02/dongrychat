<template>
<v-app-bar flat app style="background-color: #ffffff">
  <v-row class=mt-2>
    <v-col sm=1 md=1 lg=0 xl=2 class="hidden-xs-only" />
    <v-col cols=5 sm=4 md=4 lg=4 xl=3 :class="[$vuetify.breakpoint.smAndUp ? 'ml-n16': 'ml-n1']">
      <!-- <v-toolbar-title class="toolbar-title"><v-icon class="mt-n1" color="#000000">mdi-access-point</v-icon> Live</v-toolbar-title></v-col> -->
      <v-toolbar-title class="toolbar-title"><v-icon class="mt-n1" color="#000000">mdi-earth</v-icon> Trend</v-toolbar-title></v-col>
    <v-col cols=6 sm=6 md=6 lg=5 xl=3 />
  </v-row>
</v-app-bar>
</template>

<script>
export default {
  name: "TheHeader",
}
</script>

<style scoped>
.toolbar-title{
  font-family: 'Helvetica Neue', sans-serif;
  font-weight: bold;
  font-size: 17px;
  color: #000000;
  letter-spacing: 1px;
}
</style>