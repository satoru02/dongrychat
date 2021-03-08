<template>
  <v-row>
    <v-col cols=12>
      <v-list two-line>
        <v-list-item-group active-class="orange--text" multiple>
          <template v-for="(n, index) in items">
            <v-list-item :key="index">
              <template v-slot:default="{ active }">
                <v-badge color="#f94144" :content='n.count' style="font-weight:bold;" right offset-x="31" offset-y="29" overlap>
                <v-list-item-avatar size=55 height=73 tile class="rounded-lg">
                  <v-img :src="n.pic"></v-img>
                </v-list-item-avatar>
                </v-badge>
                <v-list-item-content class=ml-3>
                  <v-list-item-title class="card-title" v-html="n.title"></v-list-item-title>
                  <v-list-item-subtitle v-text="'第1話 贖罪'" class="subtitle">
                  </v-list-item-subtitle>
                </v-list-item-content>
                <v-list-item-action>
                  <v-icon v-if="!active" color="grey lighten-1">
                  mdi-chevron-right
                  </v-icon>
                </v-list-item-action>
              </template>
            </v-list-item>
          </template>
        </v-list-item-group>
      </v-list>
    </v-col>
  </v-row>
</template>

<script>
  import TopFeaturedContents from '../top/TopFeaturedContents'
  import TopContentsRow from '../top/TopContentsRow'

  export default {
    name: 'TopPage',
    components: {
      'top-contents-row': TopContentsRow,
      'top-featured-contents': TopFeaturedContents
    },
    data() {
      return {
        items: [{
            title: 'The Mandalorian',
            pic: 'https://freeclassicimages.com/images/7th-Heaven-1927-1A3-movie-poster.jpg',
            count: "99+"
          },
          {
            title: 'Queens Gambit',
            pic: 'https://freeclassicimages.com/images/20-Million-Miles-To-Earth-07-movie-poster.jpg',
            count: "3"
          },
          {
            title: 'Game of the thrones',
            pic: 'https://freeclassicimages.com/images/69th-St-Vice-01-movie-poster.jpg',
            count: "3"
          },
          {
            title: '全裸監督',
            pic: 'https://freeclassicimages.com/images/Abigail-Leslie-Is-Back-In-Town-01-movie-poster.jpg',
            count: "4"
          },
          {
            title: '愛のむきだし',
            pic: 'https://freeclassicimages.com/images/above-us-the-waves-1956-movie-poster.jpg',
            count: "3"
          },
          {
            title: 'Wandavison',
            pic: 'https://freeclassicimages.com/images/abbott-and-costello-in-hollywood-1945-movie-poster.jpg',
            count: "3"
          },
          {
            title: 'Avengers',
            pic: 'https://freeclassicimages.com/images/abbott-and-costello-meet-invisible-man-1951-movie-poster.jpg',
            count: "3"
          },
        ]
      }
    }
  }
</script>

<style scoped>
  .card-title {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 15px;
  }

  .subtitle {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 12px;
    font-weight: bold;
    color: rgb(235, 232, 232);
  }

  .side-count {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 14px;
  }
</style>