<template>
  <v-container>
    <base-review-card :space_reviews="reviews" />
    <base-loader :handler="infiniteHandler" :wrapper="false" :text="loader.text" />
  </v-container>
</template>

<script>
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const spacesRepository = RepositoryFactory.get('spaces');

  export default {
    name: "SpaceReviews",
    components: {
      'base-review-card': () => import( /* webpackPrefetch: true */ '../Base/BaseReviewCard'),
      'base-loader': () => import( /* webpackPrefetch: true */ '../Base/BaseInfiniteLoader')
    },
    props: {
      spaceId: {
        type: Number,
        required: true,
      }
    },
    data: function () {
      return {
        page: 1,
        pageSize: 10,
        reviews: [],
        loader: {
          text: 'この作品にはまだレビューがありません。'
        },
        params: {
          id: this.spaceId,
          page: '',
          per_page: ''
        }
      }
    },
    methods: {
      infiniteHandler($state) {
        setTimeout(() => {
          this.params.page = this.page
          this.params.per_page = this.pageSize
          spacesRepository.getReviews(this.spaceId, this.params)
            .then(res => {
              if (res.data.data.length) {
                this.page += 1;
                this.reviews.push(...res.data.data);
                $state.loaded();
              } else {
                $state.complete();
              }
            })
        }, 50)
      }
    }
  }
</script>

<style scoped>
</style>