<template>
  <v-container>
    <v-row>
      <v-col cols=12>
        <v-tabs show-arrows grow class="mt-n3" icons-and-text>
          <v-tabs-slider color="teal lighten-3" />
          <v-tab v-for="(n,index) in 6" :key="index" class="list-text" active-class="black--text">Category</v-tab>
        </v-tabs>
      </v-col>
    </v-row>
    <v-row class="mt-n13" v-for="(n,index) in 10" :key="index">
      <v-col cols=12>
        <contents-row />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
  import ContentsRow from '../top/TopContentsRow'
  export default {
    name: 'SearchIndex',
    components: {
      'contents-row': ContentsRow
    },
    data() {
      return {}
    }
  }
</script>

<style scoped>
  .list-text {
    font-size: 10px;
    font-family: 'Helvetica Neue', sans-serif;
    font-weight: bold;
  }
</style>