<template>
  <v-container>
    <v-row class="mt-n2">
      <v-col lg=3></v-col>
      <v-col lg=8>
        <v-avatar class="rounded-lg" color="primary" tile size=40 height=41 />
      </v-col>
    </v-row>
    <v-list class="ml-16 mt-7" rounded v-if="$vuetify.breakpoint.width > 600">
      <v-list-item-group v-model="selectedItem" color="primary">
        <v-list-item class="mt-n3" v-for="(item, i) in menus" :key="i" @click="changeRoute(item.path_name)">
          <v-list-item-icon>
            <v-icon v-text="item.icon" />
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-subtitle v-text="item.text" class="menu-contents" />
          </v-list-item-content>
        </v-list-item>
      </v-list-item-group>
    </v-list>
    <v-row>
      <v-col lg=12 class=mt-16 />
    </v-row>
    <v-row>
      <v-col lg=12 class=mt-16 />
    </v-row>
    <v-row class=mt-8>
      <v-col lg=3 />
      <v-col lg=8>
        <v-btn block elevation=3 class="rounded-lg" color="yellow" :height="35">
          <div class="btn-text">about DongryChat 👈</div>
          <!-- <div class="btn-text">今週の新着配信！ 👈</div> -->
          <!-- <div class="btn-text">Netflixで話題の映画！</div> -->
        </v-btn>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
  export default {
    name: "TheSideBar",
    data() {
      return {
        selectedItem: null,
        menus: [{
            text: 'ホーム',
            icon: 'mdi-home-outline',
            path_name: 'Top'
          },
          {
            text: '新着',
            icon: 'mdi-newspaper',
            path_name: 'Trend'
          },
          {
            text: 'ランキング',
            icon: 'mdi-flag-outline',
            path_name: 'Trend'
          },
          {
            text: '検索',
            icon: 'mdi-magnify',
            path_name: 'Search'
          },
          {
            text: 'コラム',
            icon: 'mdi-book-open',
            path_name: 'Search'
          },
          {
            text: '通知',
            icon: 'mdi-bell-outline',
            path_name: ''
          },
          {
            text: 'ユーザー',
            icon: 'mdi-account-outline',
            path_name: ''
          },
          {
            text: '設定',
            icon: 'mdi-wrench-outline',
            path_name: ''
          },
        ],
      }
    },
    methods: {
      changeRoute(path) {
        this.$router.push({
          name: path
        })
      }
    }
  }
</script>

<style scoped>
  .menu-contents {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 13px;
    color: #000000;
  }

  .btn-text {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 3px;
    color: #1f1d1d;
  }
</style>