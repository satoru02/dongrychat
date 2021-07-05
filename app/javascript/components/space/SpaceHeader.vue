<template>
  <v-container>
    <v-row v-if="space_data" no-gutters>
      <v-col cols=4 sm=4 md=3 lg=3 xl=3 :class="vColAvatarGrid">
        <v-card
          elevation=0
          class="rounded-lg"
          width="230px"
          color="#dee2e6"
          >
          <v-img
            v-if="this.space_data.image_path"
            :src="posterImg()"
            class="white--text mt-n2"
            :height="$vuetify.breakpoint.width > 600 ?  '320px' : '180px'"
          >
          </v-img>
          <v-img height="340px" v-else>
            <icon-base :width="'130'" class="mt-15 ml-13" :height="'140'" icon-name="icon-no-image"
              :iconColor="'#111111'" :viewBox="'0 0 512 512'">
              <icon-no-image />
            </icon-base>
          </v-img>
        </v-card>
      </v-col>
      <v-col cols=8 sm=7 md=8 lg=9 xl=9 :class="$vuetify.breakpoint.width > 600 ? ' mt-8' : 'ml-n4 mt-2'">
        <v-row class="ml-8">
          <base-label :style="'font-weight: bold; border-width: 1.8;'" class="rounded" font_size="13px"
            v-if="space_data.media === media.tv" :label="true" :small="true" :color="'#020814'" :outlined="true"
            :text_color="'#000000'" :season="space_data.season" :episode="space_data.episode"
            :title="space_data.episode_title" />
          <v-chip class="rounded" small v-if="space_data.media === media.mv" outlined label :color="'#020814'"
            :style="vChip.label.style" v-text="'映画'" />
        </v-row>
        <v-row dense class="mt-7" :class="gridTitle">
          <v-col cols=2 sm=1 md=1 lg=1 xl=1 />
          <v-col cols=10 sm=11 md=11 lg=11 xl=11>
            <span :style="contentsTitle"
              @click="space_data.media === media.tv ? moveDetails(space_data.tmdb_comp_id, space_data.name, space_data.season, 'Tv') : moveDetails(space_data.tmdb_mv_id, space_data.name, null, 'Mv')">
              {{space_data.name}}
            </span>
            <icon-base v-if="watched === true" :iconColor="'#0aff99'" class="ml-4 mb-n1" icon-name="icon-check"
              :viewBox="'0 0 191.667 191.667'" :height="'23'" :width="'23'">
              <icon-check />
            </icon-base>
          </v-col>
        </v-row>
        <v-row class="d-flex d-sm-none ml-1">
          <v-col cols=1></v-col>
          <v-col cols=5 sm=5 md=5 lg=5 style="font-weight: bold;">
            <h4>{{this.space_data.watchlist_count}}</h4>
            <p class="" style="font-size: 13px; font-weight: bold;">総視聴数</p>
          </v-col>
          <v-col cols=1 sm=2 md=1 lg=1 class="ml-n4 mb-5 mt-1">
            <v-divider vertical />
          </v-col>
          <v-col cols=4 sm=5 md=5 lg=5 style="font-weight: bold;" class="">
            <h4>4.3</h4>
            <p class="ml-n1" style="font-size: 13px; font-weight: bold;">レビュー</p>
          </v-col>
        </v-row>

        <v-row class="d-none d-sm-flex" style="min-height: 164; max-height: 164;">
          <v-col class="ml-9" cols=11 sm=12 md=12 lg=11 xl=12 :style="vColSummaryStyle"
            v-text="space_data.overview != null ? space_data.overview : dummyText" />
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
  export default {
    name: 'SpaceHeader',
    components: {
      'icon-base': () => import( /* webpackPrefetch: true */ '../Icon/IconBase.vue'),
      'icon-check': () => import( /* webpackPrefetch: true */ '../Icon/IconCheck.vue'),
      'icon-no-image': () => import( /* webpackPrefetch: true */ '../Icon/IconNoImage.vue'),
      'base-label': () => import( /* webpackPrefetch: true */ '../Base/BaseLabel'),
    },
    props: {
      space_data: '',
      watched: Boolean,
    },
    data() {
      return {
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w500`,
        api: {
          for_subscription: `/api/v1/subscriptions`
        },
        media: {
          tv: 'tv',
          mv: 'mv',
        },
        dummyText: '',
        params: {},
        comment: '',
        time: '',
        vColTitle: {
          style: {
            color: '#020814',
            fontWeight: 'bold',
            fontSize: '22px',
            cursor: 'pointer',
            lineHeight: '30px'
          },
          hoverStyle: {
            color: '#3a86ff',
            fontWeight: 'bold',
            fontSize: '22px',
            cursor: 'pointer',
            lineHeight: '30px'
          }
        },
        vChip: {
          title: {
            color: '#f7e733',
            style: {
              color: '#000000',
              fontWeight: 'bold',
            }
          },
          label: {
            yellow: '#f7e733',
            movie: 'Movie',
            style: {
              fontWeight: 'bold',
              fontSize: '13px',
              borderWidth: '1.8',
            }
          },
        },
      }
    },
    methods: {
      moveDetails(id, name, season, media) {
        if (media === 'Tv') {
          this.params = {
            id: id,
            tv_name: name,
            number: season,
          }
        } else if (media === 'Mv') {
          this.params = {
            id: id,
            mv_name: name,
          }
        }
        this.$router.push({
          name: `${media}Details`,
          params: this.params
        })
      },
      posterImg() {
        return this.base_tmdb_img_url + this.space_data.image_path
      },
    },
    computed: {
      gridOverview() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
          case 'sm':
            return 'ml-n12'
          case 'md':
          case 'lg':
          case 'xl':
            return 'ml-n7'
        }
      },
      gridTitle(){
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'ml-n1'
          case 'sm':
            return ''
          case 'md':
            return 'ml-n4'
          case 'lg':
          case 'xl':
            return 'ml-n7'
        }

      },
      vColAvatarGrid() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return ''
          case 'sm':
            return 'mt-7 ml-n3'
          case 'md':
            return 'mt-7 ml-n4'
          case 'lg':
            return 'mt-7 ml-n4'
          case 'xl':
            return 'ml-10 mt-1'
        }
      },
      vColSummaryStyle() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
          case 'sm':
          case 'md':
            return {
              color: '#111111',
              fontWeight: 'bold',
              fontSize: '12px',
            }
          case 'lg':
          case 'xl':
              return {
                color: '#000000',
                fontSize: '13.56px',
                fontWeight: 'bold',
              }
        }
      },
      contentsTitle() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return {
              color: '#020814',
              fontWeight: 'bold',
              fontSize: '16px',
              cursor: 'pointer',
              lineHeight: '30px'
            }
          case 'sm':
          case 'md':
            return {
              color: '#020814',
              fontWeight: 'bold',
              fontSize: '18px',
              cursor: 'pointer',
              lineHeight: '30px'
            }
          case 'lg':
          case 'xl':
              return {
                color: '#020814',
                fontWeight: 'bold',
                fontSize: '22px',
                cursor: 'pointer',
                lineHeight: '30px'
              }
        }
      }
    }
  }
</script>