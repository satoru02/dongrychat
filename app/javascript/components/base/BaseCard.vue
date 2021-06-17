<template>
  <v-container>

    <v-list two-line>
      <v-list-item-group multiple>
        <template>
          <v-list-item active-class="white--text" @click="enterSpace(item.attributes)" :key="index"
            v-for="(item, index) in items">
            <template v-slot:default="">
              <!-- <v-list-item-avatar class="ml-n5" style="font-size:9px; color: #606770;"> -->
                <!-- <v-btn label outlined x-small> -->
                  <!-- {{index + 1}} -->
                <!-- </v-btn> -->
              <!-- </v-list-item-avatar> -->
              <v-badge light style="font-weight: bold;" offset-x="26" v-if="item.attributes.users.length" offset-y="26"
                color="#43e6ff" icon="mdi-lock" overlap :content="item.attributes.users.length">
                <v-list-item-avatar tile class="rounded-lg" size="80">
                  <v-img v-if="item.attributes.image_path" :src="posterImg(item.attributes.image_path)"></v-img>
                  <v-img v-else :src="`${cdn}/image/${img}`"></v-img>
                </v-list-item-avatar>
              </v-badge>
              <v-badge v-else :value=false>
                <v-list-item-avatar tile class="rounded-lg" size="80">
                  <v-img v-if="item.attributes.image_path" :src="posterImg(item.attributes.image_path)"></v-img>
                  <v-img v-else :src="`${cdn}/image/${img}`"></v-img>
                </v-list-item-avatar>
              </v-badge>
              <v-list-item-content>
                <v-list-item-title class="contents-name">
                  {{item.attributes.name}}
                </v-list-item-title>
                <v-list-item-subtitle v-if="item.attributes.latest_comment" class="comment-name mt-1"
                >
                <div style="color: #828a92; font-weight: bold;">{{item.attributes.latest_comment.content}}</div>
                </v-list-item-subtitle>
                <v-list-item-subtitle v-else class="comment-name mt-1" v-text="''">
                </v-list-item-subtitle>
              </v-list-item-content>
              <v-list-item-content>
                <v-list-item-title class="contents-name">
                  <base-label class="ml-3 rounded-xl" font_size="12px" :label="true" v-if="item.attributes.media === 'tv'"
                    :small="false" :outlined="true" :color="'#000000'" :text_color="'#111111'" :season="item.attributes.season"
                    :episode="item.attributes.episode" :title="item.attributes.episode_title" />
                  <v-chip outlined class="ml-2 rounded-xl" :color="'#000000'" v-if="item.attributes.media === media.mv" label
                    :style="chipLabel.label.style" v-text="'映画'" />
                </v-list-item-title>
              </v-list-item-content>

              <v-list-item-action>
                <v-list-item-avatar class="rounded-xl ml-n8" size="25">
                  <v-img v-if="item.attributes.latest_comment_user"
                    :src="item.attributes.latest_comment_user.data.attributes.avatar_url"></v-img>
                  <v-img v-else :src="`${cdn}/image/${img}`" />
                </v-list-item-avatar>
              </v-list-item-action>
              <v-list-item-action class="user-name ml-n2">
                <icon-base icon-name="icon-checkbox" :iconColor='"#a9abad"' :width="'25'" :height="'25'"
                  :viewBox="'0 0 512 512'">
                  <icon-checkbox />
                </icon-base>
              </v-list-item-action>
            </template>
          </v-list-item>
        </template>
      </v-list-item-group>
    </v-list>

  </v-container>
</template>

<script>
  export default {
    name: 'BaseCard',
    components: {
      'base-label': () => import( /* webpackPrefetch: true */ '../Base/BaseLabel'),
      'icon-base': () => import( /* webpackPrefetch */ '../Icon/IconBase'),
      'icon-checkbox': () => import( /* webpackPrefetch: true */ '../Icon/IconCheckbox.vue'),
    },
    props: {
      items: '',
      loading: false,
    },
    data() {
      return {
        cdn: process.env.AWS_CLOUDFRONT,
        img: `tv.jpg`,
        base_img_url: `https://image.tmdb.org/t/p/w200`,
        descText: {
          color: '#111111',
          fontSize: '19px',
          height: '82px',
          fontWeight: 'bold'
        },
        api: {
          for_subscription: `/api/v1/subscriptions`
        },
        media: {
          tv: 'tv',
          mv: 'mv',
        },
        params: {},
        subscribed: Boolean,
        chipLabel: {
          label: {
            yellow: '#f7e733',
            movie: 'Movie',
            style: {
              fontWeight: 'bold',
              color: "#000000",
              fontSize: '10px',
            }
          },
        },
      }
    },
    methods: {
      enterSpace(space) {
        if (space.media === 'tv') {
          this.$router.push({
            name: 'TvSpace',
            params: {
              season_number: space.season,
              episode_number: space.episode,
              name: space.name,
              episode_title: space.episode_title,
              tmdb_tv_id: space.tmdb_tv_id,
              image_path: space.image_path,
              media: space.media,
            }
          })
        } else if (space.media === 'mv') {
          this.$router.push({
            name: 'MvSpace',
            params: {
              image_path: space.image_path,
              tmdb_mv_id: space.tmdb_mv_id,
              name: space.name,
              media: space.media,
            }
          })
        }
      },
      posterImg(path) {
        return this.base_img_url + path
      },
    },
    computed: {
      vColSummaryStyle() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs' || 'sm' || 'md':
            return {
              color: '#111111',
                fontWeight: 'bold',
                fontSize: '12px',
                height: '15px',
                maxHeight: '15px',
                overflow: 'scroll',
                overflowY: 'scroll',
            }
            case 'lg' || 'xl':
              return {
                color: '#ffffff',
                  // fontWeight: 'bold',
                  fontSize: '12px',
                  fontWeight: 'bold',
                  height: '32px',
                  maxHeight: '32px',
                  overflow: 'scroll',
                  overflowY: 'scroll',
              }
        }
      }

    },
  }
</script>

<style scoped>
  .label {
    font-size: 15px;
    font-weight: bold;
    color: #ced4da;
  }

  .user-name {
    font-weight: bold;
    color: #000000 opacity 30.0%;
    font-size: 8px;
  }

  .desc-text {
    color: #111111;
    font-size: 14px;
    line-height: 16px;
    height: 34px;
    max-height: 34px;
    overflow: auto;
  }

  .contents-name {
    font-weight: bold;
    font-size: 18px;
    color: #24292e;
  }

  .comment-name {
    /* font-weight: bold; */
    font-size: 15px;
    color: #828a92;
  }
</style>