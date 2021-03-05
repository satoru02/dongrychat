<template>
<v-img
  lazy-src="https://picsum.photos/seed/picsum/200/300"
  :max-height="height"
  :class="round"
  src="https://picsum.photos/seed/picsum/200/300"
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