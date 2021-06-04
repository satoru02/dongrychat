<template>
  <v-container class="left-bar mt-n4">
    <v-list nav flat :style="list.style" color="#ffffff" dark class="ml-16 rounded-lg" style="background-color: #ffffff;">
      <v-subheader :style="category" class="mb-n2">メニュー</v-subheader>
      <v-list-item-group v-model="selectedItem">
        <v-hover v-slot="{hover}" v-for="(item, index) in menus" :key="index">
          <v-list-item :elevation="hover ? 10: 0" @click="changeRoute(item.path_name)" class="ml-2 mb-n2">
            <v-list-item-icon>
              <v-list-item-subtitle :size="icon.size" v-text="item.icon" />
            </v-list-item-icon>
            <v-list-item-content class="ml-n6">
              <v-list-item-title :active-class="'green--text'" :style="hover ? list_item_title.hoverStyle : list_item_title.style">
                {{item.text}}
                <span>
                  <v-chip class="ml-3 mb-1" v-if="item.text === 'お気に入り' && new_comments > 0" x-small elevation=0
                    color="#02e98d">{{new_comments}}</v-chip>
                </span>
              </v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-hover>
      </v-list-item-group>
      <v-divider color="#f6f6f9" class="mt-5 ml-3" />
      <v-list-item-group v-model="selectedItem" class="mt-3">
        <v-subheader :style="category" class="mb-2">人気のカテゴリ</v-subheader>
        <v-hover v-slot="{hover}" v-for="(tag, index) in tags" :key="index">
          <v-list-item dense :elevation="hover ? 10: 0" @click="goTagPage(tag.attributes)" class="mb-3 ml-2 mt-n3">
            <v-list-item-content>
              <v-list-item-title :style="hover ? list_item_title.hoverStyle : list_item_title.style">
                #{{tag.attributes.name}}
              </v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-hover>
      </v-list-item-group>
    </v-list>

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
  import { RepositoryFactory } from '../../repositories/RepositoryFactory';
  const tagsRepository = RepositoryFactory.get('tags');
  const usersRepository = RepositoryFactory.get('users');

  export default {
    name: "TheLeftBar",
    data() {
      return {
        loginDialog: false,
        aboutDialog: false,
        selectedItem: '',
        new_comments: '',
        error: '',
        query: '',
        logoStyle: {
          fontWeight: 'bold',
          fontFamily: 'Helvetica Neue, sans-serif',
          fontSize: '22px',
          color: '#011627',
          cursor: 'pointer'
        },
        overviewText: 'Devioは、最新の配信ドラマから往年のクラシック映画まで自由に会話できるオープンコミュニティです。見たばかりの感動や興奮を、共有できる場所を目指しています。',
        tags: [],
        menus: [{
            text: '話題',
            icon: '🎉',
            path_name: 'Chart'
          },
          {
            text: 'お気に入り',
            icon: '✨',
            path_name: 'Home'
          },
          // {
          //   text: 'フォロー中',
          //   icon: '😉',
          //   path_name: 'Search'
          // },
          {
            text: '人気の作品',
            icon: '📖',
            path_name: 'Popular'
          },
          {
            text: '新着の作品',
            icon: '🔎',
            path_name: 'Trend'
          },
          {
            text: '評価の高い作品',
            icon: '👏',
            path_name: 'TopRated'
          },
          // {
          //   text: '話題',
          //   icon: '🗞',
          //   path_name: 'Upcoming'
          // },
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
          size: 14,
          color: '#6c757d'
        },
        tag_item: {
          fontWeight: 'bold',
          color: '#14171a',
          fontSize: '13px',
        },
        category: {
          fontWeight: 'bold',
          fontSize: '12px',
          color: '#657786',
        },
        list_item_title: {
          color: '#011627',
          hoverStyle: {
            fontSize: '14px',
            color: '#02e98d',
            // fontWeight: 'bold',
          },
          style: {
            // fontWeight: 'bold',
            fontSize: '14px',
            color: '#111111'
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
            fontSize: '3px',
            width: '145px',
            color: '#ffffff',
          }
        },
        dialog: {
          headerStyle: {
            color: '#111111',
            fontWeight: 'bold',
            fontSize: '17px',
          },
          btnStyle: {
            color: '#ffffff',
            fontWeight: 'bold',
            fontSize: '12px',
          },
          policyStyle: {
            color: '#6c757d',
            fontSize: '4px',
          }
        }
      }
    },
    created(){
      this.fetchTags()
      this.fetchComments()
    },
    methods: {
      fetchTags(){
        tagsRepository.get()
          .then(res => this.fetchTagsSuccessful(res))
          .catch(err => this.fetchFailed(err))
      },
      fetchComments(){
        usersRepository.getNewComments(this.$store.state.user.currentUser.id)
          .then(res => this.fetchUsersSuccessful(res))
          .catch(err => this.fetchFailed(err))
      },
      fetchUsersSuccessful(res){
        this.new_comments = res.data.new_comments
      },
      fetchTagsSuccessful(res){
        this.tags = res.data.data
      },
      fetchFailed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      },
      changeRoute(path) {
        if ((path === 'Home') || (path === 'Settings')) {
          if (!this.$store.state.user.signedIn) {
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
      },
      goTagPage(tag){
        this.$router.replace({name: 'Tag', params: {
          // id: tag.id,
          name: tag.name,
        }})
      }
    }
  }
</script>

<style scoped>
  .left-bar {
    /* font-weight: bold; */
  }

  .v-divider {
    border-color: rgba(24, 23, 23, 0);
    color: #dddddd
  }

  .v-input__slot::before {
    border-style: none !important;
  }

  .v-chip {
    width: 26px;
    min-width: 26px;
  }

  .v-chip__content {
    margin-left: -10px;
  }

  .v-chip.v-size--x-small {
    border-radius: 5px;
    font-size: 11px;
    margin-right: 10px;
    padding-right: 20px;
    padding-left: 5;
  }

  .tag_item {
    font-weight: bold;
    color: #14171a;
    font-size: '13px';
  }
</style>