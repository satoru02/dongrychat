<template>
  <v-row>
    <v-col lg=3 />
    <v-col cols=12 lg=6>
      <v-list two-line>
        <v-list-item-group active-class="orange--text" multiple class="list-body">
          <template v-for="(item, index) in items">
            <v-list-item :key="index" @click="enterSpace(item)">
              <template v-slot:default="{ active }">
                <v-badge color="#f94144" :content='34' style="font-weight:bold;" right offset-x="31" offset-y="29" overlap>
                <v-list-item-avatar size=63 height=65 tile class="rounded-lg">
                  <v-img :src="base_tmdb_img_url + item.attributes.image_path" />
                </v-list-item-avatar>
                </v-badge>
                <v-list-item-content class=ml-3>
                  <v-list-item-title class="card-title" v-html="item.attributes.name" />
                  <v-list-item-subtitle v-text="item.attributes.episode_title" class="subtitle" />
                </v-list-item-content>
                <v-list-item-action>
                  <v-icon v-if="!active" color="grey lighten-1">
                  mdi-chevron-right
                  </v-icon>
                </v-list-item-action>
              </template>
            </v-list-item>
          </template>
        </v-list-item-group>
      </v-list>
    </v-col>
  </v-row>
</template>

<script>
　import { secureAxios } from '../../backend/axios';
  const SPACES_ENDPOINT = `/api/v1/spaces`;

  export default {
    name: 'TopPage',
    data() {
      return {
        items: [],
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w500`,
        error: null,
        // this data trigger means subscription.
        trigger: 'sb'
      }
    },
    created(){
      this.getSubscription()
    },
    methods:{
      getSubscription(){
        secureAxios.get(SPACES_ENDPOINT, { params: {
          user_id: this.$store.state.currentUser.data.id
        }})
        .then(res => this.getSuccessful(res))
        .catch(err => this.getFailed(err))
      },
      getSuccessful(res){
        this.items = res.data.data
      },
      getFailed(err){
        this.error = (err.response && err.response.data && err.response.data.error) || ''
      },
      enterSpace(item){
        if(item.attributes.media === 'tv'){
          this.$router.push({name: 'subscribedTvSpace', params: {
            space_id: item.attributes.id,
        }})
        } else if(item.attributes.media === 'mv'){
          this.$router.push({name: 'subscribedMvSpace', params: {
            name: item.attributes.name,
            space_id: item.attributes.id,
            from: this.trigger
        }})
        }
      }
    }
  }
</script>

<style scoped>
  .list-body{
    background-color:#fafaf9;
  }

  .card-title {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 13px;
  }

  .subtitle {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 10px;
    font-weight: bold;
    color: rgb(235, 232, 232);
  }

  .side-count {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 14px;
  }
</style>