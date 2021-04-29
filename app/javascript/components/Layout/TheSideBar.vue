<template>
  <v-container class="ml-n6 mt-3">
    <v-list nav :class="list.position" :style="list.style" color="#0e0e10">
      <v-list-item-group v-model="selectedItem">
        <v-list-item color="#ffffff" :class="list_item.position" v-for="(item, index) in menus" :key="index"
          @click="changeRoute(item.path_name)">
          <v-list-item-icon>
            <v-icon :size="icon.size" v-text="item.icon" :color="icon.color" />
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title v-text="item.text" :style="list_item_title.style" color="#ffffff" />
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

    <v-dialog v-model="loginDialog" width="400" transition="dialog-top-transition">
      <v-card color="#161b22" height="250" class="rounded-lg">
        <v-row>
          <v-col lg=3 />
          <v-col lg=7>
            <div class="mt-9" :style="dialog.headerStyle">DongryChatを使ってみる</div>
          </v-col>
        </v-row>
        <v-row>
          <v-col lg=1 />
          <v-col lg=10>
            <v-btn @click="goLogin()" block　:style="dialog.btnStyle" color="blue" outlined elevation=0 v-text="'ログイン'" />
          </v-col>
        </v-row>
        <v-row>
          <v-col lg=1 />
          <v-col lg=10>
            <v-btn block @click="goSignup()" :style="dialog.btnStyle" color="blue" elevation=0 v-text="'アカウント作成'" />
          </v-col>
        </v-row>
        <v-row>
          <v-col cols=3 sm=3 md=3 lg=3 xl=3 />
          <v-col cols=8 sm=8 md=8 lg=9 xl=8>
            <div class="ml-1" :style="dialog.policyStyle" v-text="'利用規約とプライバシーポリシーはこちら'" />
          </v-col>
        </v-row>
      </v-card>
    </v-dialog>

  </v-container>
</template>

<script>
  export default {
    name: "TheSideBar",
    data() {
      return {
        loginDialog: false,
        selectedItem: '',
        query: '',
        menus: [{
            text: 'Charts',
            icon: 'mdi-access-point',
            path_name: 'Chart'
          },
          {
            text: 'Home',
            icon: 'mdi-home-outline',
            path_name: 'Home'
          },
          {
            text: 'Watch',
            icon: 'mdi-television',
            path_name: 'Search'
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
        header_part: {
          position: 'mt-n5 ml-n4 mr-3',
        },
        top_blank_space: {
          position: 'mt-13'
        },
        bottom_blank_space: {
          position: 'mt-15 ml-n6 mb-13',
          style: {
            height: '476px'
          }
        },
        list: {
          position: 'ml-16 mt-n6',
          style: {
            position: 'fixed',
            color: '#ced4da'
          }
        },
        list_item: {
          position: 'mt-1'
        },
        icon: {
          size: 20,
          color: '#c9d1d9'
        },
        list_item_title: {
          style: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '15px',
            color: '#ced4da'
          }
        },
        btn: {
          position: 'mt-15 ml-1',
          elevation: 0,
          round: 'rounded-lg',
          color: 'blue',
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
            width: '145px',
            color: '#ffffff',
          }
        },
        dialog: {
          headerStyle: {
            color: '#ced4da',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '17px',
          },
          btnStyle: {
            color: '#ffffff',
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '12px',
          },
          policyStyle: {
            color: '#6c757d',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '4px',
          }
        }
      }
    },
    methods: {
      changeRoute(path) {
        if ((path === 'Home') || (path === 'Settings')) {
          if (!this.$store.state.signedIn) {
            this.loginDialog = true
            return
          } else {
            this.$router.push({
              name: path
            }).catch(()=>{});
          }
        } else {
          this.$router.push({
            name: path
          }).catch(()=> {});
        }
      },
      goLogin() {
        this.$router.replace('/login')
      },
      goSignup() {
        this.$router.replace('/signup')
      }
    }
  }
</script>