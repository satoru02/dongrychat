<template>
  <v-bottom-navigation v-if="$vuetify.breakpoint.width < 600 && this.checkRoute()" dark :background-color="color" fixed>
    <v-btn>
      <v-icon>mdi-access-point</v-icon>
    </v-btn>
    <v-btn>
      <v-icon>mdi-home</v-icon>
    </v-btn>
    <v-btn>
      <v-icon>mdi-magnify</v-icon>
    </v-btn>
    <v-btn>
      <v-icon>mdi-bell-outline</v-icon>
    </v-btn>
    <v-btn>
      <v-icon>mdi-account-outline</v-icon>
    </v-btn>
  </v-bottom-navigation>
</template>

<script>
  export default {
    name: "TheBottomNavigation",
    data(){
      return{
        color: "#212529"
      }
    },
    methods: {
      checkRoute(){
        let validationRouter =
         ['MvSpace',
          'MvSpaceMembers',
          'MvSpaceReviews',
          'MvSpaceNews',
          'subscribedMvSpace',
          'subscribedMvSpaceMembers',
          'subscribedMvSpaceReviews',
          'subscribedMvSpaceNews',
          'TvSpace',
          'TvSpaceMembers',
          'TvSpaceReviews',
          'TvSpaceNews',
          'subscribedTvSpace',
          'subscribedTvSpaceMembers',
          'subscribedTvSpaceReviews',
          'subscribedTvSpaceNews',
        ]
        if (validationRouter.includes(this.$route.name)) {
          return false
        } else {
          return true
        }
      }
    }
  }
</script>