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
@font-face {
  font-family: "Original Yu Gothic";
  src: local("Yu Gothic Medium");
  font-weight: 100;
}
@font-face {
  font-family: "Original Yu Gothic";
  src: local("Yu Gothic Medium");
  font-weight: 200;
}
@font-face {
  font-family: "Original Yu Gothic";
  src: local("Yu Gothic Medium");
  font-weight: 300;
}
@font-face {
  font-family: "Original Yu Gothic";
  src: local("Yu Gothic Medium");
  font-weight: 400;
}
@font-face {
  font-family: "Original Yu Gothic";
  src: local("Yu Gothic Bold");
  font-weight: bold;
}
</style>