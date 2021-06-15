<template>
  <v-list two-line style="background-color: #ffffff;">
    <v-list-item-group v-for="(item, index) in items" :key="index" multiple>
      <v-hover v-slot="{hover}">
        <v-list-item class="rounded-lg" @click="showContents(item)"
          :style="hover ? 'background-color: #f6f6f9;' : 'background-color: #ffffff;'">
          <v-list-item-avatar :size='55' :width='55' class="rounded-lg">
            <v-img v-if="item.poster_path" :src="base_tmdb_img_url + item.poster_path" />
            <v-img v-else size="30" height="30">
              <poster-path />
            </v-img>
          </v-list-item-avatar>
          <v-list-item-content>
            <v-list-item-title class="mb-2" v-if="media === 'tv'" :style="listItemStyle" v-text="item.name" />
            <v-list-item-title class="mb-2" v-if="media === 'movie'" :style="listItemStyle"
              v-text="item.title" />
            <v-list-item-subtitle :style="subtitleStyle" v-text="item.overview" />
          </v-list-item-content>
        </v-list-item>
      </v-hover>
    </v-list-item-group>
  </v-list>
</template>

<script>
  export default {
    name: "BaseList",
    components: {
      'icon-poster':() => import(/* webpackPrefetch: true */ '../Icon/IconPoster'),
    },
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