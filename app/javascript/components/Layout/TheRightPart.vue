<template>
  <v-container :class="grid.rightPart">
    <the-profile-part />
    <v-row :class="grid.onlinePart">
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
   </v-row>

    <v-row no-gutters class="mt-10">
      <v-hover v-slot="{hover}">
        <v-col lg=4 :style="hover ? style.unhoverlink : style.hoverlink" @click="movePath('Terms')">
          利用規約
        </v-col>
      </v-hover>
      <v-hover v-slot="{hover}">
      <v-col lg=8 :style="hover ? style.unhoverlink : style.hoverlink" class="ml-n4" @click="movePath('Privacy')">
        プライバシーポリシー
      </v-col>
      </v-hover>
    </v-row>
    <v-row no-gutters>
      <v-hover v-slot="{hover}">
      <v-col lg=4 :style="hover ? style.unhoverlink : style.hoverlink">
        お問い合わせ
      </v-col>
      </v-hover>
      <v-hover v-slot="{hover}">

      <v-col lg=8 :style="hover ? style.unhoverlink : style.hoverlink">
        © 2021 Devio
      </v-col>
      </v-hover>

    </v-row>
  </v-container>
</template>

<script>
  import { secureAxios } from '../../backend/axios';
  import TheProfilePart from '../Layout/TheProfilePart';

  export default {
    name: "RightPart",
    components: {
      'the-profile-part': TheProfilePart
    },
    data() {
      return {
        query: '',
        canSubmit: false,
        online_endpoint: `/api/v1/users/`,
        online_followings: ``,
        mdi: {
          magnify: 'mdi-magnify'
        },
        style: {
          name: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '14px',
            color: '#ced4da'
          },
          online: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '20px',
            color: '#ced4da'
          },
          hoverlink: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '9px',
            color: '#6c757d',
            cursor: 'pointer',
          },
          unhoverlink: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '9px',
            color: '#ffffff',
            cursor: 'pointer',
          }
        },
        grid: {
          rightPart: 'ml-9 mt-9',
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
    created(){
      this.getOnlineFollowings()
    },
    methods: {
      getOnlineFollowings(){
        secureAxios.get(this.online_endpoint + `${this.$store.state.currentUser.id}` + `/online`)
        .then(res => this.Successful(res))
        .catch(err => this.Failed(err))
      },
      Successful(res) {
        this.online_followings = res.data.data
      },
      Failed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ""
      },
      setQuery(){
        this.canSubmit = true
      },
      search(query) {
        if(!this.canSubmit){
          return
        }
        this.$router.replace({
          name: 'multi',
          params: {
            query: query
          }
        })
        this.query = ''
        this.canSubmit = false
      },
      movePath(link){
        this.$router.push({name: link})
      }
    }
  }
</script>

<style scoped>
  .v-text-field {
    width: 250px;
  }
</style>