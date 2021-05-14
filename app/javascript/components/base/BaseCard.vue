<template>
  <div>
    <v-hover v-slot="{ hover }" v-for="(item, index) in items" :key="index">
      <v-card outlined class="rounded-lg mb-8 mt-n4" @click="enterSpace(item.attributes)"
        :style="hover ? card.hoverStyle : card.unhoverStyle" :elevation='hover ? 0 : 0' height="200px">
        <v-row class="mt-1">
          <v-col cols=1 sm=1 md=1 lg=1 xl=1 :class="$vuetify.breakpoint.width > 600 ? 'ml-4 mt-8' : 'mt-8 ml-3 mr-4'"
            :style="ranking.style">
            {{index + 1}}
          </v-col>
          <v-col cols=1 sm=1 md=1 lg=1 xl=1 :class="$vuetify.breakpoint.width > 600 ? 'ml-n8' : 'ml-n10'">
            <v-avatar :class="avatar.round" :size="avatar.size" :height="avatar.height" tile>
              <v-img :src="base_tmdb_img_url + item.attributes.image_path" />
            </v-avatar>
          </v-col>
          <v-col cols=10 sm=10 md=10 lg=10 xl=10 class="ml-3">
            <v-row dense>
              <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
              <v-col cols=10 sm=10 md=10 lg=9 xl=10 :class="$vuetify.breakpoint.width > 600 ? 'ml-n6' : 'ml-4 mt-1'"
                :style="label.style">
                <base-label class="ml-1 mr-3" :x_small="true" :outlined="false" :label="true"
                  v-if="item.attributes.media === media.tv" :color="'#016aff'" :text-color="'#ffffff'"
                  :season="item.attributes.season" :episode="item.attributes.episode"
                  :title="item.attributes.episode_title" />
                <v-chip v-if="item.attributes.media === media.movie" x-small label :color="'yellow'" :style="vchipStyle"
                  v-text="'Movie'" />
              </v-col>
            </v-row>
            <v-row class=mt-5>
              <v-col cols=9 sm=10 md=10 lg=10 xl=10 />
              <v-col cols=1 sm=1 md=1 lg=1 xl=1 class="ml-8 mt-n1">
                <v-badge color="#02e98d" dot />
              </v-col>
              <v-col cols=1 sm=1 md=1 lg=1 xl=1 :class="$vuetify.breakpoint.width > 600 ? 'mt-n4 ml-n8' : 'mt-n4 ml-n4'"
                :style="userCount.style" v-text="item.attributes.users.length" />
            </v-row>
            <v-row class='mt-n12'>
              <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
              <v-col cols=9 sm=10 md=10 lg=10 xl=10 :class="$vuetify.breakpoint.width > 600 ? 'ml-n5' : 'ml-5'"
                :style="listItemTitle.style" v-text="item.attributes.name" />
            </v-row>
            <v-row :class="$vuetify.breakpoint.width > 600 ? 'mt-n3 ml-4' : 'mt-n4 ml-10'">
              <v-col cols=12 sm=12 md=12 lg=7 xl=12 :style="tags.style">
                <v-chip label :class="$vuetify.breakpoint.width > 600 ? 'mr-2' : 'mr-2'" :style="tags.style"
                  v-for="(tag, index) in item.attributes.tag_list.slice(0, 2)" :key="index" color="#e9ecef"
                  v-text="'#' + tag" x-small />
              </v-col>
              <v-col lg=1></v-col>
              <v-col lg=4 class="mt-n1 ml-n5">
                <v-icon color="#5d666e" size=13>
                  mdi-comment-outline
                </v-icon>
                <span :style="numberStyle">123</span>
                <v-icon color="#5d666e" size=13 class="ml-2">
                  mdi-note-outline
                </v-icon>
                <span :style="numberStyle">63</span>
                <v-icon color="#5d666e" size=13 class="ml-2">
                  mdi-television-classic
                </v-icon>
                <span :style="numberStyle">11</span>
              </v-col>
              <!-- <v-col lg=2 class="mt-n1 ml-n10">
                <v-icon color="#6c757d" size=13>
                  mdi-note-outline
                </v-icon>
                <span :style="numberStyle"> 13</span>
              </v-col> -->
            </v-row>
          </v-col>
        </v-row>
        <v-divider class=mt-3 />
        <v-row class="mt-2" dense>
          <v-col lg=1 class="ml-11 mt-n1">
            <v-avatar size="24">
              <v-img src="https://cdn.vuetifyjs.com/images/john.jpg" />
            </v-avatar>
          </v-col>
          <v-col lg=10 :style="nameStyle" class="ml-n7">
            ボニ語ろう <span :style="timeStyle">2日前</span>
          </v-col>
          <v-col lg=1></v-col>
        </v-row>
        <v-row dense class=mt-n3>
          <v-col lg=1>
          </v-col>
          <v-col lg=10 :style="wordStyle" class="ml-2">
            『劇場版「鬼滅の刃」無限列車編』のBlu-ray＆DVD発売を記念したカウントダウン。日まで紡がれる全38日 発売当日まで紡がれる全38日発売当日まで紡がれる全38日間。...
          </v-col>
          <v-col lg=1></v-col>
        </v-row>
      </v-card>
    </v-hover>
  </div>
</template>

<script>
export default {
  name: "BaseCard",
  props: {
    items: '',
    
  }
}
</script>