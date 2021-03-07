<template>
<div>
<v-row>
  <v-col cols=5 class="ml-4 mt-3">
    <featured-content />
  </v-col>
  <v-col>
    <v-row>
      <v-col cols=12 class="mt-3 card-title">
        <h3>マンダロリアン</h3>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=12 class="mt-n4">
        <div style="font-size: 0.7rem;">
          The Mandalorian, or Mando for short, is a fictional character in the Star Wars.
        </div>
      </v-col>
    </v-row>
  </v-col>
</v-row>

<v-row>
  <v-col cols=12 class="mt-n3">
     <v-list two-line>
        <v-list-item-group style="background-color: #ffffff" active-class="orange--text" multiple>
          <template v-for="(n, index) in items" >
            <v-list-item :key="index">
              <template v-slot:default="{ }">
                <div class="mr-5 ranktitle">{{index + 1}}</div>
                <v-list-item-content class=ml-1>
                  <v-list-item-title class="card-title" v-html="n.title"></v-list-item-title>
                  <v-list-item-subtitle v-html="n.name" class="subtitle">
                  </v-list-item-subtitle>
                </v-list-item-content>
                <v-list-item-action>
                  <div class="subtitle">{{n.count}}人が会話中</div>
                </v-list-item-action>
              </template>
            </v-list-item>
          </template>
        </v-list-item-group>
      </v-list>
  </v-col>
</v-row>
</div>

</template>

<script>
import BaseContentSheet from '../base/BaseContentSheet'
import ContentDiscussion from '../contents/ContentDiscussion';
import FeaturedContent from '../top/TopFeaturedContents'

export default {
  name: 'ContentPage',
  components:{
    'base-content-sheet': BaseContentSheet,
    'content-discussion': ContentDiscussion,
    'featured-content': FeaturedContent
  },
  data(){
    return{
        items: [
          // {
          //   title: 'マンダロリアン',
          //   pic: 'https://freeclassicimages.com/images/7th-Heaven-1927-1A3-movie-poster.jpg',
          //   count: "99+",
          //   name:"2時間30分"
          // },
          {
            title: 'マンダロリアン',
            pic: 'https://freeclassicimages.com/images/7th-Heaven-1927-1A3-movie-poster.jpg',
            count: "99+",
            name:"第1話 45分"
          },
          {
            title: '友達',
            pic: 'https://freeclassicimages.com/images/20-Million-Miles-To-Earth-07-movie-poster.jpg',
            count: "3",
            name:"第2話 45分"
          },
          {
            title: '果てしない道',
            pic: 'https://freeclassicimages.com/images/69th-St-Vice-01-movie-poster.jpg',
            count: "3",
            name:"第3話 45分"
          },
          {
            title: 'どうなるのか',
            pic: 'https://freeclassicimages.com/images/Abigail-Leslie-Is-Back-In-Town-01-movie-poster.jpg',
            count: "4",
            name:"第4話 45分"
          },
          {
            title: '秘密',
            pic: 'https://freeclassicimages.com/images/Abigail-Leslie-Is-Back-In-Town-01-movie-poster.jpg',
            count: "4",
            name:"第5話 45分"
          },
          {
            title: '我らが道',
            pic: 'https://freeclassicimages.com/images/Abigail-Leslie-Is-Back-In-Town-01-movie-poster.jpg',
            count: "4",
            name:"第6話 45分"
          }
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

  .subtitle {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 10px;
    font-weight: bold;
    color: #6c757d;
  }

  .ranktitle {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 12px;
    font-weight: bold;
    color: #000000;
  }

  .side-count {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 14px;
  }
</style>