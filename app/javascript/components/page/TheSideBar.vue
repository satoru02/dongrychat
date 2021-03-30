<template>
  <v-container>
    <v-row class="mt-10">
      <v-col lg=3 />
      <v-col lg=8>
        <v-divider></v-divider>
      </v-col>
    </v-row>
    <v-row class="mt-4">
      <v-col lg=3></v-col>
      <v-col lg=8>
        <v-card elevation=0 height=60 outlined class="rounded-lg">
        <v-avatar class="rounded-lg ml-4 mt-3" color="primary" tile size=36 height=36>
          <img src="https://cdn.vuetifyjs.com/images/john.jpg" alt="John">
          </v-avatar>
        </v-card>
      </v-col>
    </v-row>
    <v-list class="ml-16 mt-3" rounded v-if="$vuetify.breakpoint.width > 600">
      <v-list-item-group v-model="selectedItem" color="primary">
        <v-list-item class="mt-n2" v-for="(item, i) in menus" :key="i" @click="changeRoute(item.path_name)">
          <v-list-item-icon>
            <v-icon size=20 v-text="item.icon" />
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-subtitle v-text="item.text" color="blue" class="menu-contents" />
          </v-list-item-content>
        </v-list-item>
      </v-list-item-group>
    </v-list>
    <v-row>
      <v-col lg=12 class=mt-16 />
    </v-row>
    <v-row>
      <v-col lg=12 class=mt-15 />
    </v-row>
    <v-row class=mt-16>
      <v-col lg=3 />
      <v-col lg=8>
        <v-btn block elevation=3 class="rounded-lg" color="green" :height="35">
          <div class="btn-text">DongryChatについて 👈</div>
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
        selectedItem: '',
        menus: [{
            text: 'ホーム',
            icon: 'mdi-home-outline',
            path_name: 'Top'
          },
          {
            text: 'トレンド',
            icon: 'mdi-flag-outline',
            path_name: 'Trend'
          },
          {
            text: '検索',
            icon: 'mdi-magnify',
            path_name: 'Search'
          },
          {
            text: 'ニュース',
            icon: 'mdi-newspaper',
            path_name: 'Search'
          },
          {
            text: '通知',
            icon: 'mdi-bell-outline',
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
    font-size: 12px;
  }

  .btn-text {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 3px;
    color: #ffffff;
  }
</style>