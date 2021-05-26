<template>
  <v-container
    fluid
  >

    <v-hover
       v-slot="{ hover }"
       v-for="(item, index) in items"
       :key="index"
    >
      <v-card
        class="rounded-lg mb-8 mt-n4"
        outlined
        @click="enterSpace(item.attributes)"
        :style="hover ? hoverStyle : unhoverStyle"
        height="200px"
      >

        <v-responsive>
          <v-row class="mt-1">
            <v-col
              :class="gridRank"
              cols=1
              sm=1
              md=1
              lg=1
              xl=1
            >
              <span
                v-if="$vuetify.breakpoint.name != 'xs'"
                class="ranking">
                {{index + 1}}
              </span>
            </v-col>

            <v-col
              :class="gridAvatar"
              cols=1
              sm=1
              md=1
              lg=1
              xl=1
            >
              <v-avatar
                class="rounded-lg"
                size="80"
                height="83"
                tile
              >
                <v-img
                  :src="base_tmdb_img_url + item.attributes.image_path"
                />
              </v-avatar>
            </v-col>

            <v-col
              :class="gridRight"
              cols=10
              sm=10
              md=10
              lg=10
              xl=10
            >
              <v-row dense>
                <v-col
                  cols=1
                  sm=1
                  md=1
                  lg=1
                  xl=1
                />
                <v-col
                  :class="gridLabel"
                  cols=10
                  sm=10
                  md=10
                  lg=9
                  xl=10
                >
                  <base-label
                    class="ml-1 mr-3"
                    v-if="item.attributes.media === 'tv'"
                    :x_small="true"
                    :outlined="false"
                    :label="true"
                    :color="'#016aff'"
                    :text-color="'#ffffff'"
                    :season="item.attributes.season"
                    :episode="item.attributes.episode"
                    :title="item.attributes.episode_title" />
                  <v-chip
                    class="movie-label"
                    v-if="item.attributes.media === 'mv'"
                    x-small
                    label
                    :color="'yellow'"
                    v-text="'Movie'"
                  />
                </v-col>
              </v-row>

              <v-row class="mt-5">
                <v-col
                  cols=9
                  sm=9
                  md=10
                  lg=10
                  xl=10
                />
                <v-col
                  class="ml-8 mt-n1"
                  cols=1
                  sm=1
                  md=1
                  lg=1
                  xl=1
                >
                  <v-badge
                    v-if="$vuetify.breakpoint.name != 'xs'"
                    color="#02e98d"
                    dot
                  />
                </v-col>
                <v-col
                  :class="$vuetify.breakpoint.width > 600 ? 'user-count mt-n4 ml-n8' : 'user-count mt-n4 ml-n4'"
                  cols=1
                  sm=1
                  md=1
                  lg=1
                  xl=1
                >
                  <span v-if="$vuetify.breakpoint.name != 'xs'">{{item.attributes.users.length}}</span>
                </v-col>
              </v-row>

              <v-row
                class="mt-n12"
                :style="$vuetify.breakpoint.width > 600 ? descWidth : mobileWidth">
                <v-col
                  cols=1
                  sm=1
                  md=1
                  lg=1
                  xl=1
                />
                <v-col
                  :class="gridName"
                  :style="$vuetify.breakpoint.width > 600 ? descText : mobileText"
                  cols=8
                  sm=10
                  md=10
                  lg=10
                  xl=10
                >
                  <span>{{item.attributes.name}}</span>
                </v-col>
              </v-row>

              <v-row
                v-if="item.attributes.tags"
                :class="$vuetify.breakpoint.width > 600 ? 'mt-n3 ml-4' : 'mt-n1 ml-16'">
                <v-col
                  cols=2
                  sm=3
                  md=7
                  lg=7
                  xl=7
                >
                  <v-chip
                    label
                    :class="$vuetify.breakpoint.width > 600 ? 'tag-text mr-2' : 'tag-text mr-2'"
                    v-for="(tag, index) in item.attributes.tags.slice(0, 2)"
                    :key="index"
                    color="#e9ecef"
                    v-text="'#' + tag.name"
                    x-small
                  />
                </v-col>
                <v-col
                  cols=2
                  sm=3
                  md=1
                  lg=1
                  xl=1
                />
                <v-col
                  :class="gridNumber"
                  cols=8
                  sm=6
                  md=4
                  lg=4
                  xl=4
                  :style="gridNumberText"
                >
                  <v-icon
                    color="#5d666e"
                    size=12
                  >
                    mdi-comment-outline
                  </v-icon>
                  <span>123</span>
                  <v-icon
                    color="#5d666e"
                    size="12"
                    class="ml-2"
                  >
                    mdi-note-outline
                  </v-icon>
                  <span>63</span>
                  <v-icon
                    color="#5d666e"
                    size="12"
                    class="ml-2"
                  >
                    mdi-television-classic
                  </v-icon>
                  <span>11</span>
                </v-col>
              </v-row>
            </v-col>
          </v-row>

          <v-divider
            class="mt-3"
          />
          <v-row
            :class="gridBottom"
            dense>
            <v-col
              cols=1
              sm=1
              md=1
              lg=1
              xl=1
              :class="gridIcon"
            >
              <v-avatar
                size="24"
              >
                <v-img src="https://cdn.vuetifyjs.com/images/john.jpg" />
              </v-avatar>
            </v-col>

            <v-col
              cols=10
              sm=10
              md=10
              lg=10
              xl=10
              :class="gridTime"
            >
              <span class="user-name">
                ボニ語ろう
              </span>
              <span class="time-text">
                 2日前
              </span>
            </v-col>
          </v-row>

          <v-row
            dense
            class="mt-n3">
            <v-col
              cols=1
              sm=1
              md=1
              lg=1
              xl=1
            />
            <v-col
              class="desc-text"
              :class="gridComment"
              cols=10
              sm=10
              md=10
              lg=10
              xl=10
            >
              『劇場版「鬼滅の刃」無限列車編』のBlu-ray＆DVD発売を記念したカウントダウン。日まで紡がれる全38日 発売当日まで紡がれる全38日発売当日まで紡がれる全38日間。...
            </v-col>
            <v-col
              cols=1
              sm=1
              md=1
              lg=1
              xl=1
            />
          </v-row>
        </v-responsive>
      </v-card>
    </v-hover>
  </v-container>
