<template>
  <v-container :class="grid.topPart">
    <h3 :class="grid.header" :style="style.headerPart" v-text="headerCaption" />
    <v-list two-line>
      <v-list-item-group multiple :class="listPart.body">
        <v-list-item class="mt-n2 mb-n2" v-for="(item, index) in items" :key="index" @click="enterSpace(item)">
          <template v-slot:default="{}">
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
          </template>
        </v-list-item>
      </v-list-item-group>
    </v-list>
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
          size: 65,
          height: 65,
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
          chip: 'black',
          notifyBtn: 'red'
        },
        grid: {
          topPart: 'ml-n2 mt-3',
          header: 'mb-5 ml-3',
          listItemSubtitle: 'mt-1',
          listItemAction: 'ml-n16 mt-7 mb-5',
          details: 'mt-n1',
          avatar: 'mr-1',
          notifyBtn: 'mr-1 mt-n4',
          label: 'ml-2'
        },
        style: {
          headerPart: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '22px',
            color: '#011627'
          },
          listItemTitle: {
            fontWeight: 'bold',
            fontFamily: '"Hiragino Kaku Gothic ProN", "Hiragino Sans", "BIZ UDPGothic", Meiryo, sans-serif;',
            fontSize: '14px',
            color: '#000000'
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
            lineHeight: '16px',
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
            fontSize: '11px',
            fontWeight: 'bold',
            color: '#ffffff'
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
      this.checkSignedIn()
      this.createCable()
    },
    methods: {
      checkSignedIn(){
        if (!this.$store.state.signedIn) {
          this.$router.replace('/login')
        }
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