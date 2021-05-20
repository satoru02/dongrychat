<template>
  <main-part class="top-component" />
</template>

<script>
  import MainPart from '../components/Layout/TheMainPart'

  export default {
    name: 'App',
    components: {
      'main-part': MainPart
    },
    methods: {
      track(){
        this.$gtag.time({
          'name': 'load',
          'value': 3549,
          'event_category': 'JS Dependencies'
        })
      }
    }
  }
</script>

<style scoped>
  .top-component {
    font-family: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif';
  }
</style>