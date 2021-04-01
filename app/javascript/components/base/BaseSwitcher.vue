<template>
  <v-row>
    <v-col md=1 lg=1 xl=1>
      <div :style="mode === false ? active : inactive" v-text="tv.header" />
      <v-avatar :color="colors.blue" :size="5" v-if="mode === false" :class="tv.avatar" />
    </v-col>
    <v-col md=1 lg=1 xl=1>
      <div :style="mode === true ? active : inactive" v-text="movie.header" />
      <v-avatar :color="colors.blue" :size="5" v-if="mode === true" :class="movie.avatar" />
    </v-col>
    <v-col md=9 lg=9 xl=9 />
    <v-col md=1 lg=1 xl=1>
      <v-switch v-model="mode" :color="colors.orange" inset :class="switchPosition" />
    </v-col>
  </v-row>
</template>

<script>
  export default {
    name: 'BaseSwitcher',
    props: {
      mode: {
        type: Boolean,
        default: false,
        required: true
      }
    },
    data(){
      return {
        colors: {
          blue: 'blue',
          orange: 'orange'
        },
        tv: {
          header: 'TV',
          avatar: 'ml-4',
        },
        movie: {
          header: 'MOVIE',
          avatar: 'ml-10'
        },
        active: {
          fontFamily: 'Helvetica Neue sans-serif',
          fontSize: '25px',
          fontWeight: 'bold',
          color: '#000000'
        },
        inactive: {
          fontFamily: 'Helvetica Neue sans-serif',
          fontSize: '25px',
          fontWeight: 'bold',
          color: '#8f8f8f'
        }
      }
    }
  }
</script>