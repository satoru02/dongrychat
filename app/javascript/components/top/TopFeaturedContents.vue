<template>
<v-row :class="[$vuetify.breakpoint.mdAndUp ? 'mt-2': 'mt-n8']">
  <v-col lg=1 xl=1 class="hidden-sm-only" />
  <v-col cols=12 sm=12 md=12 lg=12 xl=12>
    <base-content-sheet
     :img="'https://freeclassicimages.com/images/abbott-and-costello-in-hollywood-1945-movie-poster.jpg'"
     :height="220"
     :round="'rounded-lg'" />
  </v-col>
</v-row>
</template>

<script>
import BaseContentSheet from '../base/BaseContentSheet'

export default {
  name: 'TopFeaturedContents',
  components: {
    'base-content-sheet': BaseContentSheet
  }
}
</script>

<style scoped>
</style>