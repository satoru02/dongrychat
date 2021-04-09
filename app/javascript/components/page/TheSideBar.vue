<template>
  <v-container v-if="$vuetify.breakpoint.width > 600">
    <v-row :class="header_part.position">
      <v-col md=3 lg=3 xl=3 />
      <v-col md=9 lg=9 xl=9>
      </v-col>
    </v-row>
    <v-row>
      <v-col md=12 lg=12 xl=12 :class="top_blank_space.position" />
    </v-row>
    <v-list nav :class="list.position" :style="list.style">
      <v-list-item-group v-model="selectedItem">
        <v-list-item :class="list_item.position" v-for="(item, index) in menus" :key="index"
          @click="changeRoute(item.path_name)">
          <v-list-item-icon>
            <v-icon :size="icon.size" v-text="item.icon" :color="icon.color" />
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title v-text="item.text" :style="list_item_title.style" />
          </v-list-item-content>
        </v-list-item>
      </v-list-item-group>
    </v-list>
    <v-row :class="bottom_blank_space.position" :style="bottom_blank_space.style">
      <v-col md=12 lg=12 xl=12 />
    </v-row>
    <v-row :class="btn.position" :style="btn.style">
      <v-col md=3 lg=3 xl=3 />
      <v-col md=8 lg=8 xl=8>
        <v-btn block :elevation="btn.elevation" :class="btn.round" :color="btn.color" :height="btn.height">
          <div :style="btn_text.style" v-text="btn_text.text" />
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
        query: '',
        menus: [
          {
            text: 'Live feed',
            icon: 'mdi-access-point',
            path_name: 'Trend'
          },
          {
            text: 'Space',
            icon: 'mdi-home-outline',
            path_name: 'Top'
          },
          {
            text: 'Discover',
            icon: 'mdi-magnify',
            path_name: 'Search'
          },
          {
            text: 'Notifications',
            icon: 'mdi-bell-outline',
            path_name: ''
          },
          {
            text: 'Settings',
            icon: 'mdi-wrench-outline',
            path_name: 'Settings'
          },
        ],
        // css objects -----------------------------
        header_part: {
          position: 'mt-n3 ml-n4 mr-3',
        },
        top_blank_space: {
          position: 'mt-16'
        },
        bottom_blank_space: {
          position: 'mt-6 ml-n6 mb-13',
          style: {
            height: '470px'
          }
        },
        list: {
          position: 'ml-16 mt-n6',
          style: {
            position: 'fixed',
            color: '#F6F6F6'
          }
        },
        list_item: {
          position: 'mt-1'
        },
        icon: {
          size: 20,
          color: '#000000'
        },
        list_item_title: {
          style: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '15px',
            color: '#011627'
          }
        },
        btn: {
          position: 'mt-15 ml-1',
          elevation: 3,
          round: 'rounded-lg',
          color: '#ff0054',
          height: 35,
          style: {
            position: 'fixed'
          }
        },
        btn_text: {
          text: 'DongryChatについて 👈',
          style: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '3px',
            color: '#ffffff',
          }
        }
        // -----------------------------
      }
    },
    methods: {
      changeRoute(path) {
        this.$router.push({
          name: path
        })
      },
    }
  }
</script>

<style scoped>
</style>