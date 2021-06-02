<template>
  <v-container :class="grid.rightPart">
    <the-profile-part />
    <v-row class="mt-4">
      <v-col lg=9>
        <v-img class="rounded-lg" elevation="0" height="80" width="230" src="https://source.unsplash.com/random">
        </v-img>
      </v-col>
    </v-row>
    <v-row class="mt-7">
      <v-col lg=9>
        <v-sheet color="#ff006e" class="rounded-lg">
          <v-row>
            <v-col lg=1></v-col>
            <v-col lg=9 :style="leftStyle" class="ml-4">
              🙌
              <span class="ml-1">Devioのおすすめ作品</span>
            </v-col>
          </v-row>
        </v-sheet>
      </v-col>
    </v-row>
    <v-row class="mt-7">
      <v-col lg=9>
        <v-sheet color="#000000" class="rounded-lg">
          <v-row>
            <v-col lg=1></v-col>
            <v-col lg=9 :style="leftStyle" class="ml-4">
              <v-icon color="#e50914" size=19 class="mt-n1">
                mdi-netflix
              </v-icon>
              <span class="ml-1">Netflixで人気の作品</span>
            </v-col>
          </v-row>
        </v-sheet>
      </v-col>
    </v-row>
    <v-row class="mt-7">
      <v-col lg=9>
        <v-sheet color="#1b2530" class="rounded-lg">
          <v-row>
            <v-col lg=1></v-col>
            <v-col lg=9 :style="leftStyle" class="ml-4">
              <v-icon color="#0066c0" size=19 class="mt-n1">
                mdi-amazon
              </v-icon>
              <span class="ml-1">プライムで人気の作品</span>
            </v-col>
          </v-row>
        </v-sheet>
      </v-col>
    </v-row>
    <v-sheet color="#f5f8fa" width="233px" class="rounded-lg">
      <v-row class="mt-9 ml-1">
        <v-col lg=7>
          <h3 :style="style.online" v-text="'注目の作品'" />
        </v-col>
        <v-col lg=5>
          <!-- <div class="mt-2" :style="moreStyle" v-text="'もっと見る'" /> -->
        </v-col>
      </v-row>

      <v-row class="mt-3 ml-1" v-for="(item, index) in items" :key="index">
        <v-col lg=4>
          <v-img class="rounded-lg" elevation="0" height="50" width="50" :src="base_tmdb_img_url + item.attributes.image_path">
          </v-img>
        </v-col>
        <v-col lg=8 class="ml-n5">
          <div :style="contentsStyle">{{item.attributes.name}}</div>
          <v-avatar size="20" class="" v-for="(user, index) in item.attributes.users.data" :key="index">
            <v-img v-if="user.attributes.avatar_url" :src="user.attributes.avatar_url" />
            <v-img v-else src="https://cdn.vuetifyjs.com/images/john.jpg" />
          </v-avatar>
          <span :style="moreStyle" class="ml-9 mb-n3">計{{item.attributes.users.data.length}}人</span>
        </v-col>
      </v-row>
      <!-- <v-row class="mt-5 ml-1">
        <v-col lg=4>
          <v-img class="rounded-lg" elevation="0" height="50" width="50" src="https://source.unsplash.com/random">
          </v-img>
        </v-col>
        <v-col lg=8 class="ml-n5">
          <div :style="contentsStyle">ブラックパンサー</div>
          <v-avatar size="20" class="mt-2">
            <v-img src="https://cdn.vuetifyjs.com/images/john.jpg" />
          </v-avatar>
          <v-avatar size="20" class="mt-2 ml-n2">
            <v-img src="https://cdn.vuetifyjs.com/images/john.jpg" />
          </v-avatar>
          <v-avatar size="20" class="mt-2 ml-n2">
            <v-img src="https://cdn.vuetifyjs.com/images/john.jpg" />
          </v-avatar>
          <v-avatar size="20" class="mt-2 ml-n2">
            <v-img src="https://cdn.vuetifyjs.com/images/john.jpg" />
          </v-avatar>
        </v-col>
      </v-row>
      <v-row class="mt-5 ml-1">
        <v-col lg=4>
          <v-img class="rounded-lg" elevation="0" height="50" width="50" src="https://source.unsplash.com/random">
          </v-img>
        </v-col>
        <v-col lg=8 class="ml-n5">
          <div :style="contentsStyle">ブラックパンサー</div>
          <v-avatar size="20" class="mt-2">
            <v-img src="https://cdn.vuetifyjs.com/images/john.jpg" />
          </v-avatar>
          <v-avatar size="20" class="mt-2 ml-n2">
            <v-img src="https://cdn.vuetifyjs.com/images/john.jpg" />
          </v-avatar>
          <v-avatar size="20" class="mt-2 ml-n2">
            <v-img src="https://cdn.vuetifyjs.com/images/john.jpg" />
          </v-avatar>
          <v-avatar size="20" class="mt-2 ml-n2">
            <v-img src="https://cdn.vuetifyjs.com/images/john.jpg" />
          </v-avatar>
        </v-col>
      </v-row> -->
      <!-- <v-row class="mt-3 ml-1">
        <v-col lg=4>
          <v-img class="rounded-lg" elevation="0" height="50" width="50" src="https://source.unsplash.com/random">
          </v-img>
        </v-col>
        <v-col lg=8 class="ml-n5" :style="contentsStyle">
          ワンダヴィジョン
        </v-col>
      </v-row>
      <v-row class="mt-3 ml-1">
        <v-col lg=4>
          <v-img class="rounded-lg" elevation="0" height="50" width="50" src="https://source.unsplash.com/random">
          </v-img>
        </v-col>
        <v-col lg=8 class="ml-n5" :style="contentsStyle">
          全裸監督
        </v-col>
      </v-row> -->

    </v-sheet>

    <!-- ピックアップ + 注目ユーザー -->
    <!-- <v-row :class="grid.onlinePart">
      <v-col md=12 lg=12 xl=12>
        <h3 :style="style.online" v-text="onlineTitle" />
      </v-col>
    </v-row>
    <v-row v-for="(following, index) in online_followings" :key="index">
      <v-col md=1 lg=1 xl=1>
        <v-badge offset-x="6" offset-y="6" bordered bottom dot overlap>
        <v-avatar :size="avatar.size" :height="avatar.height">
          <v-img :src="following.attributes.avatar_url" />
        </v-avatar>
        </v-badge>
      </v-col>
      <v-col md=1 lg=1 xl=1 />
      <v-col md=8 lg=8 xl=8 :class="grid.username">
        <h3 :style="style.name" v-text="following.attributes.name" />
      </v-col>
   </v-row> -->

    <v-row no-gutters class="mt-10">
      <v-hover v-slot="{hover}">
        <v-col lg=4 :style="hover ? style.hoverlink : style.unhoverlink" @click="movePath('Terms')">
          利用規約
        </v-col>
      </v-hover>
      <v-hover v-slot="{hover}">
        <v-col lg=8 :style="hover ? style.hoverlink : style.unhoverlink" class="ml-n4" @click="movePath('Privacy')">
          プライバシーポリシー
        </v-col>
      </v-hover>
    </v-row>
    <v-row no-gutters>
      <v-hover v-slot="{hover}">
        <v-col lg=4 :style="hover ? style.hoverlink : style.unhoverlink">
          お問い合わせ
        </v-col>
      </v-hover>
      <v-hover v-slot="{hover}">

        <v-col lg=8 :style="hover ? style.hoverlink : style.unhoverlink">
          © 2021 Devio
        </v-col>
      </v-hover>

    </v-row>
  </v-container>
