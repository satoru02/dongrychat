<template>
<v-container>
    <v-tabs class="mt-n3">
      <v-tabs-slider color="#ffffff"></v-tabs-slider>
    <v-tab style="font-size: 10px; font-family: 'Helvetica Neue', sans-serif;" active-class="black--text">Netflix</v-tab>
    <v-tab style="font-size: 10px; font-family: 'Helvetica Neue', sans-serif;" active-class="black--text">Prime video</v-tab>
    <v-tab style="font-size: 10px; font-family: 'Helvetica Neue', sans-serif;" active-class="black--text">Disney Plus</v-tab>
    <v-tab style="font-size: 10px; font-family: 'Helvetica Neue', sans-serif;" active-class="black--text">Hulu</v-tab>
  </v-tabs>
  <featured-contents />
  <contents-row :streaming_title="'Netflix'" />
  <contents-row :streaming_title="'Prime video'" />
</v-container>
</template>

<script>
  import FeaturedContents from '../top/TopFeaturedContents'
  import ContentsRow from '../top/TopContentsRow'

  export default {
    name: "SearchTop",
    components: {
      'featured-contents': FeaturedContents,
      'contents-row': ContentsRow
    }
  }
</script>

<style scoped>

</style>