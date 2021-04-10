<template>
  <infinite-loading spinner="circles" @infinite="handler">
    <span slot="no-more" />
  </infinite-loading>
</template>

<script>
export default {
  name: 'BaseInfiniteLoader',
  props: {
    handler: {
      type: Function,
    }
  }
}
</script>