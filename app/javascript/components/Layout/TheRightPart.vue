<template>
  <v-container :class="grid.rightPart">
    <v-row>
      <v-col md=12 lg=12 xl=12>
        <v-text-field v-model="query" @keydown.enter="search(query)" :prepend-inner-icon="mdi.magnify" dense
          :class="textField.round" outlined :max-width="textField.width" :placeholder="textField.placeholder" />
        <!-- <the-search-field /> -->
      </v-col>
    </v-row>

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
          rightPart: 'ml-n6',
          onlinePart: 'mt-7',
          username: 'mt-3'
        },
        textField: {
          placeholder: '検索',
          round: 'rounded-lg',
          width: 250,
        },
        onlineTitle: 'Online',
        avatar: {
          size: 45,
          height: 45,
        },
        profile: {
          size: 55,
          height: 55,
        },
      }
    },
    methods: {
      search(query) {
        this.$router.replace({
          name: 'multi',
          params: {
            query: query
          }
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