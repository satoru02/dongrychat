<template>
  <v-container>
    <base-review-card :user_reviews="reviews" />
    <base-loading :text="loadingText" :handler="infiniteHandler" :wrapper="false" />
  </v-container>
</template>

<script>
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const usersRepository = RepositoryFactory.get('users');

  export default {
    name: "UserReviews",
    components: {
      'base-review-card': () => import( /* webpackPrefetch: true */ '../Base/BaseReviewCard'),
      'base-loading': () => import( /* webpackPrefetch: true */ '../Base/BaseInfiniteLoader')
    },
    props: {},
    data() {
      return {
        page: 1,
        pageSize: 10,
        reviews: [],
        loadingText: '投稿したレビューはまだありません。',
        params: {
          page: '',
          pageSize: ''
        }
      }
    },
    methods: {
      infiniteHandler($state) {
        setTimeout(() => {
          this.params.page = this.page
          this.params.per_page = this.pageSize
          usersRepository.getReviews(this.$route.params.user_id, this.params)
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