<template>

<v-img
  :lazy-src="img"
  :max-height="height"
  :class="round"
  :src="img"
></v-img>

</template>

<script>
export default {
  name: 'BaseContentSheet',
  props:{
    height:{
      type: Number,
      default: 140
    },
    round:{
      type: String,
      default: 'rounded-lg'
    },
    img: {
      type: String
    }
  }
}
</script>

<style scoped>
</style>