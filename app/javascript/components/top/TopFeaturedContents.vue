<template>
<v-container filled>
<v-row :class="[$vuetify.breakpoint.mdAndUp ? 'mt-2': 'mt-n7']">
  <v-col lg=1 xl=1 class="hidden-sm-only" />
  <v-col cols=12 sm=12 md=12 lg=10 xl=10>
    <base-content-sheet :height="320" :round="'rounded-xl'" />
  </v-col>
</v-row>
  </v-container>
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