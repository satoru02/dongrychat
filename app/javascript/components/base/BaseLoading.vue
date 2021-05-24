<template>
  <v-progress-linear v-if="done == true" color="deep-purple accent-4" indeterminate rounded height="6" />
</template>

<script>
export default {
  name: "BaseLoading",
  props: {
    done: {
      type: Boolean,
      default: false
    }
  }
}
</script>