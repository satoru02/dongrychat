<template>
  <v-container class=mt-n4>
    <v-list nav flat :style="list.style" color="#fafafa" dark class="ml-16 rounded-lg">
      <v-subheader :style="category" class="mb-n2">カテゴリー</v-subheader>
      <v-list-item-group v-model="selectedItem">
        <v-hover v-slot="{hover}" v-for="(item, index) in menus" :key="index">
          <v-list-item :elevation="hover ? 10: 0" @click="changeRoute(item.path_name)" class="ml-2 mb-n2">
            <v-list-item-icon>
              <v-icon :size="icon.size" v-text="item.icon" :color="hover ? '#02e98d' : '#011627'" />
            </v-list-item-icon>
            <v-list-item-content class="ml-n6">
              <v-list-item-title v-text="item.text" :style="hover ? list_item_title.hoverStyle : list_item_title.style" />
            </v-list-item-content>
          </v-list-item>
        </v-hover>
      </v-list-item-group>
      <v-divider color="#f6f6f9" class="mt-5 ml-3" />
      <v-list-item-group v-model="selectedItem" class="mt-3">
      <v-subheader :style="category" class="mb-n1">人気のタグ</v-subheader>
        <v-hover v-slot="{hover}" v-for="(item, index) in tags" :key="index">
          <v-list-item :elevation="hover ? 10: 0" @click="changeRoute(item.path_name)" class="mb-n2 ml-2">
            <v-list-item-content>
              <v-list-item-title v-text="item" :style="tag.style" />
            </v-list-item-content>
          </v-list-item>
        </v-hover>
      </v-list-item-group>
    </v-list>

    <!-- <v-row>
      <v-col md=12 lg=12 xl=12 />
    </v-row> -->
    <!-- <v-row :style="btn.style">
      <v-col md=3 lg=3 xl=3 />
      <v-col md=8 lg=8 xl=8>
        <v-dialog v-model="aboutDialog" width="500">
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
            <v-card-actions>
          </v-card-actions>
          </v-card>
        </v-dialog>
      </v-col>
    </v-row> -->

    <v-dialog v-model="loginDialog" width="400" transition="dialog-top-transition">
      <v-card color="#ffffff" height="250" class="rounded-lg">
        <v-row>
          <v-col lg=3 />
          <v-col lg=7>
            <div class="mt-9 ml-6" :style="dialog.headerStyle">Devioを使ってみる</div>
          </v-col>
        </v-row>
        <v-row>
          <v-col lg=1 />
          <v-col lg=10>
            <v-btn @click="goLogin()" block　:style="dialog.btnStyle" color="black" outlined elevation=0
              v-text="'ログイン'" />
          </v-col>
        </v-row>
        <v-row>
          <v-col lg=1 />
          <v-col lg=10>
            <v-btn block @click="goSignup()" :style="dialog.btnStyle" color="#016aff" elevation=0 v-text="'アカウント作成'" />
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
    name: "TheLeftBar",
    data() {
      return {
        loginDialog: false,
        aboutDialog: false,
        selectedItem: '',
        query: '',
        overviewText:
        'Devioは、最新の配信ドラマから往年のクラシック映画まで自由に会話できるオープンコミュニティです。見たばかりの感動や興奮を、共有できる場所を目指しています。',
        tags: [
          '# love',
          '# サイエンス',
          '# action',
          '# ドラマ',
          '# ホラー',
          '# love',
          '# アドベンチャー',
          '# love',
        ],
        menus: [{
            text: 'チャート',
            icon: 'mdi-access-point',
            path_name: 'Chart'
          },
          {
            text: 'ホーム',
            icon: 'mdi-home-outline',
            path_name: 'Home'
          },
          {
            text: '検索',
            icon: 'mdi-magnify',
            path_name: 'Search'
          },
          {
            text: '通知',
            icon: 'mdi-bell-outline',
            path_name: 'NotificationTop'
          },
          {
            text: '未定',
            icon: 'mdi-bell-outline',
            path_name: 'NotificationTop'
          },
          {
            text: '未定',
            icon: 'mdi-pen',
            path_name: 'NotificationTop'
          },
          {
            text: '未定',
            icon: 'mdi-bell-outline',
            path_name: 'NotificationTop'
          },
          {
            text: '設定',
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
          position: '',
          style: {
            position: 'fixed',
            color: '#ced4da',
            width: "200px"
          }
        },
        list_item: {
          position: 'mt-1'
        },
        icon: {
          size: 20,
          color: '#6c757d'
        },
        tag: {
          style: {
            fontWeight: 'bold',
             color: '#011627',
            fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
            fontSize: '13px',
          }
        },
        category: {
          fontWeight: 'bold',
          fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
          fontSize: '12px',
          color: '#6c757d',
        },
        list_item_title: {
          color: '#011627',
          hoverStyle: {
            fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
            fontSize: '14px',
            color: '#02e98d',
            fontWeight: 'bold',
          },
          style: {
            fontWeight: 'bold',
            fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
            fontSize: '13px',
            color: '#011627'
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
            fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
            fontSize: '3px',
            width: '145px',
            color: '#ffffff',
          }
        },
        dialog: {
          headerStyle: {
            color: '#111111',
            fontWeight: 'bold',
            fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
            fontSize: '17px',
          },
          btnStyle: {
            color: '#ffffff',
            fontWeight: 'bold',
            fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
            fontSize: '12px',
          },
          policyStyle: {
            color: '#6c757d',
            fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
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

<style scoped>
  .v-divider {
    border-color: rgba(5, 5, 5, 0.06);
  }
  .v-input__slot::before {
    border-style: none !important;
  }
</style>