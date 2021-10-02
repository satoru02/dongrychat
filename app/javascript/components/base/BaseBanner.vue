<template>
  <v-img :src="`${this.cdn}/image/${this.img}`" class="rounded-lg ml-4" height="223" position="top">
    <v-row>
      <v-col lg=6 class="mt-16 ml-n3">
        <div class="header-title ml-3">DongryChatで発掘</div>
        <div class="mt-1 ml-6" style="color: #000000; font-weight:bold; font-size: 16px;">次に見る作品をここで見つけよう!</div>
      </v-col>
    </v-row>
  </v-img>
</template>

<script>
export default {
  name: 'BaseBanner',
  data(){
    return {
      cdn: process.env.AWS_CLOUDFRONT,
      img: `tv.jpg`
    }
  }
}
</script>

<style scoped>
  .header-title {
    font-size: 33px;
    font-weight: bold;
    background: -webkit-linear-gradient(152deg, #56d8ff, #2165ff);
    -webkit-background-clip: text;
    background-clip: text;
    -webkit-text-fill-color: transparent;
  }
</style>