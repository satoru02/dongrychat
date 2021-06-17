<template>
  <infinite-loading :identifier="infiniteId" spinner="circles" @infinite="handler"
    :force-use-infinite-wrapper="wrapper">
    <span slot="no-more" class="loading-text">
    </span>
    <span slot="no-results" class="ml-5 mt-16 loading-text">
      {{text}}
    </span>
  </infinite-loading>
</template>

<script>
  export default {
    name: 'BaseInfiniteLoader',
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
      },
      infiniteId: {
        type: Number,
        default: 0,
      }
    },
  }
</script>

<style scoped>
  .loading-text {
    color: #111111;
    font-weight: bold;
    font-size: 14px;
  }
</style>