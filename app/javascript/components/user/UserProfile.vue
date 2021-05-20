<template>
<v-container>
  <div class="user-about">{{user_info.about}}</div>
</v-container>
</template>

<script>
export default {
  name: "UserPosts",
  props: {
    user_info: ""
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