<template>
<v-container fluid class="sub-header">
  <slot name="home_header" :sub_header="home"></slot>
  <slot name="popular_header" :sub_header="popular"></slot>
  <slot name="notify_header" :sub_header="notifications"></slot>
  <slot name="account_header" :sub_header="accountSetting"></slot>
  <slot name="tag_header" :sub_header="tag + tag_space"></slot>
</v-container>
</template>

<script>
export default {
  name: "TheSubHeader",
  props: {
    tag: ''
  },
  data(){
    return{
      home: 'フォロー中の作品一覧',
      popular: '話題の作品一覧',
      notifications: '通知',
      accountSetting: 'アカウント設定',
      tag_space: 'の作品一覧',
      movie: 'MOVIE',
      tv: 'TV'
    }
  }
}
</script>

<style scoped>
</style>