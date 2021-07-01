<template>
  <div class="mt-3">
    <div class="ml-14" v-if="space_reviews">
      <v-card class="mb-8 rounded-lg" color="#edf1f3" elevation=0
        v-for="(review, index) in space_reviews" :key="index">
        <v-card-text class="text-h7 font-weight-bold" style="color:#000000;">
          {{review.attributes.content}}
        </v-card-text>
        <v-card-actions style="background-color: #edf1f3;">
          <v-list-item>
            <v-list-item-avatar size="25" color="gray darken-3"
              @click="goUserPage(review.attributes.user.data.attributes)">
              <v-img v-if="review.attributes.user.data.attributes.avatar_url"
                :src="review.attributes.user.data.attributes.avatar_url"></v-img>
              <span v-else>
                <icon-base :width="'20'" :height="'20'" icon-name="icon-user" :iconColor="'#ffffff'"
                  :viewBox="'-42 0 512 512.002'">
                  <icon-user />
                </icon-base>
              </span>
            </v-list-item-avatar>
            <v-list-item-content>
              <v-list-item-title style="font-weight: bold; font-size: 11px;">
                {{review.attributes.user.data.attributes.name}}
              </v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-card-actions>
      </v-card>
    </div>

    <v-container v-if="user_reviews">
      <v-card class="mx-auto mb-8 rounded-lg" color="#edf1f3" elevation=0 outlined
        v-for="(review, index) in user_reviews" :key="index">
        <v-card-text class="text-h7 font-weight-bold" style="color:#000000;">
          {{review.attributes.content}}
        </v-card-text>
        <v-card-actions style="background-color: #f6f8fa;">
          <v-list-item class="grow">
            <v-list-item-content>
              <v-list-item-title>
                {{review.attributes.space.name}}
              </v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-card-actions>
      </v-card>
    </v-container>
  </div>
</template>

<script>
  export default {
    name: "BaseReviewCard",
    components: {
      'icon-base': () => import( /* webpackPrefetch */ '../Icon/IconBase'),
      'icon-user': () => import( /* webpackPrefetch */ '../Icon/IconUser'),
    },
    props: {
      space_reviews: {
        type: Array,
      },
      user_reviews: {
        type: Array,
      },
    },
    methods: {
      goUserPage(user) {
        this.$router.push({
          name: 'UserTop',
          params: {
            user_name: user.name,
            user_id: user.id
          }
        })
      },
    }
  }
</script>


