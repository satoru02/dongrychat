<template>
  <v-container :class="grid.topPart">
    <h3 :class="grid.header" :style="style.headerPart" v-text="headerCaption" />

  <v-hover v-slot="{ hover }" v-for="(item, index) in items" :key="index">
    <v-card @click="enterSpace(item)"
    :style="hover ? 'background-color: #1a212d;' : 'background-color: #161b22;'" :elevation='hover ? 15: 0'
      class="rounded-lg mb-8" height="108px">
      <v-row>
        <v-col lg=1 class="ml-5">
          <v-avatar :size="listAvatar.size" :height="listAvatar.height" tile :class="listAvatar.round">
            <v-img :src="base_tmdb_img_url + item.attributes.image_path" />
          </v-avatar>
        </v-col>
        <v-col lg=10>
          <v-row dense>
            <v-col lg=1></v-col>
            <v-col lg=10 :style="style.listItemTitle" class="ml-n5">
              {{item.attributes.name}}
              <base-label :small="true" :class="grid.label" :outlined="true" :label="true"
                v-if="item.attributes.media === media.tv" :color="'blue'" :text-color="colors.chip"
                :season="item.attributes.season" :episode="item.attributes.episode"
                :title="item.attributes.episode_title" />
              <v-chip :class="grid.label" v-if="item.attributes.media === media.movie" small outlined label :color="'yellow'" :style="style.movieTitle"
            v-text="'Movie'" />
            </v-col>
          </v-row>
          <v-row>
            <v-col lg=10 />
            <v-col lg=1 class="ml-10">
              <v-badge v-if="item.attributes.unconfirmed_comments > 0" dot green />
            </v-col>
            <v-col lg=1 class="mt-n3 ml-n10" :style="style.notifyText">
              {{item.attributes.unconfirmed_comment}}
            </v-col>
          </v-row>
          <v-row class="mt-n6">
            <!-- <v-col lg=1 /> -->
            <v-col lg=1>
              <v-avatar :size="'28'" :height="'28'" tile :class="'ml-10 rounded-lg'">
                <v-img :src="'https://cdn.vuetifyjs.com/images/john.jpg'" />
              </v-avatar>
            </v-col>
            <v-col lg=10 :style="style.username" class="ml-6 mt-n1">
              <v-row>
                <v-col lg=12>
                  satoru0021
                </v-col>
              </v-row>
              <v-row class="mt-n6 ml-n6">
                <v-col lg=12 v-if="item.attributes.latest_comment !== null" :style="style.listItemSubtitle"
                  :class="grid.listItemSubtitle">
                  {{item.attributes.latest_comment.content}}
                </v-col>
              </v-row>
            </v-col>
          </v-row>
        </v-col>
      </v-row>
    </v-card>
    </v-hover>

    <!-- <v-list two-line style="background-color: #0e0e10;">
      <v-list-item-group multiple :class="listPart.body">
        <v-list-item class="" v-for="(item, index) in items" :key="index" @click="enterSpace(item)">
            <v-list-item-avatar :size="listAvatar.size" :height="listAvatar.height" tile :class="listAvatar.round">
              <v-img :src="base_tmdb_img_url + item.attributes.image_path" />
            </v-list-item-avatar>
            <v-list-item-content>
              <v-list-item-title :style="style.listItemTitle">
                {{item.attributes.name}}
                <base-label :x_small="true" :class="grid.label" v-if="item.attributes.media === media.tv" :color="colors.chip"
                  :text-color="colors.chip" :season="item.attributes.season" :episode="item.attributes.episode"
                  :title="item.attributes.episode_title" />
              </v-list-item-title>
              <v-list-item-subtitle v-if="item.attributes.latest_comment !== null" :style="style.listItemSubtitle"
                :class="grid.listItemSubtitle" v-text="item.attributes.latest_comment.content" />
            </v-list-item-content>
            <v-list-item-action :class="grid.listItemAction">
              <v-list-item-action-text v-if="item.attributes.latest_comment !== null" :style="style.listTime"
                v-text="formalizeTime(item.attributes.latest_comment.created_at)" />
              <v-avatar v-if="item.attributes.unconfirmed_comments > 0" :class="grid.notifyBtn"
                :color="colors.notifyBtn" :size="notify_btn.size">
                <span :style="style.notifyText" v-text="item.attributes.unconfirmed_comments" />
              </v-avatar>
            </v-list-item-action>
        </v-list-item>
                <v-divider />
      </v-list-item-group>
    </v-list> -->

    <base-loader :handler="infiniteHandler" :text="loaderText" />
  </v-container>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios';
  import moment from 'moment';
  import BaseImage from '../Base/BaseImage';
  import BaseLabel from '../Base/BaseLabel';
  import BaseInfiniteLoader from '../Base/BaseInfiniteLoader';

  export default {
    name: 'HomeTop',
    components: {
      'base-image': BaseImage,
      'base-label': BaseLabel,
      'base-loader': BaseInfiniteLoader
    },
    data() {
      return {
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w500`,
        spaces_endpoint: `/api/v1/spaces`,
        loaderText: '気になるドラマのチャットに参加してみよう！',
        media: {
          tv: 'tv',
          movie: 'mv'
        },
        space: {
          tv: 'subscribedTvSpace',
          movie: 'subscribedMvSpace'
        },
        items: [],
        page: 1,
        pageSize: 10,
        error: '',
        headerCaption: 'Home',
        listPart: {
          body: 'list-body mt-n5',
        },
        listAvatar: {
          size: 85,
          height: 85,
          round: 'rounded-lg',
        },
        avatar: {
          size: 30,
          height: 30,
        },
        notify_btn: {
          color: 'red',
          size: 22
        },
        colors: {
          chip: '#ffffff',
          notifyBtn: 'red'
        },
        grid: {
          topPart: 'ml-16 mt-n6',
          header: 'mb-8 ml-1',
          listItemSubtitle: 'mt-1 ml-3',
          listItemAction: 'ml-n16 mt-7 mb-5',
          details: 'mt-n1',
          avatar: 'mr-1',
          notifyBtn: 'mr-1 mt-n4 ml-16',
          label: 'ml-2'
        },
        style: {
          headerPart: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '22px',
            color: '#ced4da'
          },
          listItemTitle: {
            fontWeight: 'bold',
            fontFamily: '"Hiragino Kaku Gothic ProN", "Hiragino Sans", "BIZ UDPGothic", Meiryo, sans-serif;',
            fontSize: '14px',
            color: '#ced4da'
          },
          details: {
            fontWeight: 'bold',
            fontFamily: '"Hiragino Kaku Gothic ProN", "Hiragino Sans", "BIZ UDPGothic", Meiryo, sans-serif;',
            fontSize: '10px',
            color: '#ffffff',
            lineHeight: '17px',
            maxWidth: "450px",
          },
          listItemSubtitle: {
            fontWeight: 'bold',
            fontFamily: '"Hiragino Kaku Gothic ProN", "Hiragino Sans", "BIZ UDPGothic", Meiryo, sans-serif;',
            fontSize: '11px',
            color: '#6c757d',
            lineHeight: 'px',
            maxWidth: "950px",
          },
          username: {
            fontWeight: 'bold',
            fontFamily: '"Hiragino Kaku Gothic ProN", "Hiragino Sans", "BIZ UDPGothic", Meiryo, sans-serif;',
            fontSize: '6px',
            color: '#ffffff',
            maxWidth: "450px",
          },
          listTime: {
            fontFamily: '"Hiragino Kaku Gothic ProN", "Hiragino Sans", "BIZ UDPGothic", Meiryo, sans-serif;',
            fontSize: '6px',
            color: '#adb5bd',
          },
          listCount: {
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '13px',
            fontWeight: 'bold',
            color: '#454955'
          },
          notifyText: {
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '13px',
            fontWeight: 'bold',
            color: '#ffffff'
          },
          movieTitle: {
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '10px',
            fontWeight: 'bold',
          }
        }
      }
    },
    channels: {
      TopsubChannel: {
        connected() {},
        rejected() {},
        received(data) {
          this.items.filter((item) => {
            if ((item.attributes.id === data["space_id"]) && (this.$store.state.currentUser.id != data[
                "user_id"])) {
              item.attributes.unconfirmed_comments += 1
            }
          });
        },
        disconnected() {}
      }
    },
    created() {
      this.createCable()
    },
    methods: {
      track() {
        this.$gtag.time({
            'name': 'load',
            'value': 3549,
            'event_category': 'JS Dependencies'
          }),
          this.$gtag.pageview({
            page_path: '/home'
          })
      },
      createCable() {
        this.$cable.subscribe({
          channel: 'TopsubChannel',
        })
      },
      infiniteHandler($state) {
        setTimeout(() => {
          secureAxios.get(this.spaces_endpoint, {
              params: {
                page: this.page,
                per_page: this.pageSize
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
        }, 0);
      },
      enterSpace(item) {
        if (item.attributes.media === this.media.tv) {
          this.$router.push({
            name: this.space.tv,
            params: {
              space_id: item.attributes.id,
            }
          })
        } else if (item.attributes.media === this.media.movie) {
          this.$router.push({
            name: this.space.movie,
            params: {
              space_id: item.attributes.id,
            }
          })
        }
      },
      formalizeTime(time) {
        return moment(time).format("hh:mm")
      },
    }
  }
</script>