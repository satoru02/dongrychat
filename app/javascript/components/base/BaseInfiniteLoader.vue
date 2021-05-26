<template>
  <infinite-loading spinner="circles" @infinite="handler" :force-use-infinite-wrapper="wrapper">
    <span slot="no-more" :style="textStyle">
    </span>
    <span slot="no-results" :style="textStyle" class="ml-5">
      {{text}}
    </span>
  </infinite-loading>
</template>

<script>
// import InfiniteLoading from 'vue-infinite-loading';

export default {
  name: 'BaseInfiniteLoader',
  // components: {
  //   'infinite-loading': () => import('vue-infinite-loading')
  // },
  props: {
    handler: {
      type: Function,
      required: true,
    },
    wrapper: {
      type: Boolean,
    },
    text: {
      type: String,
      required: true,
    }
  },
  data(){
    return {
      textStyle: {
        color: '#111111',
        fontWeight: 'bold',
        fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
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