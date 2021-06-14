<template>
  <infinite-loading :identifier="infiniteId" spinner="circles" @infinite="handler" :force-use-infinite-wrapper="wrapper">
    <span slot="no-more" :style="textStyle">
    </span>
    <span slot="no-results" :style="textStyle" class="ml-5">
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
  data(){
    return {
      textStyle: {
        color: '#111111',
        fontWeight: 'bold',
        fontSize: '11px',
      }
    }
  }
}
</script>
