<template>
  <v-row :class="topImage">
    <v-col cols=4 sm=3 md=3 lg=3 xl=2 :class="imageSpace" v-for="(item, index) in items" :key="index">
      <v-card @click="enterSpace(item.attributes)" elevation=0 class="rounded-lg">
        <v-img v-if="item.attributes.image_path" position="under"
          gradient="to bottom, rgb(81 81 85 / 1%), rgb(0 0 0 / 70%)" class="white--text align-end rounded-lg"
          :width="imageWidth" :height="imageHeight" :src="posterImg(item.attributes.image_path)">
          <v-card-title class="mb-n5" style="font-weight: bold; line-height: 20px; font-size: 13px;">
            <p class="head-title">{{item.attributes.latest_comment.content}}</p>
          </v-card-title>
        </v-img>
        <v-img v-else position="under" gradient="to bottom, rgb(81 81 85 / 1%), rgb(0 0 0 / 70%)"
          class="white--text align-end rounded-lg" :width="imageWidth" :height="imageHeight">
          <v-card-title class="mb-n5" style="font-weight: bold; line-height: 20px; font-size: 13px;">
            <p class="head-title">{{item.attributes.latest_comment.content}}</p>
          </v-card-title>
        </v-img>
      </v-card>
    </v-col>
  </v-row>
</template>

<script>
  export default {
    name: 'BasePicture',
    props: {
      items: {
        type: Array
      }
    },
    data() {
      return {
        base_img_url: `https://image.tmdb.org/t/p/w200`,
        media: {
          tv: 'tv',
          movie: 'mv',
        },
      }
    },
    methods: {
      posterImg(path) {
        return this.base_img_url + path
      },
      enterSpace(item) {
        if (item.media === this.media.tv) {
          this.$router.push({
            name: 'TvSpace',
            params: {
              season_number: item.season,
              episode_number: item.episode,
              name: item.name,
              episode_title: item.episode_title,
              tmdb_tv_id: item.tmdb_tv_id,
              image_path: item.image_path,
              media: item.media,
            }
          })
        } else if (item.media === this.media.movie) {
          this.$router.push({
            name: 'MvSpace',
            params: {
              image_path: item.image_path,
              tmdb_mv_id: item.tmdb_mv_id,
              name: item.name,
              media: item.media,
            }
          })
        }
      },

    },
    computed: {
      topImage() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-1'
          case 'sm':
          case 'md':
          case 'lg':
          case 'xl':
            return ''
        }
      },
      imageSpace() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'mr-n1'
          case 'sm':
            return ''
          case 'md':
          case 'lg':
          case 'xl':
            return ''
        }
      },
      imageWidth() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return '100px'
          case 'sm':
          case 'md':
          case 'lg':
          case 'xl':
            return '140px'
        }
      },
      imageHeight() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return '110px'
          case 'sm':
          case 'md':
          case 'lg':
          case 'xl':
            return '160px'
        }
      },
    }
  }
</script>

<style scoped>
  .head-title {
    overflow: hidden;
    position: relative;
    line-height: 1.2em;
    max-height: 4.7em;
    text-align: justify;
    margin-right: -1em;
    padding-right: 1em;
  }

  .head-title:before {
    content: '...';
    position: absolute;
    right: 0;
    bottom: 0;
  }

  .head-title:after {
    content: '';
    position: absolute;
    right: 0;
    width: 1em;
    height: 1em;
    margin-top: 0.2em;
  }
</style>