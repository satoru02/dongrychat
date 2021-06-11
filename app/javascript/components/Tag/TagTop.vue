<template>
  <v-container :key="componentKey">

    <!-- <v-img class="rounded-lg mt-2" height="93" src="https://source.unsplash.com/random" /> -->

    <sub-header class="mt-1" :tag='this.$route.params.name'>
      <template v-slot:tag_header="subHeaderProps">
        <div :class="gridSubHeader">
          {{subHeaderProps.sub_header}}
        </div>
      </template>
    </sub-header>

    <v-divider class="mt-5 mb-10" />

    <base-card :items='spaces' />
    <base-loader :handler="infiniteHandler" :text="text.loading" />
  </v-container>
</template>

<script>
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const tagsRepository = RepositoryFactory.get('tags');

  export default {
    name: "TagTop",
    components: {
      'sub-header': () => import( /* webpackPrefetch: true */ '../Layout/TheSubHeader'),
      'base-loader': () => import( /* webpackPrefetch: true */ '../Base/BaseInfiniteLoader'),
      'base-card': () => import( /* webpackPrefetch: true */ '../Base/BaseCard')
    },
    data() {
      return {
        spaces: [],
        componentKey: 0,
        page: 1,
        pageSize: 10,
        error: '',
        text: {
          loading: 'このタグに登録されたスペースはまだありません。'
        }
      }
    },
    watch: {
      '$route.params.name'() {
        this.page = 1
        this.spaces = []
        this.forceRerender()
      }
    },
    gridSubHeader() {
      switch (this.$vuetify.breakpoint.name) {
        case 'xs':
          return 'sub-header mb-n5 mt-1 ml-2'
        case 'sm':
        case 'md':
        case 'lg':
        case 'xl':
          return 'sub-header mb-2 mt-4'
      }
    },
    beforeRouteEnter(to, from, next) {
      next(vm => {
        setTimeout(() => {
          document.title = `${vm.$route.params.name} |  Devio` || 'Devio';
        }, 0)
      })
    },
    // beforeRouteUpdate(to, from, next) {
    //     setTimeout(() => {
    //       document.title = to.params.name
    //     }, 0)
    // },
    methods: {
      forceRerender() {
        this.componentKey += 1
      },
      infiniteHandler($state) {
        setTimeout(() => {
          tagsRepository.getSpaces(this.$route.params.name, {
              page: this.page,
              per_page: this.pageSize
            })
            .then(res => {
              if (res.data.data.length) {
                this.page += 1
                this.spaces.push(...res.data.data)
                $state.loaded()
              } else {
                $state.complete();
              }
            })
        }, 0)
      },
      fetchFailed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ""
        this.$router.replace('/')
      }
    }
  }
</script>

<style scoped>
  .theme--light.v-divider {
    border-color: rgba(0, 0, 0, .04);
  }

  .sub-header {
    font-weight: bold;
    font-size: 15px;
    color: #111111;
  }
</style>