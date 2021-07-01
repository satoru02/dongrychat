<template>
  <v-container>

    <v-list two-line width="960">
      <v-list-item-group multiple>
        <template>
          <v-list-item active-class="white--text" @click="enterSpace(item.attributes)" :key="index"
            v-for="(item, index) in items">
            <template v-slot:default="">
              <v-badge light style="font-weight: bold;" offset-x="26" v-if="item.attributes.users_count" offset-y="26"
                color="#00bbf9" icon="mdi-lock" overlap :content="item.attributes.users_count">
                <v-list-item-avatar class="rounded-lg" tile size="73" height="103" style="background-color: #dee2e6;">
                  <v-img v-if="item.attributes.image_path" :src="posterImg(item.attributes.image_path)"></v-img>
                  <span v-else>
                    <icon-base :width="'50'" :height="'50'" icon-name="icon-no-image" :iconColor="'#111111'"
                      :viewBox="'0 0 512 512'">
                      <icon-no-image />
                    </icon-base>
                  </span>
                </v-list-item-avatar>
              </v-badge>
              <v-badge v-else :value=false>
                <v-list-item-avatar class="rounded-lg" tile size="73" height="103" style="background-color: #dee2e6;">
                  <v-img v-if="item.attributes.image_path" :src="posterImg(item.attributes.image_path)"></v-img>
                  <span v-else>
                    <icon-base :width="'45'" :height="'45'" icon-name="icon-no-image" :iconColor="'#ced4da'"
                      :viewBox="'0 0 512 512'">
                      <icon-no-image />
                    </icon-base>
                  </span>
                </v-list-item-avatar>
              </v-badge>
              <v-list-item-content class="">
                <!-- <v-list-item-title class="mb-3">
                  <base-label class="rounded" font_size="12px" :label="true" v-if="item.attributes.media === 'tv'"
                    :small="true" :outlined="true" :color="'#000000'" :text_color="'#111111'"
                    :season="item.attributes.season" :episode="item.attributes.episode"
                    :title="item.attributes.episode_title" />
                  <v-chip outlined small class="rounded" :color="'#000000'" v-if="item.attributes.media === media.mv"
                    label :style="chipLabel.label.style" v-text="'映画'" />
                </v-list-item-title> -->
                <v-list-item-title class="contents-name">
                  {{item.attributes.name}}
                  <!-- <span v-if="item.attributes.media === 'tv'" class="ml-4">
                    <v-btn color="#000000" outlined style="font-weight: bold; font-size: 10px; color: #0f1419;" class="rounded-xl" x-small elevation=0>
                      {{item.attributes.season}}-{{item.attributes.episode}}
                    </v-btn></span> -->
                </v-list-item-title>
                <v-list-item-subtitle v-if="item.attributes.latest_comment" class="comment-name">
                  <div class="" style="color: #536471;">{{item.attributes.latest_comment.content}}</div>
                </v-list-item-subtitle>
                <v-list-item-subtitle v-else class="comment-name mt-1" v-text="''">
                </v-list-item-subtitle>
              </v-list-item-content>
              <!-- <v-list-item-content>
                <v-list-item-title class="contents-name">
                  <base-label class="ml-3 rounded-xl" font_size="12px" :label="true"
                    v-if="item.attributes.media === 'tv'" :small="false" :outlined="true" :color="'#000000'"
                    :text_color="'#111111'" :season="item.attributes.season" :episode="item.attributes.episode"
                    :title="item.attributes.episode_title" />
                  <v-chip outlined class="ml-2 rounded-xl" :color="'#000000'" v-if="item.attributes.media === media.mv"
                    label :style="chipLabel.label.style" v-text="'映画'" />
                </v-list-item-title>
              </v-list-item-content> -->

              <v-list-item-action>
                <span v-if="item.attributes.media === 'tv'" class="ml-4">
                  <v-btn color="#000000" outlined style="font-weight: bold; font-size: 10px; color: #0f1419;"
                    class="rounded-xl" small elevation=0>
                    S{{item.attributes.season}}-E{{item.attributes.episode}}
                  </v-btn>
                </span>
                <span v-else class="ml-9">
                  <v-btn color="#000000" outlined style="font-weight: bold; font-size: 10px; color: #0f1419;"
                    class="rounded-xl" small elevation=0>
                    映画
                  </v-btn>
                </span>
                <!-- <v-list-item-title class="contents-name">
                  <base-label class="ml-3 rounded-lg" font_size="12px" :label="true"
                    v-if="item.attributes.media === 'tv'" :small="true" :outlined="true" :color="'#000000'"
                    :text_color="'#111111'" :season="item.attributes.season" :episode="item.attributes.episode"
                    :title="item.attributes.episode_title" />
                  <v-chip outlined class="ml-2 rounded-xl" :color="'#000000'" v-if="item.attributes.media === media.mv"
                    label :style="chipLabel.label.style" v-text="'映画'" />
                </v-list-item-title> -->
                <!-- <v-list-item-avatar color="#dee2e6" class="rounded-xl ml-n8" size="27">
                  <v-img v-if="item.attributes.latest_comment_user"
                    :src="item.attributes.latest_comment_user.data.attributes.avatar_url"></v-img>
                  <span v-else>
                    <icon-base :width="'19'" :height="'19'" icon-name="icon-user" :iconColor="'#ffffff'"
                      :viewBox="'-42 0 512 512.002'">
                      <icon-user />
                    </icon-base>
                  </span>
                </v-list-item-avatar> -->
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
      'icon-user': () => import( /* webpackPrefetch */ '../Icon/IconUser'),
      'icon-no-image': () => import( /* webpackPrefetch */ '../Icon/IconNoImage.vue'),
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
        base_img_url: `https://image.tmdb.org/t/p/w500`,
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
    font-size: 17.65px;
    color: #020814;
  }

  .comment-name {
    /* font-weight: bold; */
    font-size: 15px;
    color: #536471;
  }
</style>