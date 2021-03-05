<template>
<v-app-bar flat app style="background-color: #fafaf9">
  <v-row class=mt-2>
    <v-col sm=1 md=1 lg=2 xl=2 class="hidden-xs-only" />
    <v-col cols=5 sm=4 md=4 lg=4 xl=3 :class="[$vuetify.breakpoint.smAndUp ? 'ml-n8': 'ml-0']"><v-toolbar-title class="toolbar-title">Monica</v-toolbar-title></v-col>
    <v-col cols=6 sm=6 md=6 lg=4 xl=3 />
    <v-col cols=1 sm=1 md=1 lg=1 xl=1 :class="[$vuetify.breakpoint.smAndUp ? 'mt-n2 ml-n2': 'mt-n2 ml-n6']" align="start"><v-btn icon><v-icon>mdi-magnify</v-icon></v-btn></v-col>
  </v-row>
</v-app-bar>
</template>

<script>
export default {
  name: "TheHeader",
  data(){
    return {
    }
  },
  methods:{
  }
}
</script>

<style scoped>
.toolbar-title{
  font-family: 'Helvetica Neue', sans-serif;
  font-weight: bold;
  font-size: 22px;
  color: #3d2c29;
  letter-spacing: 2.44px;
}
</style>