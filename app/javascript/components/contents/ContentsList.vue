<template>
   <v-row>
     <v-col cols=4 v-for="(item, index) in　contents" :key="index">
       <base-content-sheet :img="pic" :height="230" :elevation="2" />
       コンテンツタイトル
     </v-col>
   </v-row>
</template>

<script>
export default {
  name: 'ContentsList',
  props:{
    contents: {
      type: Array,
      required: true,
    }
  },
  data(){
    return{
    }
  }
}
</script>

<style scoped>
</style>