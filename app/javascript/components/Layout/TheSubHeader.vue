<template>
<div style="height:55px;">
  <slot name="home_header" :sub_header="home"></slot>
  <slot name="notify_header" :sub_header="notifications"></slot>
  <slot name="account_header" :sub_header="accountSetting"></slot>
</div>
</template>

<script>
export default {
  name: "TheSubHeader",
  data(){
    return{
      home: 'ホーム',
      notifications: '通知',
      accountSetting: 'アカウント設定',
      movie: 'MOVIE',
      tv: 'TV'
    }
  }
}
</script>