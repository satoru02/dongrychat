<template>
  <v-container class="left-bar ml-16 mt-n1">
    <v-list nav color="#ffffff" class="rounded-lg">
      <v-subheader :style="category" class="mb-n2 ml-n1">メニュー</v-subheader>
      <v-list-item-group color="primary" class="mt-1">
        <v-hover v-for="(item, index) in menus" :key="index">
          <v-list-item
            @click="changeRoute(item.path_name)" class="ml-1">

            <v-list-item-icon>
              <v-badge dot offset-x="2" offset-y="7" overlap color="#3a86ff" v-if="item.text === 'フォロー中' && new_comments > 0">
              <v-list-item-subtitle class="" :size="icon.size">
                <icon-base v-if="item.text === 'ホーム'" :iconColor="'black'" icon-name="icon-home" :width="'20'" :height="'20'" :viewBox="'0 0 512.05 512.05'"><icon-home /></icon-base>
                <icon-base v-if="item.text === 'フォロー中'" :iconColor="'black'" icon-name="icon-following" :width="'20'" :height="'20'" :viewBox="'0 0 511.996 511.996'"><icon-following /></icon-base>
                <icon-base v-if="item.text === 'ウォッチリスト'" icon-name="icon-bookmark" :width="'15'" :height="'15'" :viewBox="'0 0 512 512'"><icon-bookmark /></icon-base>
              </v-list-item-subtitle>
              </v-badge>
              <v-list-item-subtitle class="" v-else :size="icon.size">
                <icon-base v-if="item.text === 'ホーム'" :iconColor="'black'" icon-name="icon-home" :width="'20'" :height="'20'" :viewBox="'0 0 512.05 512.05'"><icon-home /></icon-base>
                <icon-base v-if="item.text === 'フォロー中'" :iconColor="'black'" icon-name="icon-following" :width="'20'" :height="'20'" :viewBox="'0 0 511.996 511.996'"><icon-following /></icon-base>
                <icon-base v-if="item.text === 'ウォッチリスト'" :iconColor="'black'" icon-name="icon-bookmark" :width="'20'" :height="'20'" :viewBox="'0 0 512 512'"><icon-bookmark /></icon-base>
              </v-list-item-subtitle>
            </v-list-item-icon>

            <v-list-item-content class="ml-n6">
              <v-list-item-title :style="list_item_title.style">
                {{item.text}}
              </v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-hover>
      </v-list-item-group>
      <!-- <v-divider color="#f6f6f9" class="mt-5 ml-3 mr-10" /> -->
      <v-subheader :style="category" class="mt-4 mb-1 ml-n1">カテゴリーから探す</v-subheader>
    </v-list>
    <v-row justify="center" class="mt-n4">
      <v-col cols="12" sm="7" md="6" lg="11" class="ml-6">
        <v-chip-group column>
          <v-chip small active-class="blue--text" class="mb-3 rounded-xl" style="width: auto; font-weight: bold;"
            @click="goTagPage(tag.attributes)" color="#ebeef1" label v-for="(tag) in tags"
            :key="tag.attributes.name">
            {{tag.attributes.name}}
          </v-chip>
        </v-chip-group>
      </v-col>
    </v-row>

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
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const tagsRepository = RepositoryFactory.get('tags');
  const usersRepository = RepositoryFactory.get('users');

  export default {
    name: "TheLeftBar",
    components: {
      'icon-base': () => import( /* webpackPrefetch: true */ '../Icon/IconBase.vue'),
      'icon-home': () => import( /* webpackPrefetch: true */ '../Icon/IconHome.vue'),
      'icon-bookmark': () => import( /* webpackPrefetch: true */ '../Icon/IconBookmark.vue'),
      'icon-following': () => import( /* webpackPrefetch: true */ '../Icon/IconFollowing.vue')
    },
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
            text: 'ホーム',
            icon: '<icon-home></icon-home>',
            path_name: 'Topic'
          },
          {
            text: 'フォロー中',
            icon: '✨',
            path_name: 'Following'
          },
          {
            text: 'ウォッチリスト',
            icon: '📖',
            path_name: ''
          },
          // {
          //   text: '新着の作品',
          //   icon: `😆`,
          //   path_name: 'Trend'
          // },
          // {
          //   text: '評価の作品',
          //   icon: '👏',
          //   path_name: 'TopRated'
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
          fontSize: '16px',
          color: '#a9abad',
        },
        list_item_title: {
          color: '#011627',
          style: {
            fontWeight: '700',
            fontSize: '16px',
            // color: '#606770'
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
    created() {
      this.fetchTags()
      this.fetchComments()
    },
    methods: {
      fetchTags() {
        tagsRepository.get()
          .then(res => this.fetchTagsSuccessful(res))
          .catch(err => this.fetchFailed(err))
      },
      fetchComments() {
        usersRepository.getNewComments(this.$store.state.user.currentUser.id)
          .then(res => this.fetchUsersSuccessful(res))
          .catch(err => this.fetchFailed(err))
      },
      fetchUsersSuccessful(res) {
        console.log(res)
        this.new_comments = res.data.new_comments
      },
      fetchTagsSuccessful(res) {
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
      goTagPage(tag) {
        this.$router.replace({
          name: 'Tag',
          params: {
            // id: tag.id,
            name: tag.name,
          }
        })
      }
    }
  }
</script>

<style scoped>
.color {
  color: #ebeef1
}

</style>