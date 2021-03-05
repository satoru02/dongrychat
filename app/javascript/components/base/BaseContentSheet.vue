<template>
<v-img
  lazy-src="https://picsum.photos/200/300?grayscale"
  :max-height="height"
  :class="round"
  src="https://picsum.photos/200/300?grayscale"
></v-img>

</template>

<script>
export default {
  name: 'BaseContentSheet',
  props:{
    height:{
      type: Number,
      default: 100
    },
    round:{
      type: String,
      default: 'rounded-xl'
    }
  }
}
</script>

<style scoped>
</style>