</template>

<script>
  import '@mdi/font/css/materialdesignicons.css';

  export default {
    name: 'BaseCard',
    components: {
      'base-label': () => import( /* webpackPrefetch: true */ '../Base/BaseLabel')
    },
    props: {
      items: '',
    },
    data() {
      return {
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w500`,
        unhoverStyle: {
          backgroundColor: '#f5f8fa'
        },
        hoverStyle: {
          backgroundColor: '#edf2f4'
        },
        descText: {
          color: '#011627',
          fontSize: '17px',
          height: '82px',
          fontWeight: 'bold'
        },
        mobileText: {
          color: '#011627',
          fontSize: '15px',
          height: '53px',
          fontWeight: 'bold'
        },
        descWidth: {
          maxHeight: '43px',
        },
        mobileWidth: {
          maxHeight: '75px',
        },
      }
    },
    computed: {
      gridRank() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'mt-8 ml-2 mr-4'
          case 'sm':
          case 'md':
          case 'lg':
          case 'xl':
            return 'ml-4 mt-8'
        }
      },
      gridAvatar() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-n10'
          case 'sm':
          case 'md':
          case 'lg':
          case 'xl':
            return 'ml-n8'
        }
      },
      gridRight() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-3 mt-n1'
          case 'sm':
            return 'ml-4 mt-n1'
          case 'md':
          case 'lg':
          case 'xl':
            return 'ml-3'
        }
      },
      gridIcon() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-5'
          case 'sm':
          case 'md':
          case 'lg':
          case 'xl':
            return 'ml-11 mt-n1'
        }
      },
      gridTime() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-1 mt-1'
          case 'sm':
          case 'md':
            return 'ml-n4'
          case 'lg':
          case 'xl':
            return 'ml-n6'
        }
      },
      gridComment() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'desc-text mt-1 ml-2'
          case 'sm':
          case 'md':
          case 'lg':
          case 'xl':
            return 'desc-text mt-1 ml-2'
        }
      },
      gridNumberText(){
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return {
              fontSize: '8px',
              color: '#5d666e'
            }
          case 'sm':
          case 'md':
          case 'lg':
          case 'xl':
            return {
              fontSize: '10px',
              fontWeight: 'bold',
              color: '#5d666e'
            }
        }
      },
      gridNumber(){
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'mt-2 ml-n1'
          case 'sm':
          case 'md':
          case 'lg':
          case 'xl':
            return 'mt-3 ml-n5'
        }
      },
      gridBottom(){
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'mt-1'
          case 'sm':
          case 'md':
          case 'lg':
          case 'xl':
            return 'mt-2'
        }
      },
      gridLabel(){
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'label ml-5 mt-1'
          case 'sm':
            return 'label ml-1 mt-1'
          case 'md':
          case 'lg':
          case 'xl':
            return 'label ml-n6'
        }
      },
      gridName(){
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-6'
          case 'sm':
            return 'ml-2'
          case 'md':
          case 'lg':
          case 'xl':
            return 'ml-n5'
        }
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
      }
    }
  }
</script>

<style scoped>
  .ranking {
    font-size: 12px;
    font-weight: bold;
    color: #6c757d;
  }

  .label {
    font-size: 15px;
    font-weight: bold;
    color: #ced4da;
  }

  .movie-label {
    font-size: 11px;
    font-weight: bold;
  }

  .user-count {
    font-size: 12px;
    font-weight: bold;
    color: #6c757d;
  }

  .tag-text {
    font-size: 5px;
    color: #111111;
  }

  .number-text {
    font-size: 10px;
    font-weight: bold;
    color: #5d666e;
  }

  .user-name {
    font-weight: bold;
    color: #011627;
    font-size: 11px;
  }

  .time-text {
    font-weight: bold;
    color: #6c757d;
    font-size: 8px;
  }

  .desc-text {
    color: #011627;
    font-size: 12px;
    line-height: 20px;
    max-height: 45px;
  }

  .title-text {
    font-weight: bold;
    font-size: 17px;
    color: #000000;
    height: 53px;
  }

  .theme--light.v-sheet--outlined {
    border: thin solid rgba(128, 128, 128, 0.12);
  }

  .v-divider {
    border-color: rgba(226, 226, 226, 0.384);
  }
</style>