<template>
  <v-img
    :lazy-src="img"
    :max-height="height"
    :size="size"
    :class="round"
    :src="img"
    :elevation="elevation"
  ></v-img>
</template>

<script>
export default {
  name: 'BaseContentSheet',
  props:{
    height:{
      type: Number,
      default: 280
    },
    size:{
      type: Number,
      default: 300
    },
    round:{
      type: String,
      default: 'rounded-lg'
    },
    img: {
      type: String
    },
    elevation: {
      type: Number,
      default: 0
    }
  }
}
</script>

<style scoped>
</style>