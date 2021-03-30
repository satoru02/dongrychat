<template>
  <v-container>
    <v-row class="mb-n2">
      <v-col lg=1><h3 class="ml-3 head-title mt-n1">TV</h3>
      <v-avatar color="blue" class="ml-7" :size="5" />
      </v-col>
      <v-col lg=1><h3 class="ml-3 mt-2 another-head-title">Movie</h3></v-col>

      <v-col lg=9 />
      <v-col lg=1 class="mt-n3">
        <v-switch v-model="switch1" color="orange" inset />
      </v-col>
    </v-row>
    <v-list two-line>
      <v-list-item-group active-class="orange--text" multiple class="list-body">
        <template v-for="(item, index) in items">
          <v-list-item :key="index" @click="enterSpace(item.attributes)">
            <template v-slot:default="{}">
              <div class="mr-4 ranktitle">{{index + 1}}
                <v-icon color="green" class="ml-2" :size="22">mdi-menu-up</v-icon>
              </div>
              <!-- <v-badge color="#f94144" :content='"New"' style="font-weight:bold;" right offset-x="31" offset-y="29"
                overlap> -->
                <v-list-item-avatar size=66 height=66 tile class="rounded-lg">
                  <v-img :src="base_tmdb_img_url + item.attributes.image_path" />
                </v-list-item-avatar>
              <!-- </v-badge> -->
              <v-list-item-content class=ml-4>
                <v-list-item-title class="card-title" v-html="item.attributes.name" />
                <v-list-item-subtitle class="subdiscription mt-1">
                  <!-- Season{{item.attributes.season}}-{{item.attributes.episode}}
                  {{item.attributes.episode_title}} -->
                  Steve johnson
                </v-list-item-subtitle>
              </v-list-item-content>

              <v-list-item-action>
                <div class="subtitle ml-n16">{{item.attributes.season}}</div>
              </v-list-item-action>
              <v-list-item-action>
                <div class="subtitle ml-n6">{{item.attributes.episode}}</div>
              </v-list-item-action>
              <v-list-item-action>
                <div class="subtitle">157人が会話中</div>
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
  const TREND_ENDPOINT = `/api/v1/spaces/trend`;

  export default {
    name: 'TrendTop',
    data() {
      return {
        items: [],
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w500`,
        error: null,
        switch1: false
      }
    },
    created() {
      this.getTrend()
    },
    methods: {
      getTrend() {
        secureAxios.get(TREND_ENDPOINT, {
            params: {
              time: "day",
              record_count: ""
            }
          })
          .then(res => this.getSuccessful(res))
          .catch(err => this.getFailed(err))
      },
      getSuccessful(res) {
        console.log(res)
        this.items = res.data.data
      },
      getFailed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ''
      },
      enterSpace(item) {
        if (item.media === 'tv') {
          this.$router.push({
            name: 'TvSpace',
            params: {
              season_number: item.season,
              episode_number: item.episode,
              name: item.name,
              episode_title: item.episode_title,
              tmdb_tv_id: item.tmdb_tv_id,
              image_path: item.image_path,
              media: item.media,
            }
          })
        } else if (item.media === 'mv') {
          this.$router.push({
            name: 'MvSpace',
            params: {
              value: item.mv_details,
              name: item.mv_name,
              media: item.media,
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
    font-size: 16px;
  }

  .head-title {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 30px;
    color: #000000;
  }

  .another-head-title {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 18px;
    color: #9e9e9e;
  }

  .ranktitle {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 13px;
    font-weight: bold;
    color: #8f8f8f;
  }

  .subtitle {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 9px;
    font-weight: bold;
    color: #484b4d;
  }

  .subdiscription {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 12px;
    font-weight: bold;
    color: #6c757d;
  }

  .side-count {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 14px;
  }
</style>