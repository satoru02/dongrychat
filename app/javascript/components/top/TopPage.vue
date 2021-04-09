<template>
  <v-container :class="top_part.position">
    <h3 :class="header_part.position" :style="header_part.style" v-text="header_part.caption" />
    <v-list two-line :class="list_part.position">
      <v-list-item-group multiple :class="list_part.body">
        <v-list-item v-for="(item, index) in items" :key="index" @click="enterSpace(item)">
          <template v-slot:default="{ }">
            <!-- <v-list-item-avatar
              :style="item.attributes.unconfirmed_comments > 0 ? list_avatar.style : '' " :size="list_avatar.size" :height="list_avatar.height" tile :class="list_avatar.round">
              <v-img :src="base_tmdb_img_url + item.attributes.image_path" />
            </v-list-item-avatar> -->
            <v-list-item-avatar
              :size="list_avatar.size" :height="list_avatar.height" tile :class="list_avatar.round">
              <v-img :src="base_tmdb_img_url + item.attributes.image_path" />
            </v-list-item-avatar>
            <v-list-item-content :class="list_item_content.position">
              <v-list-item-title
                :style="list_item_title.style"
                >
                {{item.attributes.name}}
                <v-chip outlined v-if="item.attributes.media === 'tv'" class="ml-2" x-small color="black" text-color="black">
                  シーズン{{item.attributes.season}} 第{{item.attributes.episode}}話
                  {{item.attributes.episode_title}}</v-chip>
              </v-list-item-title>
              <v-list-item-subtitle :style="list_item_subtitle.style" :class="list_item_subtitle.position">
                <!-- <v-avatar :class="avatar.position" :size="avatar.size" :height="avatar.height">
                  <img :src="item.attributes.latest_comment.data.attributes.user.data.attributes.avatar_url">
                </v-avatar> -->
                {{item.attributes.latest_comment.content}}
              </v-list-item-subtitle>
            </v-list-item-content>
            <v-list-item-action :class="list_item_action.position">
              <v-list-item-action-text :style="list_time.style">{{formalizeTime(item.attributes.latest_comment.created_at)}}</v-list-item-action-text>
              <v-avatar v-if="item.attributes.unconfirmed_comments > 0" :class="notify_btn.position"
                :color="notify_btn.color" :size="notify_btn.size">
                <span :style="notify_text.style" v-text="item.attributes.unconfirmed_comments" />
              </v-avatar>
            </v-list-item-action>
          </template>
        </v-list-item>
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
  import moment from 'moment';

  export default {
    name: 'TopPage',
    data() {
      return {
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w500`,
        spaces_endpoint: `/api/v1/spaces`,
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
        // css objects ------------------------------------------
        top_part: {
          position: 'ml-n2'
        },
        header_part: {
          position: 'mb-5 ml-3',
          caption: 'Space',
          style: {
            fontWeight: 'bold',
            // fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '22px',
            color: '#011627'
          }
        },
        list_part: {
          active: 'orange--text',
          position: '',
          body: 'list-body',
          badge: {
            color: 'red',
            x: 31,
            y: 29,
            style: {
              fontWeight: 'bold'
            }
          }
        },
        list_avatar: {
          size: 60,
          height: 60,
          round: 'rounded-lg',
          style: {
            borderStyle: 'solid',
            borderWidth: '0.13em',
            borderColor: '#ef233c'
          }
        },
        list_item_content: {
          position: ''
        },
        list_item_title: {
          style: {
            fontWeight: 'bold',
            // fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '14px',
            color: '#000000'
          }
        },
        details: {
          position: 'mt-n1',
          style: {
            fontWeight: 'bold',
            fontFamily: '"Hiragino Kaku Gothic ProN", "Hiragino Sans", "BIZ UDPGothic", Meiryo, sans-serif;',
            fontSize: '10px',
            color: '#ffffff',
            lineHeight: '17px',
            maxWidth: "450px",
          }
        },
        list_item_subtitle: {
          position: 'mt-1',
          style: {
            fontWeight: 'bold',
            fontFamily: '"Hiragino Kaku Gothic ProN", "Hiragino Sans", "BIZ UDPGothic", Meiryo, sans-serif;',
            fontSize: '11px',
            color: '#6c757d',
            lineHeight: '16px',
            maxWidth: "450px",
          }
        },
        list_time: {
          style: {
            // fontWeight: 'bold',
            fontFamily: '"Hiragino Kaku Gothic ProN", "Hiragino Sans", "BIZ UDPGothic", Meiryo, sans-serif;',
            fontSize: '6px',
            color: '#adb5bd',
          }

        },
        list_count: {
          style: {
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '13px',
            fontWeight: 'bold',
            color: '#454955'
          }
        },
        list_item_action: {
          position: 'ml-n16 mt-7 mb-5'
        },
        avatar: {
          position: 'mr-1',
          size: 20,
          height: 20,
        },
        notify_btn: {
          position: 'mr-1 mt-n4',
          color: 'red',
          size: 22
        },
        notify_text: {
          style: {
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '11px',
            fontWeight: 'bold',
            color: '#ffffff'
          }
        }
        // ------------------------------------------
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
      getFailed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ''
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

<style scoped>
</style>