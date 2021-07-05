<template>
  <v-container fluid class="mt-3">

    <h3 class=ml-3>フォロー中の作品一覧</h3>
    <v-divider class="ml-3 mt-3" />

    <v-list nav two-line>
      <v-list-item-group multiple>
        <template>
          <v-list-item active-class="white--text" @click="enterSpace(item)" :key="index" v-for="(item, index) in items">
            <template v-slot:default="">
              <v-badge bordered light style="font-weight: bold;" bottom offset-x="33" offset-y="33"
                v-if="item.attributes.unconfirmed_comments > 0" color="#06d6a0" overlap>
                <v-list-item-avatar size="55" style="background-color: #dee2e6;">
                  <v-img v-if="item.attributes.image_path" :src="base_tmdb_img_url + item.attributes.image_path">
                  </v-img>
                  <span v-else>
                    <icon-base :width="'30'" :height="'30'" icon-name="icon-no-image" :iconColor="'#111111'"
                      :viewBox="'0 0 512 512'">
                      <icon-no-image />
                    </icon-base>
                  </span>
                </v-list-item-avatar>
              </v-badge>
              <v-badge v-else :value=false>
                <v-list-item-avatar size="55" style="background-color: #dee2e6;">
                  <v-img v-if="item.attributes.image_path" :src="base_tmdb_img_url + item.attributes.image_path">
                  </v-img>
                  <span v-else>
                    <icon-base :width="'30'" :height="'30'" icon-name="icon-no-image" :iconColor="'#111111'"
                      :viewBox="'0 0 512 512'">
                      <icon-no-image />
                    </icon-base>
                  </span>
                </v-list-item-avatar>
              </v-badge>
              <v-list-item-content class="ml-1">
                <v-list-item-title :style="bindName">
                  {{item.attributes.name}}
                </v-list-item-title>
                <v-list-item-subtitle v-if="item.attributes.latest_comment">
                  <span class="comment-name">{{item.attributes.latest_comment.content}}</span>
                </v-list-item-subtitle>
                <v-list-item-subtitle v-else v-text="''">
                </v-list-item-subtitle>
              </v-list-item-content>
              <v-list-item-action class="mr-n4">
                <icon-base :iconColor="'#000000'" icon-name="icon-following" :width="'14'" :height="'14'"
                  :viewBox="'0 0 511.996 511.996'">
                  <icon-following />
                </icon-base>
              </v-list-item-action>
              <v-list-item-action style="font-size: 13px; color: #000000; font-weight: bold;">
                {{item.attributes.comments_count}}
              </v-list-item-action>
            </template>
          </v-list-item>
        </template>
      </v-list-item-group>
    </v-list>
    <base-loader :handler="infiniteHandler" :text="text.loading" />
  </v-container>
</template>

<script>
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const usersRepository = RepositoryFactory.get('users');

  export default {
    name: 'Following',
    components: {
      'base-label': () => import( /* webpackPrefetch: true */ '../Base/BaseLabel'),
      'base-loader': () => import( /* webpackPrefetch: true */ '../Base/BaseInfiniteLoader'),
      // 'sub-header': () => import( /* webpackPrefetch: true */ '../Layout/TheSubHeader'),
      'icon-base': () => import( /* webpackPrefetch: true */ '../Icon/IconBase'),
      'icon-no-image': () => import( /* webpackPrefetch: true */ '../Icon/IconNoImage.vue'),
      'icon-following': () => import( /* webpackPrefetch: true */ '../Icon/IconFollowing'),
    },
    data() {
      return {
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w200`,
        items: [],
        page: 1,
        pageSize: 10,
        error: '',
        media: {
          tv: 'tv',
          movie: 'mv'
        },
        space: {
          tv: 'registeredTvSpace',
          movie: 'registeredMvSpace'
        },
        text: {
          home: 'ホーム',
          movie: 'Movie',
          loading: '気になるドラマのチャットに参加してみよう！'
        },
      }
    },
    computed: {
      gridSubHeader() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'sub-header mb-n5 mt-1 ml-2'
          case 'sm':
          case 'md':
          case 'lg':
          case 'xl':
            return 'sub-header mb-2 mt-1 ml-n2'
        }
      },
      bindName() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return {
              fontWeight: 'bold',
                fontSize: '15px',
                color: '#111111'
            }
            case 'sm':
            case 'md':
            case 'lg':
            case 'xl':
              return {
                fontWeight: 'bold',
                  fontSize: '16px',
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
            if ((item.attributes.id === data['space_id']) && (this.$store.state.user.currentUser.id != data[
                'user_id'])) {
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
          usersRepository.getSubscriptions(this.$store.state.user.currentUser.id, {
              page: this.page,
              per_page: this.pageSize
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
    }
  }
</script>

<style scoped>
  .sub-header {
    font-weight: bold;
    font-size: 20px;
    color: #111111;
  }

  .comment-name {
    font-size: 14px;
    color: #637888;
  }
</style>