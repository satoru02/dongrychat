<template>
  <v-container>
    <h1 :class="header_part.position" :style="header_part.style" v-text="header_part.caption" />
    <v-list two-line>
      <v-list-item-group :active-class="list_part.active" multiple :class="list_part.body">
        <template v-for="(item, index) in items">
          <v-list-item :key="index" @click="enterSpace(item)">
            <template v-slot:default="{}">
              <v-badge v-if="item.attributes.unread_comments > 0" :color="list_part.badge.color"
                :content='item.attributes.unread_comments' :style="list_part.badge.style" right
                :offset-x="list_part.badge.x" :offset-y="list_part.badge.y" overlap>
                <v-list-item-avatar :size="list_avatar.size" :height="list_avatar.height" tile
                  :class="list_avatar.round">
                  <v-img :src="base_tmdb_img_url + item.attributes.image_path" />
                </v-list-item-avatar>
              </v-badge>
              <v-list-item-avatar v-else :size="list_avatar.size" :height="list_avatar.height" tile
                :class="list_avatar.round">
                <v-img :src="base_tmdb_img_url + item.attributes.image_path" />
              </v-list-item-avatar>
              <v-list-item-content :class="list_item_content.position">
                <v-list-item-title :style="list_item_title.style" v-text="item.attributes.name" />
                <v-list-item-subtitle :style="list_item_subtitle.style" :class="list_item_subtitle.position"
                  v-text="'Season' + item.attributes.season + '-' + item.attributes.episode + '' + item.attributes.episode_title" />
              </v-list-item-content>
              <v-list-item-action :class="list_item_action.position">
                <!-- <div class="comment">受信したメッセージ・・・</div> -->
                <!-- <v-avatar class="ml-n16" color="green" :size="24" v-if="item.attributes.unread_comments > 0">
                   <span class="white--text font-weight-bold subtitle">{{item.attributes.unread_comments}}</span></v-avatar> -->
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
  import { secureAxios } from '../../backend/axios';
  import InfiniteLoading from 'vue-infinite-loading';

  export default {
    name: 'TopPage',
    components: {
      'infinite-loading': InfiniteLoading,
    },
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
        error: '',
        // for css------------------------------------------
        header_part: {
          position: 'ml-3 mt-n4 mb-1',
          caption: 'HOME',
          style: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '28px',
            color: '#000000'
          }
        },
        list_part: {
          active: 'orange--text',
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
          round: 'rounded-lg'
        },
        list_item_content: {
          position: 'ml-1'
        },
        list_item_title: {
          style: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '14px',
            color: '#000000'
          }
        },
        list_item_subtitle: {
          position: 'mt-1',
          style: {
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '12px',
            fontWeight: 'bold',
            color: '#6c757d'
          }
        },
        list_item_action: {
          position: 'ml-n16'
        },
        page: 1,
        pageSize: 10,
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
              item.attributes.unread_comments += 1
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
      infiniteHandler($state){
        setTimeout(() => {
        secureAxios.get(this.spaces_endpoint, {
        params: {
          page: this.page,
          per_page: this.pageSize
        }})
          .then(res => {
            if (res.data.data.length){
              this.page += 1,
              this.items.push(...res.data.data)
              $state.loaded()
            } else {
              $state.complete();
            }
          })
        }, 300);
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
      }
    }
  }
</script>

<style scoped>
</style>