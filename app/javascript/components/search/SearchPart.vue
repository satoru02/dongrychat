<template>
  <v-row :class="heading.position">
    <v-col cols=12 sm=12 md=12 lg=12 xl=12 class="ml-1 mt-n6">
      <v-row :class="vRowHeadingGrid">
        <v-col cols=5 sm=2 md=2 lg=2 xl=2>
          <div :class="vColInnerTitleGrid" :style="heading.innderHeading.titleStyle" v-text="title" />
        </v-col>
        <v-col cols=1 sm=8 md=8 lg=8 xl=8 />
        <v-col cols=4 sm=2 md=2 lg=2 xl=2>
          <div :class="vColInnerSubTitleGrid" @click="movePath()" :style="heading.innderSubHeading.titleStyle"
            v-text="heading.innderSubHeading.title" />
        </v-col>
      </v-row>
      <v-row :class="vColSlideGrid">
        <v-slide-group multiple show-arrows dark>
          <v-slide-item v-for="(item, index) in items" :key="index">
            <v-col cols=1 sm=1 md=1 lg=1 xl=1 :class="vColAvatar">
              <v-avatar @click="showContents(item)" :class="heading.img.avatar.position"
                :size="heading.img.avatar.size" :width="heading.img.avatar.width"
                :height="heading.img.avatar.height" tile>
                <v-img :src="base_tmdb_img_url + item.poster_path" />
              </v-avatar>
            </v-col>
          </v-slide-item>
        </v-slide-group>
      </v-row>
    </v-col>
  </v-row>
</template>

<script>
  export default {
    name: 'SearchTopRatedPart',
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
        heading: {
          position: 'mt-n3',
          elevation: '0',
          height: '430',
          round: 'rounded-lg',
          innderHeading: {
            position: 'mt-3 ml-3',
            title: '今週のおすすめ',
            titlePosition: 'ml-9 mt-6',
            titleStyle: {
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '15px',
              fontWeight: 'bold',
              color: '#111111'
            }
          },
          innderSubHeading: {
            position: 'mt-n1 ml-16 mr-n9',
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
            position: 'mt-n10 ml-n3 mr-n4',
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
    },
    computed: {
      vColSlideGrid(){
        switch(this.$vuetify.breakpoint.name){
          case 'xs' : return 'ml-13 mr-n16'
          case 'sm' : return ''
          case 'md' : return ''
          case 'lg' : return 'ml-2 mr-4'
          case 'xl' : return ''
        }
      },
      vRowHeadingGrid(){
        switch(this.$vuetify.breakpoint.name){
          case 'xs' : return 'mt-10 ml-16 mb-n3'
          case 'sm' : return ''
          case 'md' : return ''
          case 'lg' : return 'mt-8 ml-12'
          case 'xl' : return ''
        }
      },
      vColInnerTitleGrid(){
        switch(this.$vuetify.breakpoint.name){
          case 'xs' : return 'ml-8'
          case 'sm' : return ''
          case 'md' : return ''
          case 'lg' : return ''
          case 'xl' : return ''
        }
      },
      vColInnerSubTitleGrid(){
        switch(this.$vuetify.breakpoint.name){
          case 'xs' : return 'ml-n15 mt-1'
          case 'sm' : return ''
          case 'md' : return ''
          case 'lg' : return 'ml-10'
          case 'xl' : return ''
        }
      },
      vColAvatar(){
        switch(this.$vuetify.breakpoint.name){
          case 'xs' : return 'mt-n10 ml-n3 mr-n4'
          case 'sm' : return ''
          case 'md' : return ''
          case 'lg' : return 'mt-n10 ml-n3 mr-n4'
          case 'xl' : return ''
        }
      }

    }
  }
</script>

<style scoped>
</style>