<template>
  <main-part />
</template>

<script>
  import MainPart from '../components/Parts/TheMainPart'
  export default {
    name: 'App',
    components: {
      'main-part': MainPart
    }
  }
</script>

<style>
.v-application {
  font-family: 'Helvetica Neue", Arial, "Hiragino Kaku Gothic ProN", "Hiragino Sans", "BIZ UDPGothic", Meiryo, sans-serif;';
  line-height: 1.5;
}
</style>