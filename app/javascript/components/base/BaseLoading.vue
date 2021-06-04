<template>
 <v-progress-circular indeterminate color="green">
 </v-progress-circular>
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