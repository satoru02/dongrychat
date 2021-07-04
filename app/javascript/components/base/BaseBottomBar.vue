<template>
  <v-bottom-navigation grow app height=80 v-if="$vuetify.breakpoint.width < 600 && this.checkRoute()"
    background-color="#ffffff">
    <v-btn @click="movePath('Home')">
      <span>ホーム</span>
      <icon-base :iconColor="'#657482'" icon-name="icon-home" :width="'23'" :height="'23'"
        :viewBox="'0 0 512.05 512.05'">
        <icon-home />
      </icon-base>
    </v-btn>
    <v-btn @click="movePath('Following')">
      <span>チャット</span>
      <icon-base :iconColor="'#657482'" icon-name="icon-following" :width="'23'" :height="'23'"
        :viewBox="'0 0 512.05 512.05'">
        <icon-following />
      </icon-base>
    </v-btn>
    <v-btn @click="movePath('Search')">
      <span>レビュー</span>
      <icon-base :iconColor="'#657482'" icon-name="icon-pen" :width="'23'" :height="'23'"
        :viewBox="'0 0 512.05 512.05'">
        <icon-pen/>
      </icon-base>
    </v-btn>
  </v-bottom-navigation>
</template>

<script>
  export default {
    name: "BottomNavigation",
    components: {
      'icon-base': () => import( /* webpackPrefetch */ '../Icon/IconBase'),
      'icon-home': () => import( /* webpackPrefetch: true */ '../Icon/IconHome.vue'),
      'icon-pen': () => import( /* webpackPrefetch: true */ '../Icon/IconPen.vue'),
      'icon-following': () => import( /* webpackPrefetch: true */ '../Icon/IconFollowing.vue')
    },
    methods: {
      checkRoute() {
        let validationRouter = ['MvSpace',
          'MvSpaceMembers',
          'MvSpaceReviews',
          'MvSpaceNews',
          'subscribedMvSpace',
          'subscribedMvSpaceMembers',
          'subscribedMvSpaceReviews',
          'subscribedMvSpaceNews',
          'TvSpace',
          'TvSpaceMembers',
          'TvSpaceReviews',
          'TvSpaceNews',
          'subscribedTvSpace',
          'subscribedTvSpaceMembers',
          'subscribedTvSpaceReviews',
          'subscribedTvSpaceNews',
        ]
        if (validationRouter.includes(this.$route.name)) {
          return false
        } else {
          return true
        }
      },
      movePath(path_name) {
        this.$router.push({
          name: path_name
        })
      }
    }
  }
</script>