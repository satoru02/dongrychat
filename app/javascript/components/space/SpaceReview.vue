<template>
  <div class="mt-3">
    <v-card class="mx-auto mb-8 rounded-lg" color="#ffffff" elevation=3 outlined v-for="(review, index) in reviews"
      :key="index">
      <v-card-text class="text-h8 font-weight-bold" style="color:#000000;">
        {{review.attributes.content}}
      </v-card-text>
      <v-card-actions style="background-color: #f6f8fa;">
        <v-list-item class="grow">
          <v-list-item-avatar size="25" color="gray darken-3" @click="goUserPage(review.attributes.user.data.attributes)">
            <v-img :src="review.attributes.user.data.attributes.avatar_url"></v-img>
          </v-list-item-avatar>
          <v-list-item-content>
            <v-list-item-title>
              {{review.attributes.user.data.attributes.name}}
            </v-list-item-title>
          </v-list-item-content>
          <v-row align="center" justify="end">
            <v-icon class="mr-1" small>
              mdi-heart
            </v-icon>
            <span class="subheading mr-2">256</span>
            <span class="mr-1">·</span>
            <v-icon class="mr-1" small>
              mdi-share-variant
            </v-icon>
            <span class="subheading">45</span>
          </v-row>
        </v-list-item>
      </v-card-actions>

    </v-card>
  </div>

</template>

<script>
  export default {
    name: "SpaceReview",
    props: {
      reviews: {
        type: Array,
        required: true
      }
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