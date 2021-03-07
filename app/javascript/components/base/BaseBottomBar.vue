<template>
  <v-bottom-navigation v-if="$vuetify.breakpoint.width < 600" :background-color="color" active-class="#ffffff" fixed>
    <v-btn>
      <v-icon color="#000000">mdi-access-point</v-icon>
    </v-btn>
    <v-btn>
      <v-icon color="#000000">mdi-earth</v-icon>
    </v-btn>
    <v-btn>
      <v-icon color="#000000">mdi-magnify</v-icon>
    </v-btn>
    <v-btn>
      <v-icon color="#000000">mdi-bell-outline</v-icon>
    </v-btn>
    <v-btn>
      <v-icon color="#000000">mdi-account-outline</v-icon>
    </v-btn>
  </v-bottom-navigation>
</template>

<script>
  export default {
    name: "TheBottomNavigation",
    data(){
      return{
        color: "#ffffff"
      }
    },
    methods: {
    }
  }
</script>