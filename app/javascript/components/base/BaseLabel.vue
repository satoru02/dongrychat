<template>
  <v-chip :small="small" :x-small="x_small" outlined label v-text="displayDetails()" :color="color" :text-color="textColor" />
</template>
<script>
  export default {
    name: 'BaseLabel',
    data() {
      return {
        seasonHeader: 'シーズン',
        episodeHeader: '第',
        episodeFooter: '話'
      }
    },
    props: {
      color: {
        type: String,
        default: '#000000'
      },
      textColor: {
        type: String,
        default: '#000000'
      },
      season: {
        type: Number,
        default: ''
      },
      episode: {
        type: Number,
        default: ''
      },
      title: {
        type: String,
        default: ''
      },
      small: {
        type: Boolean,
        default: false
      },
      x_small: {
        type: Boolean,
        default: false
      }
    },
    methods: {
      displayDetails() {
        return this.seasonHeader + this.season + ' ' + this.episodeHeader + this.episode + this.episodeFooter + ' ' +
          this.title
      }
    }
  }
</script>