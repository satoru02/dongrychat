<template>
  <div>
  <v-row :class="[$vuetify.breakpoint.smAndUp ? 'mt-4': 'mt-7']">
    <v-col lg=1 xl=1 class="hidden-xs-only hidden-sm-only hidden-md-only" />
    <v-col cols=9 sm=10 md=10 lg=9 :class="[$vuetify.breakpoint.smAndUp ? 'ml-0': 'ml-1']">
      <div class="streaming-title">{{ streaming_title }}</div></v-col>
    <v-col cols=1 sm=1 md=1 lg=1 class="ml-13"><v-btn icon><v-icon>mdi-chevron-right</v-icon></v-btn></v-col>
  </v-row>
  <v-row :class="[$vuetify.breakpoint.smAndUp ? 'mt-n3': 'mt-n9']">
    <v-col cols=0 lg=1 />
    <v-col cols=4 lg=2 v-for="(n,index) in 5" :key="index">
      <base-content-sheet :height="280" />
    </v-col>
  </v-row>
  </div>
</template>

<script>
import BaseContentSheet from '../base/BaseContentSheet';

export default {
  name: 'TopContentsRow',
  components: {
    'base-content-sheet': BaseContentSheet
  },
  props:{
    streaming_title:{
      type: String,
    }
  }
}
</script>

<style scoped>
.streaming-title{
  font-family: 'Helvetica Neue', sans-serif;
  font-weight: bold;
  font-size: 16px;
  color: #3d2c29;
}

.scrollmenu {
  overflow: auto;
  white-space: nowrap;
}
</style>