<template>
<v-container>
 <v-row>
   <v-col lg=1 v-for="(comment, index) in comments" :key="index">
    {{comment.user_id}}
   </v-col>
 </v-row>
</v-container>
</template>

<script>
export default {
  name: "SpaceAppearance",
  props: {
    comments: ''
  },
  channels: {
    AppearanceChannel: {
      connected() {},
      rejected() {},
      received(data) {
        // console.log(data)
      },
      disconnected() {}
    }
  },
  mounted() {
    this.$cable.subscribe({
      channel: 'AppearanceChannel'
    })
  },
}
</script>