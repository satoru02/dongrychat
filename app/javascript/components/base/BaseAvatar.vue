<template>
<v-img
  :src="img"
  :lazy-src="img"
/>
</template>

<script>
export default {
  name: 'BaseAvatar',
  props: {
    img: {
      type: String
    }
  }
}
</script>