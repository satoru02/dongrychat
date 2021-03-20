<template>
  <div>
    <v-app-bar flat app style="background-color: #ffffff" v-if="$vuetify.breakpoint.width < 600">
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
    <v-app-bar flat app style="background-color: #ffffff" v-else>
      <v-row class="mt-7 ml-15">
        <v-col md=1 lg=1 xl=1 />
        <v-col md=1 lg=1 xl=1 class="ml-n14">
         <v-toolbar-title class="toolbar-title">
            <v-icon class="mt-n1" color="#000000">mdi-access-point</v-icon> {{this.changeHeader()}}
          </v-toolbar-title>
        </v-col>
        <v-col md=1 lg=1 xl=1 />
        <v-col md=6 lg=6 xl=6 class="ml-6">
          <v-text-field filled dense rounded placeholder="search" v-model="query" @keydown.enter="search(query)" />
        </v-col>
        <v-col md=1 lg=1 xl=1 />
        <v-col md=1 lg=1 xl=1 class="ml-n13">
          <v-avatar
            class="rounded-lg"
            color="primary"
            tile
            size=40 height=41
          />
        </v-col>
        <v-col md=1 lg=1 xl=1 class="ml-n16 mt-3 user-name">user name</v-col>
      </v-row>
    </v-app-bar>
  </div>
</template>

<script>
  import { tmdbAxios } from '../../backend/axios';

  export default {
    name: "TheHeader",
    data(){
      return {
        query: null,
        error: null,
      }
    },
    methods: {
      search(query){
        this.$router.replace({name: 'Results', params: { query: query} })
      },
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

  .user-name {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 12px;
    color: #000000;
  }
</style>