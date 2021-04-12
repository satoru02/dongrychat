<template>
  <v-row :class="space_top.row">
    <v-col md=12 lg=12 xl=12 :class="space_top.col">
      <v-list three-line>
        <v-list-item multiple>
          <template v-slot:default="{}">
            <v-list-item-avatar :size="space_top.avatar.size" :height='space_top.avatar.height' tile
              :class="space_top.avatar.round">
              <v-img :src="base_tmdb_img_url + space_data.image_path" />
            </v-list-item-avatar>
            <v-list-item-content>
              <v-list-item-title :class="space_top.title.position" :style="space_top.title.style">
                {{space_data.name}}
                <v-chip class="ml-2" small>235</v-chip>
                <!-- <base-label class="ml-2" v-if="space_data.media === media.tv" :color="colors.chip"
                  :text-color="colors.chip" :season="space_data.season" :episode="space_data.episode"
                  :title="space_data.episode_title" /> -->
              </v-list-item-title>
              <v-list-item-subtitle :class="space_top.subtitle.position" :style="space_top.atmark.style"
                v-text="'@ワンダビジョン'" />
              <v-list-item-subtitle :class="space_top.subtitle.position" :style="space_top.subtitle.style"
             >
                <base-label v-if="space_data.media === media.tv" :color="colors.chip"
                  :text-color="colors.chip" :season="space_data.season" :episode="space_data.episode"
                  :title="space_data.episode_title" />
                   <!-- <v-chip small outlined label v-text="displayDetails()" :color="color" :text-color="textColor" /> -->
              </v-list-item-subtitle>
              <v-list-item-subtitle
               :class="space_top.dis.position" :style="space_top.dis.style"
                v-text="'正義の象徴を失った世界を救ファルコンとウィンター・ソルジャーの新たな戦いを描くクライム・アクション開幕！ これは、新たな”キャプテン・アメリカ”誕生'">
              </v-list-item-subtitle>
              <!-- <v-list-item-subtitle class="ml-1" :style="space_top.fav.style"
                v-text="'mdi-heart' + space_data.users.length"> -->
                <v-list-item-subtitle class="ml-1" :style="space_top.fav.style"
                >
                <v-icon class="mt-n1" size="17">mdi-account</v-icon>
                1348人がお気に入り中
              <v-icon class="ml-2" size="17">mdi-chat</v-icon>
                134
                <v-chip class="ml-5" x-small>TV</v-chip>
              </v-list-item-subtitle>
            </v-list-item-content>
            <v-list-item-action>
                <v-btn outlined elevation=0 :style="space_top.btn.style" class="ml-10 mt-1" small color="black">
                  チャットに参加する
                </v-btn>
                <!-- <v-btn class=mt-3 outlined elevation=0 height="30" width=135 color=black>
                 <v-icon>mdi-dots-horizontal</v-icon>
                </v-btn> -->
            </v-list-item-action>
          </template></v-list-item>
      </v-list>
      <v-divider :class="divider.position" />
    </v-col>
  </v-row>
</template>

<script>
  import BaseLabel from '../Base/BaseLabel';
  export default {
    name: 'SpaceHeader',
    components: {
      'base-label': BaseLabel
    },
    props: {
      space_data: {
        type: Object
      }
    },
    data() {
      return {
        style: {
          listItemTitle: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '14px',
          },
        },
        media: {
          tv: 'tv',
          mv: 'mv',
        },
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w200`,
        colors: {
          chip: 'black',
          notifyBtn: 'red'
        },
        space_top: {
          position: 'mt-n7',
          row: 'ml-1 mt-6',
          col: 'mb-6 ml-n5',
          avatar: {
            size: '115',
            height: '165',
            round: 'rounded-lg'
          },
          title: {
            position: 'ml-1 mb-n4',
            style: {
              color: '#000000',
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '17px'
            }
          },
          atmark: {
            position: 'ml-1 mb-n6',
            style: {
              color: '#495057',
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '11px'
            }
          },
          subtitle: {
            position: 'ml-1',
            style: {
              color: '#000000',
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '11px'
            }
          },
          fav: {
            position: 'ml-1',
            style: {
              color: '#343a40',
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '11px'
            }
          },
          dis: {
            position: 'mt-1 ml-1',
            style: {
              color: '#000000',
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '12px'
            }
          },
          btn: {
            position: 'ml-1 mt-n2',
            style: {
              color: '#ffffff',
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '11px'
            }
          }
        },
        divider: {
          position: 'mt-n1 mb-n8'
        },
      }
    },
    methods: {}
  }
</script>