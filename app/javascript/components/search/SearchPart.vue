<template>
  <v-row :class="heading.position">
    <v-col md=12 lg=12 xl=12>
      <v-card :elevation="heading.elevation" :class="heading.round" :height="heading.height" outlined>
        <v-row :class="heading.innderHeading.position">
          <v-col md=3 lg=3 xl=3>
            <div :class="heading.innderHeading.titlePosition" :style="heading.innderHeading.titleStyle"
              v-text="title" />
          </v-col>
          <v-col md=7 lg=7 xl=7 />
          <v-col md=2 lg=2 xl=2>
            <div @click="movePath()" :class="heading.innderSubHeading.titlePosition"
              :style="heading.innderSubHeading.titleStyle" v-text="heading.innderSubHeading.title" />
          </v-col>
        </v-row>
        <v-row>
          <v-col md=2 lg=2 xl=2 v-for="(item, index) in items" :class="heading.img.position" :key="index">
            <v-row>
              <v-col md=12 lg=12 xl=12>
                <v-avatar :class="heading.img.avatar.position" :size="heading.img.avatar.size"
                  :width="heading.img.avatar.width" :height="heading.img.avatar.height" tile>
                  <v-row @click="showContents(item)">
                    <v-col md=12 lg=12 xl=12>
                      <base-content-sheet :height="300" :img="base_tmdb_img_url + item.poster_path" />
                    </v-col>
                  </v-row>
                </v-avatar>
              </v-col>
            </v-row>
            <v-row>
              <v-col md=12 lg=12 xl=12>
                <div :style="heading.img.titleStyle" :class="heading.img.titlePosition"
                  v-text="media === tv.type ? item.name : item.title" />
              </v-col>
            </v-row>
          </v-col>
        </v-row>
      </v-card>
    </v-col>
  </v-row>
</template>

<script>
  import BaseContentSheet from '../Base/BaseContentSheet';
  export default {
    name: 'SearchTopRatedPart',
    components: {
      'base-content-sheet': BaseContentSheet
    },
    props: {
      media: {
        type: String,
        default: 'tv',
        required: true
      },
      items: {
        type: Array,
        default: Array,
        required: true,
      },
      title: {
        type: String,
        default: String,
        required: true
      },
      endpoint: {
        type: String,
        default: String,
        required: true
      }
    },
    data() {
      return {
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w200`,
        tv: {
          type: 'tv',
          details: 'TvDetails'
        },
        mv: {
          type: 'mv',
          details: 'MvDetails'
        },
        // for css -----------------------------------------
        heading: {
          position: 'mt-n3',
          elevation: '0',
          height: '430',
          round: 'rounded-lg',
          innderHeading: {
            position: 'mt-n1',
            title: '今週のおすすめ',
            titlePosition: 'ml-10 mt-3',
            titleStyle: {
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '20px',
              fontWeight: 'bold',
              color: '#484b4d'
            }
          },
          innderSubHeading: {
            position: 'mt-n1',
            title: 'もっとみる',
            titlePosition: 'ml-10 mt-6',
            titleStyle: {
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '13px',
              fontWeight: 'bold',
              color: '#484b4d'
            }
          },
          img: {
            position: 'mt-n10 ml-4',
            avatar: {
              position: 'ml-6 mt-7 rounded-lg',
              size: '60',
              width: '180',
              height: '300'
            },
            titlePosition: 'mt-n3 ml-7',
            titleStyle: {
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '13px',
              fontWeight: 'bold',
              color: '#000000'
            }
          }
        }
        // -----------------------------------------
      }
    },
    methods: {
      showContents(item) {
        if (this.media == this.tv.type) {
          this.$router.push({
            name: this.tv.details,
            params: {
              id: item.id,
              number: 1,
              tv_name: item.name
            }
          })
        } else if (this.media == this.mv.type) {
          this.$router.push({
            name: this.mv.details,
            params: {
              id: item.id,
              mv_name: item.title
            }
          })
        }
      },
      movePath() {
        this.$router.push({
          name: this.endpoint,
          params: {
            query: this.media
          }
        })
      }
    }
  }
</script>

<style scoped>
</style>