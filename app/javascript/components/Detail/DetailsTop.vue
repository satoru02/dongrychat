<template>
  <v-container :class="vContainerGrid">
    <v-row :class="vRowContentsGrid">
      <v-col cols=2 sm=2 md=2 lg=2 xl=2 :class="vAvatarGrid">
        <v-avatar :class="'rounded-lg'" :size="heading.avatar.size" :height="heading.avatar.height">
          <v-img v-if="details.poster_path" :src="base_tmdb_img_url + details.poster_path" />
        </v-avatar>
      </v-col>
      <v-col v-if="this.$vuetify.breakpoint.width < 600" cols=2 />
      <v-col cols=7 sm=9 md=9 lg=9 xl=9 class="ml-10">
        <v-row>
          <v-col cols=12 sm=9 md=9 lg=9 xl=9 :class="vColNameGrid" :style="style.contentsTitle">
            <h3 v-if="media === 'tv'" v-text="this.$route.params.tv_name" />
            <h3 v-else v-text="this.$route.params.mv_name" />
          </v-col>
        </v-row>
        <v-row dense :class="'mt-n6'">
          <v-col cols=12 sm=12 md=12 lg=12 xl=12 :class="vColSubNameGrid" :style="style.subContentsTitle">
            <h3 v-if="media === 'tv'" v-text="'@' + this.$route.params.tv_name" />
            <h3 v-else v-text="'@' + this.$route.params.mv_name" />
          </v-col>
        </v-row>
        <v-row>
          <v-col cols=12 sm=12 md=12 lg=12 xl=12 :class="vColDetailsGrid">
            <div :style="style.contentsDetails" v-text="details.overview" />
          </v-col>
        </v-row>
        <v-row :class="'mt-3'" v-if="this.$vuetify.breakpoint.width > 600">
          <v-col cols=5 sm=2 md=2 lg=2 xl=2 :class="vColCreditGrid" :style="style.credit" v-text="text.credit" />
          <v-col cols=3 sm=3 md=3 lg=3 xl=3 :class="'ml-n10'" :style="style.person"
            v-for="(credit, index) in overall.created_by" :key="index" v-text="credit.name" />
        </v-row>
        <v-row :class="'mt-n1 ml-1'" v-if="this.$vuetify.breakpoint.width > 600">
          <v-col cols=4 sm=2 md=2 lg=2 xl=2 :class="vColGenreGrid" :style="style.credit" v-text="text.genre" />
          <v-col cols=8 sm=8 md=8 lg=8 xl=8 :class="'ml-n10'">
            <v-chip :class="'mr-4 mb-2'" :style="style.tag" v-for="(genre, index) in this.genres" :key="index"
              :color="style.chip" small v-text="genre" />
          </v-col>
        </v-row>
      </v-col>
    </v-row>

    <v-row v-if="this.$vuetify.breakpoint.width < 600">
      <v-col cols=12>
        <v-chip :class="'mr-4 mt-n2'" :style="style.tag" v-for="(genre, index) in this.genres" :key="index"
          :color="style.chip" small v-text="genre" />
        </v-col>
    </v-row>

    <v-tabs hide-slider v-if="(media === 'tv') && (overall.seasons)" :class="vTabsGrid" :style="style.tabs"
      background-color='#ffffff' :height="'40'" :width="tabs.width" :color="'blue'">
      <v-tab :active-class="'black--text'" :style="style.tab" @click="changeSeason(index+1)"
        v-for="(season, index) in overall.seasons.length" :key="index">
        {{text.season}} {{index + 1}}
      </v-tab>
    </v-tabs>
    <v-divider v-if="media === 'tv'" />

    <v-row v-if="media === 'tv'">
      <v-col cols=12 sm=12 md=12 lg=12 xl=12>
        <v-list :style="style.list">
          <v-list-item-group v-for="(episode, index) in details.episodes" :key="index" :active-class="list_part.active">
            <v-hover v-slot="{hover}">
              <v-list-item :class="'rounded-lg'" :style="hover ? style.hoverList : style.list"
                @click="enterTvSpace(episode)">
                <v-list-item-avatar :class="list_part.avatar.round" :size="list_part.avatar.size"
                  :height="list_part.avatar.height">
                  <v-img :src="base_tmdb_img_url + episode.still_path" />
                </v-list-item-avatar>
                <v-list-item-content>
                  <v-list-item-title :style="style.episodeDetails">
                    <span :class="'mr-2'" :style="style.caption">{{index + 1}}</span> {{episode.name}}
                  </v-list-item-title>
                  <v-list-item-subtitle :class="'mt-2'" :style="style.overview" v-text="episode.overview" />
                </v-list-item-content>
              </v-list-item>
            </v-hover>
            <v-divider :key="index" />
          </v-list-item-group>
        </v-list>
      </v-col>
    </v-row>

    <v-row v-else class="mt-n3">
      <v-col cols=12 sm=12 md=12 lg=12 xl=12>
        <v-list :style="style.list">
          <v-list-item-group :active-class="list_part.active">
            <v-hover v-slot="{hover}">
              <v-list-item :class="'rounded-lg'" :style="hover ? style.hoverList : style.list"
                @click="enterMovieSpace(details)">
                <v-list-item-avatar :class="list_part.avatar.round" :size="list_part.avatar.size"
                  :height="list_part.avatar.height">
                  <v-img :src="base_tmdb_img_url + details.backdrop_path" />
                </v-list-item-avatar>
                <v-list-item-content>
                  <v-list-item-title :style="style.episodeDetails" v-text="details.title" />
                  <v-list-item-subtitle :class="'mt-1'" :style="style.overview" v-text="details.overview" />
                </v-list-item-content>
              </v-list-item>
            </v-hover>
          </v-list-item-group>
        </v-list>
      </v-col>
    </v-row>

    <v-dialog v-model="loginDialog" width="400" transition="dialog-top-transition">
      <v-card :class="'rounded-lg'" color="#ffffff" height="250">
        <v-row>
          <v-col cols=3 sm=3 md=3 lg=3 xl=3 />
          <v-col cols=7 sm=7 md=7 lg=7 xl=7>
            <div :class="'mt-9 ml-5'" :style="dialog.headerStyle" v-text="'Devioを使ってみる'"/>
          </v-col>
        </v-row>
        <v-row>
          <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          <v-col cols=10 sm=10 md=10 lg=10 xl=10>
            <v-btn @click="goLogin()" block　:style="dialog.btnStyle" color="black" outlined elevation=0
              v-text="'ログイン'" />
          </v-col>
        </v-row>
        <v-row>
          <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
          <v-col cols=10 sm=10 md=10 lg=10 xl=10>
            <v-btn block @click="goSignup()" :style="dialog.btnStyle" color="#016aff" elevation=0 v-text="'アカウント作成'" />
          </v-col>
        </v-row>
        <v-row>
          <v-col cols=3 sm=3 md=3 lg=3 xl=3 />
          <v-col cols=8 sm=8 md=8 lg=9 xl=8>
            <div :class="'ml-1'" :style="dialog.policyStyle" v-text="'利用規約とプライバシーポリシーはこちら'" />
          </v-col>
        </v-row>
      </v-card>
    </v-dialog>

  </v-container>
