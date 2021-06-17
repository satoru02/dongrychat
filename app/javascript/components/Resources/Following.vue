<template>
  <v-container fluid>

    <sub-header>
      <template v-slot:home_header="subHeaderProps">
        <h3 :class="gridSubHeader">
          {{subHeaderProps.sub_header}}
        </h3>
      </template>
    </sub-header>

    <v-list two-line>
      <v-list-item-group multiple>
        <template>
          <v-list-item active-class="white--text" @click="enterSpace(item)" :key="index" v-for="(item, index) in items">
            <template v-slot:default="">
              <v-list-item-avatar class="ml-n7" style="font-size:9px; color: #606770;">
                <v-badge color="#3a86ff" v-if="item.attributes.unconfirmed_comments > 0" dot />
              </v-list-item-avatar>
              <v-list-item-avatar class="ml-n3" size="70">
                <v-img v-if="item.attributes.image_path" :src="base_tmdb_img_url + item.attributes.image_path"></v-img>
                <!-- <v-img v-else :src="`${cdn}/image/${img}`"></v-img> -->
              </v-list-item-avatar>
              <v-list-item-content class="ml-4">
                <v-list-item-title :style="bindName">
                  {{item.attributes.name}}
                </v-list-item-title>
                <v-list-item-subtitle v-if="item.attributes.latest_comment" class="mt-1"
                  v-text="item.attributes.latest_comment.content">
                </v-list-item-subtitle>
                <v-list-item-subtitle v-else class="mt-1" v-text="''">
                </v-list-item-subtitle>
              </v-list-item-content>
              <v-list-item-content class="ml-16">
                <v-list-item-title style="font-weight: bold;">
                  <base-label class="rounded-xl" :color="'#000000'" font_size="10px" :label="true" v-if="item.attributes.media === 'tv'"
                    :small="false" :outlined="true" :text_color="'#111111'" :season="item.attributes.season"
                    :episode="item.attributes.episode" :title="item.attributes.episode_title" />
                  <v-chip style="font-size: 10px;" outlined class="rounded-xl" :color="'#000000'" v-if="item.attributes.media === 'mv'" label v-text="'映画'" />
                </v-list-item-title>
              </v-list-item-content>
              <v-list-item-action>
                <icon-base :iconColor="'#6c757d'" icon-name="icon-comment" :width="'14'" :height="'14'"
                  :viewBox="'0 0 30.333 30.333'">
                  <icon-comment />
                </icon-base>
              </v-list-item-action>
              <v-list-item-action class="ml-n1" style="font-size: 11px; color: #607080; font-weight: bold;">
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
      'sub-header': () => import( /* webpackPrefetch: true */ '../Layout/TheSubHeader'),
      'icon-base': () => import( /* webpackPrefetch: true */ '../Icon/IconBase'),
      'icon-comment': () => import( /* webpackPrefetch: true */ '../Icon/IconComment'),
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
          tv: 'subscribedTvSpace',
          movie: 'subscribedMvSpace'
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
                fontSize: '12px',
                color: '#111111'
            }
            case 'sm':
            case 'md':
            case 'lg':
            case 'xl':
              return {
                fontWeight: 'bold',
                  fontSize: '15px',
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
    font-size: 15px;
    color: #111111;
  }
</style>