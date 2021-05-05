<template>
  <v-container class="ml-n6 mt-7">
    <v-list nav flat :class="list.position" :style="list.style" color="#121214" dark>
      <v-list-item-group v-model="selectedItem" color="#4361ee">
        <v-hover v-slot="{hover}" v-for="(item, index) in menus" :key="index">
          <v-list-item :class="list_item.position" :elevation="hover ? 10: 0" @click="changeRoute(item.path_name)">
            <v-list-item-icon>
              <v-icon :size="icon.size" v-text="item.icon" />
            </v-list-item-icon>
            <v-list-item-content>
              <v-list-item-title v-text="item.text" :style="list_item_title.style" />
            </v-list-item-content>
          </v-list-item>
        </v-hover>
      </v-list-item-group>
    </v-list>
    <v-row :class="bottom_blank_space.position" :style="bottom_blank_space.style">
      <v-col md=12 lg=12 xl=12 />
    </v-row>

    <v-row :class="btn.position" :style="btn.style">
      <v-col md=3 lg=3 xl=3 />
      <v-col md=8 lg=8 xl=8>
        <v-dialog v-model="aboutDialog" width="500">
        <!-- <v-dialog fullscreen v-model="aboutDialog" width="500"> -->
          <template v-slot:activator="{on, attrs}">
            <v-btn block v-bind="attrs" v-on="on" :elevation="btn.elevation" :class="btn.round" :color="btn.color"
              :height="btn.height">
              <div :style="btn_text.style" v-text="btn_text.text" />
            </v-btn>
          </template>
          <v-card>
            <v-card-title class="sub-headline lighten-2">
              Devioについて
            </v-card-title>
            <v-card-text>
              {{ overviewText }}
            </v-card-text>
            <!-- <v-divider></v-divider> -->
            <v-card-actions>
              <!-- <v-spacer></v-spacer>
                <v-btn color="primary" text @click="aboutDialog = false">
                　close
                </v-btn> -->
              </v-card-actions>
          </v-card>
        </v-dialog>
      </v-col>
    </v-row>

    <v-dialog v-model="loginDialog" width="400" transition="dialog-top-transition">
      <v-card color="#161b22" height="250" class="rounded-lg">
        <v-row>
          <v-col lg=3 />
          <v-col lg=7>
            <div class="mt-9 ml-6" :style="dialog.headerStyle">Devioを使ってみる</div>
          </v-col>
        </v-row>
        <v-row>
          <v-col lg=1 />
          <v-col lg=10>
            <v-btn @click="goLogin()" block　:style="dialog.btnStyle" color="blue" outlined elevation=0
              v-text="'ログイン'" />
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
        aboutDialog: false,
        selectedItem: '',
        query: '',
        overviewText:
        'Devioは、最新の配信ドラマから往年のクラシック映画まで自由に会話できるオープンコミュニティです。見たばかりの感動や興奮を、共有できる場所を目指しています。',
        menus: [{
            text: 'Chart',
            icon: 'mdi-access-point',
            path_name: 'Chart'
          },
          {
            text: 'Home',
            icon: 'mdi-home-outline',
            path_name: 'Home'
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
            height: '400px'
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
          color: '#3a0ca3'
        },
        list_item_title: {
          color: '#ced4da',
          hoverStyle: {
            fontWeight: '#4361ee',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '15px',
            color: 'blue'
          },
          style: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '15px',
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
          text: 'Devioについて 👈',
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
            }).catch(() => {});
          }
        } else {
          this.$router.push({
            name: path
          }).catch(() => {});
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