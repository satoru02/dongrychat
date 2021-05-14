<template>
  <v-container>
    <sub-header class="mb-n2 mt-1">
      <template v-slot:home_header="subHeaderProps">
        <h3 :style="style.headerPart">{{subHeaderProps.sub_header}}</h3>
      </template>
    </sub-header>
    <v-divider class="mt-n6 mb-4" />
    <v-hover v-slot="{ hover }" v-for="(item, index) in items" :key="index">
      <v-card outlined class="rounded-lg mb-5" :style="hover ? card.hoverStyle : card.unhoverStyle" @click="enterSpace(item)"
        :elevation='hover ? 0 : 0' :height="'95'">
        <v-row class=mt-n1>
          <v-col cols=1 sm=1 md=1 lg=1 xl=1 class="ml-5">
            <v-avatar class="rounded-lg" :size="listAvatar.size" :height="listAvatar.height">
              <v-img :src="base_tmdb_img_url + item.attributes.image_path" />
            </v-avatar>
          </v-col>
          <v-col cols=10 sm=10 md=10 lg=10 xl=10 class="ml-1 mt-n1">
            <v-row>
              <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
              <v-col cols=10 sm=10 md=10 lg=10 xl=10
              :class="$vuetify.breakpoint.width > 600 ? 'ml-n5 mt-1' : 'mt-1 ml-6'"
              :style="style.name">
                <base-label :x_small="true" :outlined="false" :label="true" v-if="item.attributes.media === media.tv"
                  color="#016aff" :season="item.attributes.season"
                  :episode="item.attributes.episode" :title="item.attributes.episode_title" />
                <v-chip :style="style.movieLabel" v-if="item.attributes.media === media.movie" x-small label
                  color="yellow" v-text="text.movie" />
              </v-col>
            </v-row>
            <v-row>
              <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
              <v-col cols=9 sm=9 md=9 lg=9 xl=9
               :class="$vuetify.breakpoint.width > 600 ? 'ml-n5 mt-n3' : 'mt-n3 ml-6'"
              :style="style.name">
                {{item.attributes.name}}
              </v-col>
              <!-- <v-col lg=3 class="mt-n4">
                <v-avatar size="21">
                  <v-img src="https://cdn.vuetifyjs.com/images/john.jpg" />
                </v-avatar>
                <v-avatar size="21" class="ml-n2">
                  <v-img src="https://avatars0.githubusercontent.com/u/9064066?v=4&s=460" />
                </v-avatar>
                <v-avatar size="21" class="ml-n2" color="red">
                  <v-img src="https://cdn.vuetifyjs.com/images/john.jpg" />
                </v-avatar>
                <v-avatar size="21" class="ml-n2" color="green">
                  <v-img src="https://avatars0.githubusercontent.com/u/9064066?v=4&s=460" />
                </v-avatar>
              </v-col> -->
              <v-col cols=1 sm=1 md=1 lg=1 xl=1 class="ml-14">
                <v-badge v-if="item.attributes.unconfirmed_comments > 0" dot />
              </v-col>
              <v-col cols=1 sm=1 md=1 lg=1 xl=1 class="mt-n3 ml-n10" :style="style.notifyText"
                v-if="item.attributes.unconfirmed_comments > 0">
                {{item.attributes.unconfirmed_comments}}
              </v-col>
            </v-row>
            <v-row :class="$vuetify.breakpoint.width > 600 ? 'mt-n4' : 'mt-n16'" >
              <v-col cols=1 sm=1 md=1 lg=11 xl=1 class=ml-6 :style="style.comment">
              <v-avatar size="20" class="mt-n1 ml-1">
                <v-img src="https://cdn.vuetifyjs.com/images/john.jpg" />
               </v-avatar>
               <span class="ml-1">
                  {{item.attributes.latest_comment.content}}
               </span>
              </v-col>
              <!-- <v-col cols=10 sm=11 md=11 lg=10 xl=11
              :class="$vuetify.breakpoint.width > 600 ? 'ml-n5' : 'ml-15'"
               v-if="item.attributes.latest_comment !== null">
                <div :style="style.comment">{{item.attributes.latest_comment.content}}</div>
              </v-col> -->
            </v-row>
          </v-col>
        </v-row>
      </v-card>
    </v-hover>
    <base-loader :handler="infiniteHandler" :text="text.loading" />
  </v-container>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios';
  import moment from 'moment';

  import BaseLabel from '../Base/BaseLabel';
  import BaseInfiniteLoader from '../Base/BaseInfiniteLoader';
  import TheSubHeader from '../Layout/TheSubHeader';

  export default {
    name: 'HomeTop',
    components: {
      'base-label': BaseLabel,
      'base-loader': BaseInfiniteLoader,
      'sub-header': TheSubHeader
    },
    data() {
      return {
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w500`,
        spaces_endpoint: `/api/v1/spaces`,
        items: [],
        page: 1,
        pageSize: 10,
        error: '',
        media: {
          tv: 'tv',
          movie: 'mv'
        },
        space: {
          tv: 'subscribedTvSpace',
          movie: 'subscribedMvSpace'
        },
        text: {
          home: 'ホーム',
          movie: 'Movie',
          loading: '気になるドラマのチャットに参加してみよう！'
        },
        listAvatar: {
          size: 77,
          height: 77,
        },
        avatar: {
          size: 28,
          height: 28,
        },
        notify_btn: {
          color: 'red',
          size: 22
        },
        card: {
          height: '90px',
          hoverStyle: {
            backgroundColor: '#f8f9fa'
          },
          unhoverStyle: {
            backgroundColor: '#ffffff'
          }
        },
        style: {
          headerPart: {
            fontWeight: 'bold',
            fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
            fontSize: '19px',
            color: '#000000'
          },
          name: {
            fontWeight: 'bold',
            fontFamily: '"Hiragino Kaku Gothic ProN", "Hiragino Sans", "BIZ UDPGothic", Meiryo, sans-serif;',
            fontSize: '15px',
            color: '#111111'
          },
          comment: {
            // fontWeight: 'bold',
            fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
            fontSize: '12px',
            color: '#011627',
            height: '33px',
            maxHeight: '33px',
            overflowY: 'auto'
          },
          notifyText: {
            fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
            fontSize: '13px',
            fontWeight: 'bold',
            color: '#ffffff'
          },
          movieLabel: {
            fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
            fontSize: '10px',
            // fontWeight: 'bold',
            color: '#111111'
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

<style scoped>
  .theme--light.v-divider {
    border-color: rgba(0, 1, 1, .06);
  }

  .theme--light.v-sheet--outlined {
    border: thin solid rgba(121, 121, 121, 0.12);
}
</style>