</template>

<script>
  import { RepositoryFactory } from '../../repositories/RepositoryFactory';
  const tmdbRepository = RepositoryFactory.get('tmdb');

  export default {
    name: 'DetailsTop',
    data() {
      return {
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w500`,
        loginDialog: false,
        details: [],
        overall: [],
        genres: [],
        error: '',
        number: '',
        media: 'tv',
        tv_space: 'TvSpace',
        movie_space: 'MvSpace',
        tabActive: 'white--text',
        heading: {
          avatar: {
            size: '165',
            height: '235',
          },
        },
        list_part: {
          active: 'black--text',
          avatar: {
            size: '80',
            height: '80',
            round: 'rounded-lg'
          },
        },
        tabs: {
          width: '70px',
        },
        text: {
          credit: 'クレジット',
          genre: 'ジャンル',
          season: 'シーズン'
        },
        style: {
          caption: {
            fontSize: '15px',
            fontWeight: 'bold',
            color: '#111111'
          },
          contentsTitle: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue sans-serif',
            fontSize: '16px',
            color: '#111111'
          },
          subContentsTitle: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue sans-serif',
            fontSize: '10px',
            color: '#6c757d',
          },
          contentsDetails: {
            fontSize: '12px',
            fontWeight: 'bold',
            color: '#111111',
            height: '90px',
            maxHeight: '90px',
            overflow: 'scroll',
            overflowY: 'scroll',
          },
          credit: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue sans-serif',
            fontSize: '12px',
            color: '#6c757d',
          },
          person: {
            fontWeight: 'bold',
            fontFamily: 'Helvetica Neue sans-serif',
            fontSize: '12px',
            color: '#111111',
          },
          tag: {
            color: '#ffffff',
            fontWeight: 'bold',
            fontSize: '11px'
          },
          tab: {
            fontWeight: 'bold',
            fontSize: '11px',
            color: '#6c757d'
          },
          tabs: {
            color: '#0e0e10',
            fontWeight: 'bold',
            fontSize: '13px',
          },
          episodeDetails: {
            fontSize: '14px',
            fontWeight: 'bold',
            color: '#111111',
          },
          overview: {
            fontSize: '11px',
            fontWeight: 'bold',
            color: '#666666',
          },
          list: {
            backgroundColor: '#ffffff'
          },
          hoverList: {
            backgroundColor: '#f6f6f9'
          },
          chip: '#293241'
        },
        dialog: {
          headerStyle: {
            color: '#111111',
            fontWeight: 'bold',
            fontSize: '17px',
          },
          btnStyle: {
            color: '#ffffff',
            fontWeight: 'bold',
            fontSize: '12px',
          },
          policyStyle: {
            color: '#6c757d',
            fontSize: '4px',
          }
        }
      }
    },
    created() {
      if (this.$route.name === 'TvDetails') {
        this.media = 'tv'
        this.getTvContents(this.$route.params.number)
        this.getTvOverall()
      } else if (this.$route.name === 'MvDetails') {
        this.media = 'mv'
        this.getMvContents()
      }
    },
    watch: {
      "$route.params.number"() {
        this.details = []
        this.media = 'tv'
        this.getTvContents(this.$route.params.number)
      }
    },
    beforeRouteEnter(to, from, next) {
      next(vm => {
        if (vm.media === 'tv') {
          document.title = `${vm.$route.params.tv_name} - Devio` || 'Devio';
        } else {
          document.title = `${vm.$route.params.mv_name} - Devio` || 'Devio';
        }
      })
    },
    beforeRouteUpdate(to, from, next) {
      if (this.media === 'tv') {
        document.title = `${this.$route.params.tv_name} - Devio` || 'Devio';
      } else {
        document.title = `${this.$route.params.mv_name} - Devio` || 'Devio';
      }
      next()
    },
    methods: {
      getTvContents(number) {
        tmdbRepository.getTvInfo(this.$route.params.id, number)
          .then(res => this.setTvDetails(res))
          .catch(err => this.fetchFailed(err))
      },
      getMvContents() {
        tmdbRepository.getMvInfo(this.$route.params.id)
          .then(res => this.setMvDetails(res))
          .catch(err => this.fetchFailed(err))
      },
      setTvDetails(res) {
        this.details = res.data
      },
      setMvDetails(res) {
        this.details = res.data
        this.genres = this.setGenres(this.details.genres)
      },
      getTvOverall() {
        tmdbRepository.getOverall(this.$route.params.id)
          .then(res => this.setOverall(res))
          .catch(err => this.fetchFailed(err))
      },
      setOverall(res) {
        this.overall = res.data
        this.genres = this.setGenres(this.overall.genres)
      },
      setGenres(content_genres) {
        var ary = []
        for (var i = 0; i < content_genres.length; i++) {
          ary.push(content_genres[i].name)
        }
        return ary
      },
      fetchFailed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ''
      },
      changeSeason(number) {
        this.$router.replace({
          name: 'TvDetails',
          params: {
            id: this.$route.params.id,
            number: number,
            tv_name: this.$route.params.tv_name
          }
        })
      },
      enterTvSpace(tv_data) {
        if (!this.$store.state.signedIn) {
          this.loginDialog = true
        } else {
          this.$router.push({
            name: this.tv_space,
            params: {
              season_number: tv_data.season_number,
              episode_number: tv_data.episode_number,
              name: this.$route.params.tv_name,
              episode_title: tv_data.name,
              tmdb_comp_id: this.overall.id,
              tmdb_tv_id: this.details.id,
              image_path: this.details.poster_path,
              media: this.media,
              overview: tv_data.overview,
              tag_list: this.genres,
            }
          })
        }
      },
      enterMovieSpace(details) {
        if (!this.$store.state.signedIn) {
          this.loginDialog = true
        } else {
          this.$router.push({
            name: this.movie_space,
            params: {
              image_path: details.poster_path,
              tmdb_mv_id: details.id,
              name: this.$route.params.mv_name,
              media: this.media,
              overview: details.overview,
              tag_list: this.genres
            }
          })

        }
      },
      goLogin() {
        this.$router.replace('/login')
      },
      goSignup() {
        this.$router.replace('/signup')
      }
    },
    computed: {
      vContainerGrid(){
        switch(this.$vuetify.breakpoint.name){
          case 'xs' : return 'mt-n12 ml-16'
          case 'sm' : return ''
          case 'md' : return ''
          case 'lg' : return 'mt-n12'
          case 'xl' : return ''
        }
      },
      vRowContentsGrid(){
        switch(this.$vuetify.breakpoint.name){
          case 'xs' : return 'mt-6 ml-n6'
          case 'sm' : return ''
          case 'md' : return ''
          case 'lg' : return 'mt-7 ml-n7'
          case 'xl' : return ''
        }
      },
      vAvatarGrid(){
        switch(this.$vuetify.breakpoint.name){
          case 'xs' : return 'ml-4 mt-3'
          case 'sm' : return ''
          case 'md' : return ''
          case 'lg' : return 'ml-6 mt-3'
          case 'xl' : return ''
        }
      },
      vColNameGrid(){
        switch(this.$vuetify.breakpoint.name){
          case 'xs' : return 'mt-4 ml-2'
          case 'sm' : return ''
          case 'md' : return ''
          case 'lg' : return 'mt-4 ml-n2'
          case 'xl' : return ''
        }
      },
      vColSubNameGrid(){
        switch(this.$vuetify.breakpoint.name){
          case 'xs' : return 'mt-2 ml-2'
          case 'sm' : return ''
          case 'md' : return ''
          case 'lg' : return 'mt-2 ml-n2'
          case 'xl' : return ''
        }
      },
      vColDetailsGrid(){
        switch(this.$vuetify.breakpoint.name){
          case 'xs' : return 'mt-n2 ml-2'
          case 'sm' : return ''
          case 'md' : return ''
          case 'lg' : return 'mt-n2 ml-n2'
          case 'xl' : return ''
        }
      },
      vColCreditGrid(){
        switch(this.$vuetify.breakpoint.name){
          case 'xs' : return 'ml-2'
          case 'sm' : return ''
          case 'md' : return ''
          case 'lg' : return 'ml-n2'
          case 'xl' : return ''
        }
      },
      vColGenreGrid(){
        switch(this.$vuetify.breakpoint.name){
          case 'xs' : return 'mt-1'
          case 'sm' : return ''
          case 'md' : return ''
          case 'lg' : return 'ml-n6 mt-1'
          case 'xl' : return ''
        }
      },
      vTabsGrid(){
        switch(this.$vuetify.breakpoint.name){
          case 'xs' : return 'mt-2'
          case 'sm' : return ''
          case 'md' : return ''
          case 'lg' : return 'mt-6'
          case 'xl' : return ''
        }
      }
    }
  }
</script>

<style scoped>
  .theme--light.v-divider {
    border-color: rgba(73, 73, 73, 0.06);
  }
</style>