<template>
  <infinite-loading spinner="circles" @infinite="handler" :force-use-infinite-wrapper="wrapper">
    <span slot="no-more" />
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
  }
}
</script>