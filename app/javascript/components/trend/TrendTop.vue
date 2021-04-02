<template>
  <v-container>
    <v-row>
      <v-col md=1 lg=1 xl=1>
        <div :style="switch1 === false ? active : inactive" v-text="tv.header" />
      </v-col>
      <v-col md=1 lg=1 xl=1>
        <div :style="switch1 === true ? active : inactive" v-text="movie.header" />
      </v-col>
      <v-col md=9 lg=9 xl=9 />
      <v-col md=1 lg=1 xl=1>
        <v-switch v-model="switch1" :color="colors.orange" inset :class="switchPosition" />
      </v-col>
    </v-row>

    <v-list two-line>
      <v-list-item-group :active-class="listItemGroup.active" multiple :class="listItemGroup.body">
        <template v-for="(item, index) in items">
          <v-list-item :key="index" @click="enterSpace(item.attributes)">
            <template v-slot:default="{}">
              <div :style="ranking.title" :class="ranking.position">{{index + 1}}
                <v-icon :color="icon.color" :class="icon.position" :size="icon.size" v-text="icon.mdi" />
              </div>
              <!-- <v-badge color="#f94144" :content='"New"' style="font-weight:bold;" right offset-x="31" offset-y="29"
                overlap> -->
              <v-list-item-avatar :size="avatar.size" :height="avatar.height" tile :class="avatar.round">
                <v-img :src="base_tmdb_img_url + item.attributes.image_path" />
              </v-list-item-avatar>
              <!-- </v-badge> -->
              <v-list-item-content :class="listItemContent.position">
                <v-list-item-title :style="listItemTitle.style" v-html="item.attributes.name" />
                <v-list-item-subtitle :style="listItemSubtitle.style" :class="listItemSubtitle.position"
                  v-text="'Steve johnson'">
                  <!-- Season{{item.attributes.season}}-{{item.attributes.episode}}
                  {{item.attributes.episode_title}} -->
                </v-list-item-subtitle>
              </v-list-item-content>
              <v-list-item-action>
                <div :style="listItemAction.style" :class="listItemAction.season_position"
                  v-text="item.attributes.season" />
              </v-list-item-action>
              <v-list-item-action>
                <div :style="listItemAction.style" :class="listItemAction.episode_position"
                  v-text="item.attributes.episode" />
              </v-list-item-action>
              <v-list-item-action>
                <div :style="listItemAction.style" v-text="'157人が会話中'" />
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
  export default {
    name: 'TrendTop',
    data() {
      return {
        TREND_ENDPOINT: `/api/v1/spaces/trend`,
        items: [],
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w500`,
        error: null,
        switch1: false,
        switchPosition: 'mt-1',
        colors: {
          blue: 'blue',
          orange: 'orange'
        },
        query_media: 'tv',
        query_time: {
          hour: 'hour',
          today: 'today',
          week: 'week',
          month: 'month'
        },
        media: {
          tv: 'tv',
          movie: 'mv',
        },
        tv: {
          header: 'TV',
          avatar: 'ml-3',
          pathName: 'TvSpace'
        },
        movie: {
          header: 'MOVIE',
          avatar: 'ml-7',
          pathName: 'MvSpace'
        },
        active: {
          fontFamily: 'Helvetica Neue, sans-serif',
          fontSize: '25px',
          fontWeight: 'bold',
          color: '#000000',
          letterSpacing: '3px'
        },
        inactive: {
          fontFamily: 'Helvetica Neue, sans-serif',
          fontSize: '25px',
          fontWeight: 'bold',
          color: '#8f8f8f',
          letterSpacing: '3px'
        },
        listItemGroup: {
          body: 'list-body',
          active: 'orange--text'
        },
        listItemContent: {
          position: 'ml-4'
        },
        listItemSubtitle: {
          position: 'mt-1',
          season_position: 'ml-n16',
          episode_position: 'ml-n6',
          style: {
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '12px',
            fontWeight: 'bold',
            color: '#6c757d'
          }
        },
        listItemAction: {
          position: 'mt-1',
          style: {
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '9px',
            fontWeight: 'bold',
            color: '#484b4d'
          }
        },
        listItemTitle: {
          style: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '14px',
          }
        },
        ranking: {
          title: {
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '12px',
            fontWeight: 'bold',
            color: '#8f8f8f',
          },
          position: 'mr-4'
        },
        icon: {
          color: 'green',
          position: 'ml-2',
          size: 22,
          mdi: 'mdi-menu-up'
        },
        avatar: {
          size: 66,
          height: 66,
          round: "rounded-lg"
        }
      }
    },
    created() {
      this.getTrend()
    },
    watch: {
      switch1: function () {
        this.items = []
        if (this.switch1 === false) {
          this.query_media = this.media.tv
          this.getTrend()
        } else if (this.switch1 === true) {
          this.query_media = this.media.movie
          this.getTrend()
        }
      }
    },
    methods: {
      getTrend() {
        secureAxios.get(this.TREND_ENDPOINT, {
            params: {
              record_count: "",
              media: this.query_media
            }
          })
          .then(res => this.getSuccessful(res))
          .catch(err => this.getFailed(err))
      },
      getSuccessful(res) {
        this.items = res.data.data
      },
      getFailed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ''
      },
      enterSpace(item) {
        if (item.media === this.media.tv) {
          this.$router.push({
            name: this.tv.pathName,
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
        } else if (item.media === this.media.movie) {
          this.$router.push({
            name: this.movie.pathName,
            params: {
              image_path: item.image_path,
              tmdb_mv_id: item.tmdb_mv_id,
              name: item.name,
              media: item.media,
            }
          })
        }
      }
    }
  }
</script>

<style scoped>
</style>