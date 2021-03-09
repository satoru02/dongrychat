<template>
  <v-container>
    <v-row class="top-part" />
    <v-row>
      <v-col lg=2 class="hidden-xs-only" />
      <v-col cols=2 lg=1 class="ml-8">
      <v-badge color="green" bordered right offset-x="15" offset-y="75" overlap>
        <v-avatar color="red" size=75 height=75 tile class="rounded-xl" />
      </v-badge>
      </v-col>
      <v-col cols=5 lg=1 class="ml-6 mt-3">
        <v-row>
          <v-col cols=12>
            <div class="user-name">Satoru</div>
          </v-col>
        </v-row>
        <v-row class="mt-n6">
          <v-col cols=12>
            <div class="user-nickname">@sugish0021</div>
          </v-col>
        </v-row>
      </v-col>
      <v-col cols=2 class="mt-5 ml-1">
        <v-btn block elevation="0" class="rounded-lg" color="orange">
          <div class="f-text">フォロー</div>
        </v-btn>
      </v-col>
    </v-row>
    <v-row class="mt-3">
      <v-col lg=2 class="hidden-xs-only" />
      <v-col cols=12 lg=8>
        <v-tabs grow class="mt-n3" background-color="#fafaf9" icons-and-text>
          <v-tabs-slider />
          <v-tab class="list-text" active-class="black--text">Rooms</v-tab>
          <v-tab class="list-text" active-class="black--text">Followers</v-tab>
          <v-tab class="list-text" active-class="black--text">Followings</v-tab>
          <v-tab class="list-text" active-class="black--text">Schedule</v-tab>
        </v-tabs>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
  export default {
    name: 'UserTop'
  }
</script>

<style scoped>
  .top-part {
    height: 14px;
  }

  .user-name {
    font-family: 'Helvetica Neue', sans-serif;
    font-weight: bold;
    font-size: 22px;
    color: #000000;
    letter-spacing: 1px;
  }

  .user-nickname {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 12px;
    font-weight: bold;
    color: #adb5bd;
  }

  .user-menu {
    background-color:#fafaf9;
  }

  .list-text {
    font-size: 10px;
    font-family: 'Helvetica Neue', sans-serif;
    font-weight: bold;
  }

  .f-text {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 10px;
    color: #ffffff;
  }
</style>