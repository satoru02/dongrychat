<template>
  <div>
    <v-row>
      <!-- <v-col lg=9></v-col> -->
      <v-col lg=1 class="ml-n4">
        <v-btn @click="openReviewDialog()" elevation=0 outlined small color="black" class="rounded ml-7 mt-4">レビューを書く</v-btn>
      </v-col>
    </v-row>
    <base-review-card :space_reviews="reviews" />
    <base-loader :handler="infiniteHandler" :wrapper="false" :text="loader.text" />
    <v-dialog width="400" v-model="reviewDialog">
      <v-card color="#ffffff" auto-grow height="460" class="rounded-lg">
        <v-card-title></v-card-title>
        <v-card-text>
          <v-container>
            <v-row class="mt-n6">
              <v-col lg=12>
                <v-textarea auto-grow row-height="63" v-model="reviewContent"
                  :rules="[rules.requiredContents, rules.maxLengthOfContents]" placeholder="感想・レビューを記入する。" outlined flat
                  solo></v-textarea>
              </v-col>
            </v-row>
            <v-row class="mt-n3">
              <v-col lg=12>
                <v-btn @click="makeReviews()" block elevation=0 color="blue">登録する</v-btn>
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const spacesRepository = RepositoryFactory.get('spaces');
  const reviewsRepository = RepositoryFactory.get('reviews');

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
        reviewDialog: false,
        reviewContent: '',
        rules: {
          // requiredTitle: (v) => !!v || 'タイトルを入力してください。',
          // maxLengthOfTitle: (v) => v.length <= 100 || '100字以下のタイトルを入力してください。',
          requiredContents: (v) => !!v || '内容を入力してください。',
          maxLengthOfContents: (v) => v.length <= 255 || '255字以下の内容を入力してください。'
        },
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
      },
      makeReviews() {
        reviewsRepository.post({
            user_id: this.$store.state.user.currentUser.id,
            space_id: this.spaceId,
            content: this.reviewContent
          })
          .then(res => this.postSuccessful(res))
          .catch(err => this.failed(err))
      },
      postSuccessful(res) {
        this.reviewDialog = false
        this.$router.go(0)
      },
      openReviewDialog() {
        this.reviewDialog = true
      },
    }
  }
</script>

<style scoped>
</style>