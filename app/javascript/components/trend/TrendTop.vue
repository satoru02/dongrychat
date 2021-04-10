<template>
  <v-container :class="trend_header.position" :key="componentKey">
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
    <v-list two-line :class="trend_part.position">
      <v-list-item-group :active-class="listItemGroup.active" multiple :class="listItemGroup.body">
        <template v-for="(item, index) in items">
          <v-list-item :key="index" @click="enterSpace(item.attributes)">
            <template v-slot:default="{}">
              <div :style="ranking.title" :class="ranking.position">{{index + 1}}
                <v-icon :color="icon.color" :class="icon.position" :size="icon.size" v-text="icon.mdi" />
              </div>
              <v-list-item-avatar :size="avatar.size" :height="avatar.height" tile :class="avatar.round">
                <v-img :src="base_tmdb_img_url + item.attributes.image_path" />
              </v-list-item-avatar>
              <v-list-item-content :class="listItemContent.position">
                <v-list-item-title :style="listItemTitle.style">
                  {{item.attributes.name}}
                </v-list-item-title>
                <v-list-item-subtitle :style="listItemSubtitle.style" :class="listItemSubtitle.position"
                >
                <v-chip outlined v-if="item.attributes.media === 'tv'"
                  x-small label color="black" text-color="black">
                  シーズン{{item.attributes.season}} 第{{item.attributes.episode}}話
                  {{item.attributes.episode_title}}</v-chip>
                </v-list-item-subtitle>
              </v-list-item-content>
              <v-list-item-action class="mr-n6" v-if="item.attributes.users.length > 0">
                <v-badge class="mt-1" dot color="red"></v-badge>
              </v-list-item-action>
              <v-list-item-action v-if="item.attributes.users.length > 0">
                <div :style="listItemAction.style" v-text="item.attributes.users.length" />
              </v-list-item-action>
            </template>
          </v-list-item>
        </template>
      </v-list-item-group>
    </v-list>
    <infinite-loading spinner="circles" @infinite="infiniteHandler">
      <span slot="no-more" />
    </infinite-loading>
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
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w500`,
        trend_endpoint: `/api/v1/spaces/trend`,
        items: [],
        switch1: false,
        page: 1,
        pageSize: 10,
        error: '',
        componentKey: 0,
        // css objects ------------------------------------------
        switchPosition: 'mt-3 ml-n4',
        trend_header: {
          position: 'ml-n3 mt-n2'
        },
        trend_part: {
          position: ''
        },
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
            fontSize: '13px',
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
          size: 55,
          height: 55,
          round: "rounded-lg"
        }
        // ------------------------------------------
      }
    },
    watch: {
      switch1: function () {
        this.page = 1
        this.items = []
        if (this.switch1 === false) {
          this.query_media = this.media.tv
          this.forceRerender()
        } else if (this.switch1 === true) {
          this.query_media = this.media.movie
          this.forceRerender()
        }
      }
    },
    methods: {
      forceRerender() {
        this.componentKey += 1
      },
      infiniteHandler($state) {
        setTimeout(() => {
          secureAxios.get(this.trend_endpoint, {
              params: {
                page: this.page,
                per_page: this.pageSize,
                media: this.query_media
              }
            })
            .then(res => {
              if (res.data.data.length) {
                this.page += 1,
                  this.items.push(...res.data.data)
                $state.loaded()
              } else {
                $state.complete();
              }
            })
        }, 150);
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