<template>
  <v-container>

    <v-row v-if="$vuetify.breakpoint.width < 600" class="mb-6">
      <v-col cols=6>
        <v-card elevation=0 :class="'rounded-lg'" width=270 height="300" color="#e9ecef">
          <v-img width=270 height="300" v-if="details.poster_path"
            :src="base_tmdb_img_url + details.poster_path" />
        </v-card>
      </v-col>
      <v-col cols=6>
        <h3 v-if="media === 'tv'">
          {{this.$route.params.tv_name}}
          <span class="ml-2">
            <v-btn x-small color="#fcf300" elevation=0 style="font-weight: bold; font-size: 13px;" class="rounded-xl">
              {{overall.vote_average}}</v-btn>
          </span>
        </h3>
        <h3 v-else>
          {{this.$route.params.mv_name}}
          <span class="ml-2">
            <v-btn x-small color="#fcf300" elevation=0 style="font-weight: bold; font-size: 13px;" class="rounded-xl">
              {{details.vote_average}}</v-btn>
          </span>
        </h3>
        <v-btn style="font-weight:bold;" color="#f6f8fb" class="mt-4" x-small elevation=0>カテゴリー</v-btn>
        <v-chip-group column class="mt-3">
          <v-chip x-small active-class="blue--text" outlined class="mb-3 rounded-lg"
            style="width: auto; font-weight: bold;" color="#000000" label
            v-for="(genre, index) in this.genres.slice(0,3)" :key="index">
            {{genre}}
          </v-chip>
        </v-chip-group>
      </v-col>
    </v-row>


    <v-row class="mt-5">

      <v-col cols=2 sm=4 md=4 lg=3 xl=3 v-if="$vuetify.breakpoint.width > 600">
        <v-card elevation=0 :class="'rounded-lg'" width=300 height="370" color="#e9ecef">
          <v-img width=300 height="370" v-if="details.poster_path"
            :src="base_tmdb_img_url + details.poster_path" />
        </v-card>
        <h2 class="mt-5" v-if="media === 'tv'">
          {{this.$route.params.tv_name}}
          <span class="ml-2">
            <v-btn small color="#fcf300" elevation=0 style="font-weight: bold; font-size: 15px;" class="rounded-xl">
              {{overall.vote_average}}</v-btn>
          </span>
        </h2>
        <h2 class="mt-5" v-else>
          {{this.$route.params.mv_name}}
          <span class="ml-2">
            <v-btn small color="#fcf300" elevation=0 style="font-weight: bold; font-size: 15px;" class="rounded-xl">
              {{details.vote_average}}</v-btn>
          </span>
        </h2>
        <v-btn style="font-weight:bold;" color="#f6f8fb" class="mt-4" small elevation=0>カテゴリー</v-btn>
        <v-chip-group column class="mt-3">
          <v-chip small active-class="blue--text" outlined class="mb-3 rounded-lg"
            style="width: auto; font-weight: bold;" color="#000000" label
            v-for="(genre, index) in this.genres.slice(0,3)" :key="index">
            {{genre}}
          </v-chip>
        </v-chip-group>
      </v-col>

      <v-col cols=12 sm=7 md=7 lg=8 xl=8 class="mt-n8">
        <v-row>
          <v-col cols=12 sm=12 md=12 lg=12 xl=12>
            <v-tabs mobile-breakpoint="xs"  :class="$vuetify.breakpoint.width > 600 ? 'ml-8 mt-5': ''" :style="style.tabs"
              background-color='#ffffff' :width="tabs.width" :color="'blue'">
              <v-tabs-slider color="#42ccff"></v-tabs-slider>
              <v-tab :active-class="'black--text'" :style="style.tab" v-for="(content, index) in contents" :key="index">
                <icon-base class="mr-3" v-if="content === '概要'" :iconColor="'#6c757d'" icon-name="icon-overview"
                  :width="'15'" :height="'15'" :viewBox="'0 0 512.0005 512'">
                  <icon-overview />
                </icon-base>
                <icon-base class="mr-2" v-if="content === 'クリエイター'" :iconColor="'#6c757d'" icon-name="icon-creator"
                  :width="'17'" :height="'17'" :viewBox="'0 0 274.341 274.341'">
                  <icon-creator />
                </icon-base>
                <icon-base class="mr-3" v-if="content === '出演者&スタッフ'" :iconColor="'#6c757d'" icon-name="icon-staff"
                  :width="'15'" :height="'15'" :viewBox="'0 0 512 512'">
                  <icon-staff />
                </icon-base>
                {{content}}
              </v-tab>
            </v-tabs>
            <v-divider class="ml-8" />
          </v-col>
        </v-row>
        <v-row no-gutters>
          <v-col cols=9 sm=9 md=9 lg=10 xl=10></v-col>
          <v-col cols=1 sm=1 md=1 lg=1 xl=1 v-if="(media === 'tv') && (overall.seasons)">
            <v-menu offset-y v-if="overall.seasons.length > 1">
              <template v-slot:activator="{ on, attrs }">
                <v-btn class="rounded mb-n2" small elevation=0 color="#212529" style="font-weight: bold;" dark
                  v-bind="attrs" v-on="on">
                  シーズン選択
                </v-btn>
              </template>
              <v-list>
                <v-list-item @click="changeSeason(index+1)" v-for="(season, index) in (this.overall.seasons.length - 1)"
                  :key="index">
                  <v-list-item-title>シーズン {{index + 1}}</v-list-item-title>
                </v-list-item>
              </v-list>
            </v-menu>
          </v-col>
        </v-row>
        <v-row v-if="media === 'tv'" :class="$vuetify.breakpoint.width > 600 ? 'ml-5': ''">
          <v-col cols=12 sm=12 md=6 lg=4 xl=4 v-for="(episode, index) in details.episodes" :key=index>
            <v-card v-if="episode.still_path" @click="enterTvSpace(episode)" elevation=0 class="rounded-lg">
              <v-img position="under" gradient="to bottom, rgb(81 81 85 / 1%), rgb(0 0 0 / 90%)"
                class="white--text align-end rounded-lg" :src="base_tmdb_img_url + episode.still_path">
                <v-btn label :color="media === 'tv' ? '#00bbf9' : '#ff0054'" x-small class="elevation-0 ml-3 rounded-lg"
                  alt="" style="font-size: 14px; font-weight: bold; color: #ffffff;">
                  第{{index + 1}}話
                </v-btn>
                <span v-if="media === 'tv'" class="ml-1"
                  style="font-size: 11px; font-weight: bold; color: #ffffff;">{{episode.air_date}}・初放送</span>
                <span v-if="media === 'movie'" class="ml-1"
                  style="font-size: 11px; font-weight: bold; color: #ffffff;">{{item.release_date}}・初公開</span>
                <v-card-title v-if="media === 'tv'" style="font-weight: bold; line-height: 22px; font-size: 18px;">
                  {{episode.name}}
                </v-card-title>
                <v-card-title v-if="media === 'movie'" style="font-weight: bold; line-height: 22px; font-size: 18px;">
                  {{episode.title}}
                </v-card-title>
              </v-img>
            </v-card>
            <v-card v-else @click="enterTvSpace(episode)" elevation=0 class="rounded-lg" color="#f6f8fb" height="165px">
              <v-img class="white--text align-end rounded-lg">
                <v-btn label :color="media === 'tv' ? '#00bbf9' : '#ff0054'" x-small class="elevation-0 ml-3 rounded-lg"
                  alt="" style="font-size: 14px; font-weight: bold; color: #ffffff;">
                  第{{index + 1}}話
                </v-btn>
                <span v-if="media === 'tv'" class="ml-1"
                  style="font-size: 11px; color: #595959">{{episode.air_date}}・初放送</span>
                <span v-if="media === 'movie'" class="ml-1"
                  style="font-size: 11px; color: #595959">{{item.release_date}}・初公開</span>
                <v-card-title v-if="media === 'tv'" style="color: #595959; line-height: 22px; font-size: 18px;">
                  {{episode.name}}
                </v-card-title>
                <v-card-title v-if="media === 'movie'" style="color: #595959; line-height: 22px; font-size: 18px;">
                  {{episode.title}}
                </v-card-title>
                <v-card-subtitle class="mt-2" style="line-height: 22px; font-size: 14px; color: #595959;">
                  イメージ画像がまだ登録されていません。
                </v-card-subtitle>
              </v-img>
            </v-card>
          </v-col>
        </v-row>
        <v-row v-else :class="$vuetify.breakpoint.width > 600 ? 'ml-5': ''">
          <v-col cols=12 sm=12 md=6 lg=6 xl=6>
            <v-card @click="enterMovieSpace(details)" elevation=0 class="rounded-lg">
              <v-img v-if="details.backdrop_path" position="under"
                gradient="to bottom, rgb(81 81 85 / 1%), rgb(0 0 0 / 90%)" class="white--text align-end rounded-lg"
                :src="base_tmdb_img_url + details.backdrop_path">
                <v-btn label :color="media === 'tv' ? '#00bbf9' : '#ff0054'" x-small class="elevation-0 ml-3 rounded-lg"
                  alt="" style="font-size: 14px; font-weight: bold; color: #ffffff;">
                  映画
                </v-btn>
                <v-card-title style="font-weight: bold; line-height: 22px; font-size: 18px;">
                  {{details.release_date}}
                </v-card-title>
              </v-img>
            </v-card>
          </v-col>
        </v-row>
      </v-col>
    </v-row>

    <v-dialog v-model="loginDialog" width="400" transition="dialog-top-transition">
      <v-card :class="'rounded-lg'" color="#ffffff" height="250">
        <v-row>
          <v-col cols=3 sm=3 md=3 lg=3 xl=3 />
          <v-col cols=7 sm=7 md=7 lg=7 xl=7>
            <div :class="'mt-9 ml-5'" :style="dialog.headerStyle" v-text="'DongryChatを使ってみる'" />
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
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const tmdbRepository = RepositoryFactory.get('tmdb');

  export default {
    name: 'DetailsTop',
    components: {
      'icon-base': () => import( /* webpackPrefetch: true */ '../Icon/IconBase.vue'),
      'icon-overview': () => import( /* webpackPrefetch: true */ '../Icon/IconOverview.vue'),
      // 'icon-creator': () => import( /* webpackPrefetch: true */ '../Icon/IconCreator.vue'),
      // 'icon-staff': () => import( /* webpackPrefetch: true */ '../Icon/IconStaff.vue'),
      'icon-no-image': () => import( /* webpackPrefetch */ '../Icon/IconNoImage.vue'),
    },
    data() {
      return {
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w500`,
        loginDialog: false,
        creators: '',
        credits: '',
        contents: [
          '概要',
          // 'クリエイター',
          // '出演者&スタッフ',
          // 'その他',
        ],
        details: [],
        overall: [],
        genres: [],
        error: '',
        number: '',
        media: 'tv',
        tv_space: 'TvSpace',
        movie_space: 'MvSpace',
        tabs: {
          width: '70px',
        },
        style: {
          tab: {
            fontWeight: 'bold',
            fontSize: '18px',
            color: '#6c757d'
          },
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
        this.getMediaOverall('tv')
      } else if (this.$route.name === 'MvDetails') {
        this.media = 'mv'
        this.getMvContents()
        this.getCredits()
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
          document.title = `${vm.$route.params.tv_name} - DongryChat` || 'DongryChat';
        } else {
          document.title = `${vm.$route.params.mv_name} - DongryChat` || 'DongryChat';
        }
      })
    },
    beforeRouteUpdate(to, from, next) {
      if (this.media === 'tv') {
        document.title = `${this.$route.params.tv_name} - DongryChat` || 'DongryChat';
      } else {
        document.title = `${this.$route.params.mv_name} - DongryChat` || 'DongryChat';
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
      getMediaOverall(media_type) {
        tmdbRepository.getOverall(this.$route.params.id, media_type)
          .then(res => this.setOverall(res))
          .catch(err => this.fetchFailed(err))
      },
      getCredits(){
        tmdbRepository.getMovieCredits(this.$route.params.id)
          .then((res) => {
            this.credits = res.data
          })
          .catch(err => this.fetchFailed(err))
      },
      setOverall(res) {
        this.overall = res.data
        this.genres = this.setGenres(this.overall.genres)
        this.creators = this.setCreators(this.overall.created_by)
      },
      setGenres(content_genres) {
        var genres = []
        for (var i = 0; i < content_genres.length; i++) {
          genres.push(content_genres[i].name)
        }
        return genres
      },
      setCreators(creators){
        var creators_names = []
        for (var i = 0; i < creators.length; i ++){
          creators_names.push(creators[i].name)
        }
        return creators_names
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
        if (!this.$store.state.user.signedIn) {
          this.loginDialog = true
        } else {
          this.$router.push({
            name: this.tv_space,
            params: {
              season_number: tv_data.season_number,
              episode_number: tv_data.episode_number,
              air_date: tv_data.air_date,
              name: this.$route.params.tv_name,
              episode_title: tv_data.name,
              tmdb_comp_id: this.overall.id,
              tmdb_tv_id: this.details.id,
              image_path: this.details.poster_path,
              media: this.media,
              overview: tv_data.overview,
              tag_list: this.genres,
              creators: this.creators,
              homepage: this.overall.homepage
            }
          })
        }
      },
      enterMovieSpace(details) {
        if (!this.$store.state.user.signedIn) {
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
              tag_list: this.genres,
              air_date: details.release_date,
              homepage: details.homepage
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
      bindContentsDetails() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return {
              fontSize: '10px',
                fontWeight: 'bold',
                color: '#111111',
            }
            case 'sm':
            case 'md':
            case 'lg':
              return {
                fontSize: '14px',
                  fontWeight: 'bold',
                  color: '#111111',
              }
              case 'xl':
                return ''
        }
      }
    }
  }
</script>

<style scoped>
</style>