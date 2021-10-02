<template>
  <v-container>
    <div class="user-about">{{userInfo.about}}</div>
  </v-container>
</template>

<script>
export default {
  name: "UserProfile",
  props: {
    userInfo: ""
  },
  data(){
    return {}
  }
}
</script>

<style scoped>
  .user-about {
    color: #000000;
    font-size: 14px;
  }
</style>