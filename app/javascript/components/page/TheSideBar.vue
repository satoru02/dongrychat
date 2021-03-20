<template>
  <v-list rounded v-if="$vuetify.breakpoint.width > 600">
    <v-list-item-group v-model="selectedItem" color="primary">
      <v-list-item v-for="(item, i) in menus" :key="i" @click="changeRoute(item.path_name)">
        <v-list-item-icon>
          <v-icon v-text="item.icon" />
        </v-list-item-icon>
        <v-list-item-content>
          <v-list-item-subtitle v-text="item.text" class="menu-contents" />
        </v-list-item-content>
      </v-list-item>
    </v-list-item-group>
  </v-list>
</template>

<script>
  export default {
    name: "TheSideBar",
    data() {
      return {
        selectedItem: null,
        menus: [{
            text: 'Home',
            icon: 'mdi-home-outline',
            path_name: 'Top'
          },
          {
            text: 'Trend',
            icon: 'mdi-flag-outline',
            path_name: 'Trend'
          },
          {
            text: 'Discover',
            icon: 'mdi-magnify',
            path_name: 'Search'
          },
          {
            text: 'Notification',
            icon: 'mdi-bell-outline',
            path_name: ''
          },
          {
            text: 'Users',
            icon: 'mdi-account-outline',
            path_name: ''
          },
          {
            text: 'Setting',
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
    font-size: 15px;
    color: #000000;
  }
</style>