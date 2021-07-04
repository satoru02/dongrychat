<template>
  <v-container>
    <v-list two-line :width="baseList">
      <v-list-item-group multiple>
        <template>
          <v-list-item @click="enterSpace(item.attributes)" :key="index" v-for="(item, index) in items">
            <template v-slot:default="">
              <v-badge bordered light style="font-weight: bold;" offset-x="28" offset-y="31" v-if="item.attributes.users_count"
                color="#00bbf9" overlap :content="item.attributes.users_count">
                <v-list-item-avatar :class="itemAvatar" size="47" height="47" style="background-color: #dee2e6;">
                  <v-img v-if="item.attributes.image_path" :src="posterImg(item.attributes.image_path)" />
                  <span v-else>
                    <icon-base :width="'50'" :height="'50'" icon-name="icon-no-image" :iconColor="'#111111'"
                      :viewBox="'0 0 512 512'">
                      <icon-no-image />
                    </icon-base>
                  </span>
                </v-list-item-avatar>
              </v-badge>

              <v-badge v-else :value=false>
                <v-list-item-avatar :class="itemAvatar" size="47" height="47" style="background-color: #dee2e6;">
                  <v-img v-if="item.attributes.image_path" :src="posterImg(item.attributes.image_path)" />
                  <span v-else>
                    <icon-base :width="'45'" :height="'45'" icon-name="icon-no-image" :iconColor="'#ced4da'"
                      :viewBox="'0 0 512 512'">
                      <icon-no-image />
                    </icon-base>
                  </span>
                </v-list-item-avatar>
              </v-badge>
              <v-list-item-content>
                <v-list-item-title class="contents-name">
                  {{item.attributes.name}}
                </v-list-item-title>
                <v-list-item-subtitle>
                  <span class="comment-name">{{item.attributes.latest_comment.content}}</span>
                </v-list-item-subtitle>
              </v-list-item-content>
              <v-list-item-action v-if="$vuetify.breakpoint.width > 600">
                <span v-if="item.attributes.media === 'tv'" style="font-size: 12px; color: #637888;">
                  <v-btn color="#f2f2f2" elevation=0 style="font-weight: bold;" class="rounded-xl" x-small>
                    シーズン{{item.attributes.season}}-{{item.attributes.episode}}
                  </v-btn>
                </span>
              </v-list-item-action>

              <v-list-item-action>
                <span class="ml-5">
                  <icon-base :iconColor="'#000000'" icon-name="icon-following" :width="'17'" :height="'17'"
                    :viewBox="'0 0 511.996 511.996'">
                    <icon-following />
                  </icon-base>
                </span>
                <!-- <span v-if="item.attributes.media === 'tv'" class="ml-4">
                  <v-btn color="#000000" outlined style="font-weight: bold; font-size: 10px; color: #0f1419;"
                    class="rounded-xl" small elevation=0>
                    S{{item.attributes.season}}-E{{item.attributes.episode}}
                  </v-btn>
                </span> -->
              </v-list-item-action>
              <v-list-item-action>
                <span style="font-weight: bold; font-size: 13px;">{{item.attributes.comments_count}}</span>
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
      'icon-no-image': () => import( /* webpackPrefetch */ '../Icon/IconNoImage.vue'),
      'icon-following': () => import( /* webpackPrefetch: true */ '../Icon/IconFollowing.vue'),
    },
    props: {
      items: '',
      loading: false,
    },
    data() {
      return {
        cdn: process.env.AWS_CLOUDFRONT,
        img: 'tv.jpg',
        base_img_url: `https://image.tmdb.org/t/p/w200`,
        api: {
          for_subscription: `/api/v1/subscriptions`
        },
        media: {
          tv: 'tv',
          mv: 'mv',
        },
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
      baseList() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return ''
          case 'sm':
          case 'md':
            return ''
          case 'lg':
          case 'xl':
            return '580'
        }
      },
      itemAvatar() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-n3'
          case 'sm':
          case 'md':
          case 'lg':
          case 'xl':
            return 'rounded-lg ml-n1'
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
    font-size: 16.21px;
    color: #020814;
  }

  .comment-name {
    font-size: 14px;
    color: #637888;
  }
</style>