<template>
  <v-container :class="grid.header" :key="componentKey">
    <v-row class="ml-2">
      <v-col md=1 lg=1 xl=1>
        <div :style="switch1 === false ? style.active : style.inactive" v-text="tv.header" />
      </v-col>
      <v-col md=1 lg=1 xl=1>
        <div :style="switch1 === true ? style.active : style.inactive" v-text="movie.header" />
      </v-col>
      <v-col md=9 lg=9 xl=9 />
      <v-col md=1 lg=1 xl=1>
        <v-switch v-model="switch1" :color="colors.switchButton" inset :class="grid.switch" />
      </v-col>
    </v-row>
    <v-list two-line>
      <v-list-item-group :active-class="colors.listItemGroupActive" :class="grid.listItemGroup" multiple>
        <template v-for="(item, index) in items">
          <v-list-item :key="index" @click="enterSpace(item.attributes)">
            <template v-slot:default="{}">
              <div :style="style.ranking" :class="grid.ranking">{{index + 1}}
                <v-icon :color="colors.rankIcon" :class="grid.icon" :size="icon.size" v-text="icon.mdi" />
              </div>
              <v-list-item-avatar :size="avatar.size" :height="avatar.height" tile :class="avatar.round">
                <base-image :img="base_tmdb_img_url + item.attributes.image_path" :height="avatar.height" />
              </v-list-item-avatar>
              <v-list-item-content :class="grid.listItemContent">
                <v-list-item-title :style="style.listItemTitle" v-text="item.attributes.name" />
                <v-list-item-subtitle :style="style.listItemSubtitle" :class="grid.listItemSubtitle">
                  <base-label :x_small="true" v-if="item.attributes.media === media.tv" :color="colors.chip" :text-color="colors.chip"
                    :season="item.attributes.season" :episode="item.attributes.episode"
                    :title="item.attributes.episode_title" />
                </v-list-item-subtitle>
              </v-list-item-content>
              <v-list-item-action :class="grid.notifyBadge" v-if="item.attributes.users.length > 0">
                <v-badge :class="grid.notifyDot" dot :color="colors.notifyBadge" />
              </v-list-item-action>
              <v-list-item-action v-if="item.attributes.users.length > 0">
                <div :style="style.listItemAction" v-text="item.attributes.users.length" />
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
  import BaseImage from '../Base/BaseImage';
  import BaseLabel from '../Base/BaseLabel';

  export default {
    name: 'ChartTop',
    components: {
      'base-image': BaseImage,
      'base-label': BaseLabel
    },
    data() {
      return {
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w500`,
        trend_endpoint: `/api/v1/spaces/trend`,
        items: [],
        switch1: false,
        page: 1,
        pageSize: 10,
        componentKey: 0,
        query_media: 'tv',
        error: '',
        avatar: {
          size: 55,
          height: 55,
          round: "rounded-lg"
        },
        icon: {
          size: 22,
          mdi: 'mdi-menu-up'
        },
        media: {
          tv: 'tv',
          movie: 'mv',
        },
        tv: {
          header: 'TV',
          pathName: 'TvSpace'
        },
        movie: {
          header: 'MOVIE',
          pathName: 'MvSpace'
        },
        colors: {
          switchButton: 'orange',
          rankIcon: 'green',
          chip: 'black',
          notifyBadge: 'red',
          listItemGroupActive: 'orange'
        },
        grid: {
          switch: 'mt-3 ml-n4',
          header: 'mt-n2 ml-n2',
          ranking: 'mr-4',
          icon: 'ml-2',
          listItemContent: 'ml-4',
          listItemAction: 'mt-1',
          listItemSubtitle: 'mt-1',
          listItemGroup: 'list-body mt-n6',
          notifyBadge: 'mr-n6',
          notifyDot: 'mt-1'
        },
        style: {
          ranking: {
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '12px',
            fontWeight: 'bold',
            color: '#8f8f8f',
          },
          listItemTitle: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '14px',
          },
          listItemAction: {
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '13px',
            fontWeight: 'bold',
            color: '#484b4d'
          },
          listItemSubtitle: {
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '12px',
            fontWeight: 'bold',
            color: '#6c757d'
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
          }
        }
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