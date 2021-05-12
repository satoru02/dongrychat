<template>
<div style="height:55px;">
  <slot name="home_header" :sub_header="home"></slot>
</div>
</template>

<script>
export default {
  name: "TheSubHeader",
  data(){
    return{
      home: 'ホーム',
      movie: 'MOVIE',
      tv: 'TV'
    }
  }
}
</script>