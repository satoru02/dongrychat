<template>
  <v-chip :small="small" :style="textStyle"
   :x-small="x_small" :outlined="outlined" :label="label" v-text="displayDetails()" :color="color" :text-color="textColor" />
</template>
<script>
  export default {
    name: 'BaseLabel',
    data() {
      return {
        seasonHeader: 'シーズン',
        episodeHeader: '第',
        episodeFooter: '話',
        textStyle: {
          fontSize: '11px',
          color: '#111111'
        }
      }
    },
    props: {
      label: {
        type: Boolean,
        default: false
      },
      outlined: {
        type: Boolean,
        default: false,
      },
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