<template>
<div class="sub-header">
  <slot name="home_header" :sub_header="home"></slot>
  <slot name="popular_header" :sub_header="popular"></slot>
  <slot name="notify_header" :sub_header="notifications"></slot>
  <slot name="account_header" :sub_header="accountSetting"></slot>
</div>
</template>

<script>
export default {
  name: "TheSubHeader",
  data(){
    return{
      home: 'お気に入りのスペース一覧',
      popular: '話題のスペース一覧',
      notifications: '通知',
      accountSetting: 'アカウント設定',
      movie: 'MOVIE',
      tv: 'TV'
    }
  }
}
</script>

<style scoped>
 .sub-header{
   height: 55px;
 }
</style>