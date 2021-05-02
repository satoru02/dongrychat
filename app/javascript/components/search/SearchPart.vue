<template>
  <v-row :class="heading.position">
    <v-col cols=12 sm=12 md=12 lg=12 xl=12 class="ml-1 mt-n6">
        <v-row :class="heading.innderHeading.position">
          <v-col cols=2 sm=2 md=2 lg=2 xl=2>
            <div :class="heading.innderHeading.titlePosition" :style="heading.innderHeading.titleStyle"
              v-text="title" />
          </v-col>
          <v-col cols=8 sm=8 md=8 lg=8 xl=8 />
          <v-col cols=2 sm=2 md=2 lg=2 xl=2 :class="heading.innderSubHeading.titlePosition">
            <div class="ml-10"
             @click="movePath()"
              :style="heading.innderSubHeading.titleStyle" v-text="heading.innderSubHeading.title" />
          </v-col>
        </v-row>
        <v-row class="ml-n8">
          <v-col cols=1 sm=1 md=1 lg=1 xl=1 v-for="(item, index) in items" :class="heading.img.position" :key="index">
            <v-row>
              <v-col cols=12 sm=12 md=12 lg=12 xl=12>
                <v-avatar @click="showContents(item)" :class="heading.img.avatar.position" :size="heading.img.avatar.size"
                  :width="heading.img.avatar.width" :height="heading.img.avatar.height" tile>
                  <v-img :src="base_tmdb_img_url + item.poster_path" />
                </v-avatar>
              </v-col>
            </v-row>
            <v-row>
            </v-row>
          </v-col>
        </v-row>
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
            position: 'mt-3',
            title: '今週のおすすめ',
            titlePosition: 'ml-9 mt-6',
            titleStyle: {
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '15px',
              fontWeight: 'bold',
              color: '#6c757d'
            }
          },
          innderSubHeading: {
            position: 'mt-n1',
            title: 'もっとみる',
            titlePosition: 'mt-6',
            titleStyle: {
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '13px',
              fontWeight: 'bold',
              color: '#6c757d'
            }
          },
          img: {
            position: 'mt-n10 ml-14',
            avatar: {
              position: 'mt-7 rounded-lg',
              size: '125',
              height: '195'
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