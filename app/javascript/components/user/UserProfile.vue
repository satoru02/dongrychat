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
    font-family: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif';
    color: #000000;
    font-size: 14px;
  }
</style>