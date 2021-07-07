<template>
  <v-row>
    <v-col cols=6 sm=4 md=4 lg=3 xl=3 v-for="(item, index) in items" :key="index">
      <v-card elevation=0 class="rounded-lg" @click="showContents(item)" v-if="$vuetify.breakpoint.width > 600">
        <v-img position="under" gradient="to bottom, rgb(81 81 85 / 1%), rgb(0 0 0 / 90%)"
          class="white--text align-end rounded-lg"
          :height="'250px'" v-if="item.poster_path"
          :src="base_tmdb_img_url + item.poster_path">
          <v-btn :color="media === 'tv' ? '#00bbf9' : '#ff0054'" x-small class="elevation-0 ml-3 rounded-xl" alt="" style="font-size: 12px; font-weight: bold; color: #ffffff;"
            >
            {{item.vote_average}}
          </v-btn>
          <span v-if="media === 'tv'" class="ml-1" style="font-size: 11px; font-weight: bold; color: #ffffff;" >{{item.first_air_date}}・初放送</span>
          <span v-if="media === 'movie'" class="ml-1" style="font-size: 11px; font-weight: bold; color: #ffffff;" >{{item.release_date}}・初公開</span>
          <v-card-title v-if="media === 'tv'" style="font-weight: bold; line-height: 23px; font-size: 18px;">
            {{item.name}}
          </v-card-title>
          <v-card-title v-if="media === 'movie'" style="font-weight: bold; line-height: 23px; font-size: 18px;">
            {{item.title}}
          </v-card-title>
        </v-img>
      </v-card>
      <v-card elevation=0 class="rounded-lg" @click="showContents(item)" v-else>
        <v-img position="under" gradient="to bottom, rgb(81 81 85 / 1%), rgb(0 0 0 / 90%)"
          class="white--text align-end rounded-lg"
          :height="'180px'" v-if="item.poster_path"
          :src="base_tmdb_img_url + item.poster_path">

          <v-card-title v-if="media === 'tv'" style="font-weight: bold; line-height: 20px; font-size: 12px;">
            {{item.name}}
          </v-card-title>
          <v-card-title v-if="media === 'movie'" style="font-weight: bold; line-height: 20px; font-size: 12px;">
            {{item.title}}
          </v-card-title>
        </v-img>
      </v-card>
    </v-col>
  </v-row>
</template>

<script>
  export default {
    name: "BaseList",
    props: {
      items: {
        type: Array,
        required: true
      },
      media: {
        type: String,
        required: true
      }
    },
    data() {
      return {
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w500`,
        listActive: 'orange--text',
        listItemStyle: {
          fontWeight: 'bold',
          fontSize: '15px',
          color: '#111111'
        },
        subtitleStyle: {
          fontSize: '12px',
          fontWeight: 'bold',
          color: '#6c757d'
        }
      }
    },
    methods: {
      showContents(item) {
        if (this.media === 'tv') {
          this.$router.push({
            name: 'TvDetails',
            params: {
              id: item.id,
              number: 1,
              tv_name: item.name
            }
          })
        } else if (this.media === 'movie') {
          this.$router.push({
            name: 'MvDetails',
            params: {
              id: item.id,
              mv_name: item.title
            }
          })
        }
      }
    }
  }
</script>