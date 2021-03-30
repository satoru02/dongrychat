<template>
  <v-container>
    <v-list-item-group active-class="orange--text" multiple class="list-body">
      <template v-for="(item, index) in 6">
        <v-list-item :key="index">
          <template v-slot:default="{}">
            <v-list-item-avatar size=58 height=58 tile class="rounded-lg">
              <v-img src="https://cdn.vuetifyjs.com/images/john.jpg" alt="John" />
            </v-list-item-avatar>
            <v-list-item-content class=ml-1>
              <v-list-item-title class="card-title">
                username
              </v-list-item-title>
              <v-list-item-subtitle class="subtitle mt-1">
                username
              </v-list-item-subtitle>
            </v-list-item-content>
            <v-list-item-action class="ml-n5">
              <v-btn elevation=0
                :style="followingStyle"
              >
                {{ unfollowText }}
              </v-btn>
            </v-list-item-action>
          </template>
        </v-list-item>
      </template>
    </v-list-item-group>
  </v-container>
</template>

<script>
  export default {
    name: "UserRelationships",
    props: {
      relationships: {
        type: Array,
        required: true
      }
    },
    data() {
      return {
        followingText: 'フォローした',
        followingStyle: {
          backgroundColor: "#343a40",
          fontWeight: "bold",
          fontSize: "10px",
          width: 100,
          height: 40,
          elevation: 0
        },
        unfollowText: 'フォローする',
        unfollowStyle: {
          backgroundColor: "#2d00f7",
          fontWeight: "bold",
          fontSize: "10px",
          width: 120,
          height: 25
        },
      }
    }
  }
</script>

<style scoped>
  .list-body {
    background-color: #ffffff;
  }

  .card-title {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 15px;
    color: #000000;
  }

  .head-title {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 28px;
    color: #000000;
  }

  .subtitle {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 12px;
    font-weight: bold;
    color: #6c757d;
  }

  .comment {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 11px;
    font-weight: bold;
    color: #121213;
  }
</style>