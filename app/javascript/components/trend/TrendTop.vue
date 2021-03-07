<template>
  <v-row style="background-color: #ffffff">
    <v-col cols=12>
      <v-list two-line>
        <v-list-item-group style="background-color: #ffffff" active-class="orange--text" multiple>
          <template v-for="(n, index) in items">
            <v-list-item :key="index">
              <template v-slot:default="{ }">
                <div class="mr-5 ranktitle">{{index + 1}}</div>
                <v-list-item-avatar size=59 height=66 tile class="rounded-lg">
                  <v-img :src="n.pic"></v-img>
                </v-list-item-avatar>
                <v-list-item-content class=ml-7>
                  <v-list-item-title class="card-title" v-html="n.title"></v-list-item-title>
                  <v-list-item-subtitle class="subauthor">
                    Jon favrou
                  </v-list-item-subtitle>
                </v-list-item-content>
                <v-list-item-action>
                  <div class="subtitle">{{n.count}}人が会話中</div>
                  <!-- <v-btn style="font-weight:bold;" small rounded v-if="!active" color="indigo" outlined>
                    Join
                  </v-btn> -->
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
  export default {
    name: 'TrendTop',
    data(){
      return{
         items: [{
            title: 'The Mandalorian S1-EP4',
            pic: 'https://freeclassicimages.com/images/7th-Heaven-1927-1A3-movie-poster.jpg',
            count: "23"
          },
          {
            title: 'Queens Gambit S1-EP8',
            pic: 'https://freeclassicimages.com/images/20-Million-Miles-To-Earth-07-movie-poster.jpg',
            count: "356"
          },
          {
            title: 'Game of the thrones',
            pic: 'https://freeclassicimages.com/images/69th-St-Vice-01-movie-poster.jpg',
            count: "345"
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
    font-size: 14px;
  }

  .ranktitle {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 12px;
    font-weight: bold;
    color: #000000;
  }

  .subtitle {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 7px;
    font-weight: bold;
    color: #6c757d;
  }

  .subauthor {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 11px;
    font-weight: bold;
    color: #6c757d;
  }

  .side-count {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 14px;
  }
</style>