<template>
  <main-part />
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
</style>