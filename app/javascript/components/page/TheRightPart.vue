<template>
  <v-container v-if="$vuetify.breakpoint.width > 600" :class="right_part.position">
    <v-row>
      <v-col md=12 lg=12 xl=12>
        <v-text-field v-model="query" @keydown.enter="search(query)" :color="text_field.color"
          prepend-inner-icon="mdi-magnify" dense :class="text_field.round" outlined :max-width="text_field.width"
          :placeholder="text_field.placeholder" />
      </v-col>
    </v-row>
    <v-row :class="profile_part.position">
      <v-col md=12 lg=12 xl=12>
        <v-card :elevation="profile_part.elavation" outlined :width="profile_part.width" :height="profile_part.height"
          :style="profile_part.style" :class="profile_part.round" />
      </v-col>
    </v-row>
    <v-row :class="online_part.position">
      <v-col md=12 lg=12 xl=12>
        <h3 :style="item_title.style" v-text="online_part.title" />
      </v-col>
    </v-row>
    <v-row v-for="(n,index) in 5" :key="index">
      <v-col md=1 lg=1 xl=1>
        <v-avatar :size="avatar.size" :height="avatar.height" :style="avatar.style">
           <img src="https://cdn.vuetifyjs.com/images/john.jpg" alt="John">
        </v-avatar>
      </v-col>
      <v-col md=1 lg=1 xl=1 />
      <v-col md=8 lg=8 xl=8 class="mt-3">
        <h3 :style="name_title.style" v-text="'username'" />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
  export default {
    name: "RightPart",
    data() {
      return {
        query: '',
        right_part: {
          position: 'ml-n2'
        },
        text_field: {
          position: 'mt-n4 ml-n8 mr-3',
          color: '#000000',
          placeholder: '検索',
          round: 'rounded-lg',
          width: 250,
        },
        profile_part: {
          position: 'mt-n3',
          elevation: 0,
          width: 250,
          height: 110,
          round: 'rounded-lg',
          style: {
            backgroundColor: '#ffffff',
          }
        },
        item_title: {
          style: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '20px',
            color: '#011627'
          }
        },
        name_title: {
          style: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '14px',
            color: '#011627'
          }
        },
        online_part: {
          title: 'Online',
          position: 'mt-7'
        },
        avatar: {
          size: 45,
          height: 45,
          style: {
            borderStyle: 'solid',
            borderWidth: '0.14em',
            borderColor: '#3f37c9'
          }
        }
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
      },
    }
  }
</script>

<style scoped>
  .v-text-field {
    width: 250px;
  }
</style>