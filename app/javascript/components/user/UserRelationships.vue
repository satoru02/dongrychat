<template>
<v-container>
  <v-row>
    <v-col lg=12 v-for="(user, index) in relationships" :key="index">
      <p>{{ user.attributes.name }}</p>
    </v-col>
  </v-row>
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
  }
}
</script>