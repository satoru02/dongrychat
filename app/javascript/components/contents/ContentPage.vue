<template>
<v-container class=mt-13>
</v-container>
</template>

<script>
import BaseContentSheet from '../base/BaseContentSheet'
import ContentDiscussion from '../contents/ContentDiscussion';

export default {
  name: 'ContentPage',
  components:{
    'base-content-sheet': BaseContentSheet,
    'content-discussion': ContentDiscussion
  }
}
</script>

<style scoped>
.content-title{
  font-family: 'Helvetica Neue', sans-serif;
  font-weight: bold;
  font-size: 22px;
  color: #3d2c29;
}

.description{
  font-family: 'Helvetica Neue', sans-serif;
  font-weight: bold;
  font-size: 13px;
  color: #3d2c29;
}
</style>