</template>

<script>

  import TheProfilePart from './TheProfilePart';
  import { RepositoryFactory } from '../../repositories/RepositoryFactory';
  const spacesRepository = RepositoryFactory.get('spaces');

  export default {
    name: "TheRightBar",
    components: {
      'the-profile-part': TheProfilePart
    },
    data() {
      return {
        query: '',
        canSubmit: false,
        online_endpoint: `/api/v1/users/`,
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w500`,
        online_followings: '',
        items: '',
        error: '',
        mdi: {
          magnify: 'mdi-magnify'
        },
        leftStyle: {
          fontWeight: 'bold',
          fontSize: '13px',
          color: '#ffffff'
        },
        moreStyle: {
          fontWeight: 'bold',
          fontSize: '11px',
          color: '#374151'
        },
        contentsStyle: {
          fontWeight: 'bold',
          fontSize: '14px',
          color: '#374151'
        },
        style: {
          name: {
            fontWeight: 'bold',
            fontSize: '11px',
            color: '#374151'
          },
          online: {
            fontWeight: 'bold',
            fontSize: '18px',
            color: '#111111'
          },
          hoverlink: {
            fontWeight: 'bold',
            fontSize: '9px',
            color: '#374151',
            cursor: 'pointer',
          },
          unhoverlink: {
            fontWeight: 'bold',
            fontSize: '9px',
            color: '#6c757d',
            cursor: 'pointer',
          }
        },
        grid: {
          rightPart: 'ml-9 mt-4',
          onlinePart: 'mt-7',
          username: 'mt-2 ml-n1'
        },
        textField: {
          placeholder: '検索',
          round: 'rounded-lg',
          width: 350,
        },
        onlineTitle: 'Online',
        avatar: {
          size: 35,
          height: 35,
        },
        profile: {
          size: 50,
          height: 50,
        },
      }
    },
    created() {
      // this.getOnlineFollowings()
      this.fetchPopularContents()
    },
    methods: {
      // getOnlineFollowings() {
      //   secureAxios.get(this.online_endpoint + `${this.$store.state.user.currentUser.id}` + `/online`)
      //     .then(res => this.Successful(res))
      //     .catch(err => this.Failed(err))
      // },
      // Successful(res) {
      //   this.online_followings = res.data.data
      // },
      fetchPopularContents(){
        spacesRepository.getPopular({media: 'tv'})
        .then(res => this.fetchSuccessful(res))
        .catch(err => this.fetchFailed(err))
      },
      fetchSuccessful(res){
        this.items = res.data.data
      },
      fetchFailed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      },
      setQuery() {
        this.canSubmit = true
      },
      movePath(link) {
        this.$router.push({
          name: link
        })
      }
    }
  }
</script>

<style scoped>
  .v-text-field {
    width: 250px;
  }
</style>