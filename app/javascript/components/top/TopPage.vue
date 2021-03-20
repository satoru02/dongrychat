<template>
  <v-container>
    <h1 class="ml-7 mb-2 head-title">Home</h1>
    <v-list two-line>
      <v-list-item-group active-class="orange--text" multiple class="list-body">
        <template v-for="(item, index) in items">
          <v-list-item :key="index" @click="enterSpace(item)">
            <template v-slot:default="{ active }">
              <v-badge color="#f94144" :content='34' style="font-weight:bold;" right offset-x="31" offset-y="29"
                overlap>
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
  </v-container>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios';
  const SPACES_ENDPOINT = `/api/v1/spaces`;

  export default {
    name: 'TopPage',
    data() {
      return {
        items: [],
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w500`,
        error: null,
      }
    },
    channels: {
      TopsubChannel: {
        connected() {},
        rejected() {},
        received(data) {
          console.log(data)
          // if(this.items.filter(item => item.id === data["space_id"])){
          // }
        },
        disconnected() {}
      }
    },
    created() {
      this.getSubscription()
    },
    methods: {
      getSubscription() {
        secureAxios.get(SPACES_ENDPOINT, {
            params: {
              user_id: this.$store.state.currentUser.id
            }
          })
          .then(res => this.createCable(res.data.data))
          .catch(err => this.getFailed(err))
      },
      createCable(spaces) {
        this.items = spaces
        this.$cable.subscribe({
          channel: 'TopsubChannel',
        })
      },
      getFailed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ''
      },
      enterSpace(item) {
        if (item.attributes.media === 'tv') {
          this.$router.push({
            name: 'subscribedTvSpace',
            params: {
              space_id: item.attributes.id,
            }
          })
        } else if (item.attributes.media === 'mv') {
          this.$router.push({
            name: 'subscribedMvSpace',
            params: {
              space_id: item.attributes.id,
            }
          })
        }
      }
    }
  }
</script>

<style scoped>
  .list-body {
    background-color: #ffffff;
  }

  .card-title {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 17px;
    color: #000000;
  }

  .head-title {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 32px;
    color: #000000;
  }

  .subtitle {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 10px;
    font-weight: bold;
    color: rgb(235, 232, 232);
  }
</style>