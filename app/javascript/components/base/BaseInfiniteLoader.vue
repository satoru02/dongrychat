<template>
  <infinite-loading spinner="circles" @infinite="handler" :force-use-infinite-wrapper="wrapper">
    <span slot="no-more" :style="textStyle">
      <!-- <v-divider></v-divider> -->
    </span>
    <span slot="no-results" :style="textStyle" class="ml-n13">
      このスペースにはまだコメントがありません。😴
    </span>
  </infinite-loading>
</template>

<script>
export default {
  name: 'BaseInfiniteLoader',
  props: {
    handler: {
      type: Function,
    },
    wrapper: {
      type: Boolean,
      default: 'False',
    }
  },
  data(){
    return {
      textStyle: {
        color: '#000000',
        fontWeight: 'bold',
        fontFamily: 'Helvetica Neue, sans-serif',
        fontSize: '11px',
      }
    }
  }
}
</script>

<style scoped>
  .theme--light.v-divider {
    border-color: rgba(0, 1, 1, .06);
  }
</style>