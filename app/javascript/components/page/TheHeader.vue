<template>
  <div>
    <v-app-bar flat app style="background-color: #fafaf9" v-if="$vuetify.breakpoint.width < 600">
      <v-row class=mt-2>
        <v-col sm=1 md=1 lg=3 xl=2 class="hidden-xs-only" />
        <v-col cols=5 sm=4 md=4 lg=4 xl=3 :class="[$vuetify.breakpoint.smAndUp ? 'ml-n16': 'ml-n1']">
          <v-toolbar-title class="toolbar-title">
            <v-icon class="mt-n1" color="#000000">mdi-access-point</v-icon> {{this.changeHeader()}}
          </v-toolbar-title>
        </v-col>
        <v-col cols=6 sm=6 md=6 lg=5 xl=3 />
      </v-row>
    </v-app-bar>
    <v-app-bar flat app style="background-color: #fafaf9" v-else>
      <v-row>
        <v-col lg=3 />
        <v-col lg=3>
          <v-toolbar-title class="toolbar-title">
            <v-icon class="mt-n1" color="#000000">mdi-access-point</v-icon> {{this.changeHeader()}}
          </v-toolbar-title>
        </v-col>
        <v-col lg=6>
          <v-btn elevation=0 color="#fafaf9">
            <v-icon color="#000000">mdi-access-point</v-icon>
          </v-btn>
          <v-btn elevation=0 color="#fafaf9">
            <v-icon color="#000000">mdi-earth</v-icon>
          </v-btn>
          <v-btn elevation=0 color="#fafaf9">
            <v-icon color="#000000">mdi-magnify</v-icon>
          </v-btn>
          <v-btn elevation=0 color="#fafaf9">
            <v-icon color="#000000">mdi-bell-outline</v-icon>
          </v-btn>
          <v-btn elevation=0 color="#fafaf9">
            <v-icon color="#000000">mdi-account-outline</v-icon>
          </v-btn>
        </v-col>
      </v-row>
    </v-app-bar>
  </div>
</template>

<script>
  export default {
    name: "TheHeader",
    methods: {
      changeHeader() {
        if (this.$route.name === 'Top') {
          return 'Live'
        } else if (this.$route.name === 'Search') {
          return 'Search'
        } else if (this.$route.name === 'Trend') {
          return 'Trend'
        } else if (this.$route.name === 'SearchIndex') {
          return 'Netflix'
        }
      }
    }
  }
</script>

<style scoped>
  .toolbar-title {
    font-family: 'Helvetica Neue', sans-serif;
    font-weight: bold;
    font-size: 17px;
    color: #000000;
    letter-spacing: 1px;
  }
</style>