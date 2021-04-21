<template>
  <v-container :class="grid.rightPart">
    <!-- <v-row>
      <v-col md=12 lg=12 xl=12>
        <v-text-field v-model="query" dense background-color="#e7ecef" solo flat @keypress="setQuery()" @keydown.enter="search(query)" :prepend-inner-icon="mdi.magnify"
          :class="textField.round" :max-width="textField.width" :placeholder="textField.placeholder" />
      </v-col>
    </v-row> -->

    <the-profile-part />

    <v-row :class="grid.onlinePart">
      <v-col md=12 lg=12 xl=12>
        <h3 :style="style.online" v-text="onlineTitle" />
      </v-col>
    </v-row>
    <v-row v-for="(n,index) in 5" :key="index">
      <v-col md=1 lg=1 xl=1>
        <v-avatar :size="avatar.size" :height="avatar.height">
          <base-avatar :img="'https://cdn.vuetifyjs.com/images/john.jpg'" />
        </v-avatar>
      </v-col>
      <v-col md=1 lg=1 xl=1 />
      <v-col md=8 lg=8 xl=8 :class="grid.username">
        <h3 :style="style.name" v-text="'username'" />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
  import TheSearchField from './TheSearchField';
  import BaseAvatar from '../Base/BaseAvatar';
  import TheProfilePart from '../Layout/TheProfilePart';

  export default {
    name: "RightPart",
    components: {
      'the-search-field': TheSearchField,
      'base-avatar': BaseAvatar,
      'the-profile-part': TheProfilePart
    },
    data() {
      return {
        query: '',
        canSubmit: false,
        mdi: {
          magnify: 'mdi-magnify'
        },
        style: {
          name: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '14px',
            color: '#011627'
          },
          online: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '20px',
            color: '#011627'
          }
        },
        grid: {
          rightPart: 'ml-2 mt-n2',
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
    methods: {
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
      }
    }
  }
</script>

<style scoped>
  .v-text-field {
    width: 250px;
  }
</style>