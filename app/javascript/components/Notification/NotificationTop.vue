<template>
  <v-container>
    <v-row>
      <v-col lg=2></v-col>
      <v-col lg=10>
        <v-list two-line style="background-color: #121214;">
          <v-sheet style="background-color: #161b22;" class="rounded-lg">
            <template v-for="(notification, index) in notifications">
              <v-list-item :key="index">
                <v-list-item-avatar>
                  <v-img :src="notification[0].attributes.sender.data.attributes.avatar_url"></v-img>
                </v-list-item-avatar>
                <v-list-item-content :style="textStyle">
                  <v-list-item-title v-text="`${notification[0].attributes.sender.data.attributes.name}にフォローされました。`">
                  </v-list-item-title>
                </v-list-item-content>
              </v-list-item>
            </template>
          </v-sheet>
        </v-list>
      </v-col>
      <!-- <v-col lg=1></v-col> -->
    </v-row>
    <base-loader :handler="infiniteHandler" :text="text.loading" />
  </v-container>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios';
  import BaseInfiniteLoader from '../Base/BaseInfiniteLoader';

  export default {
    name: "NotificationTop",
    components: {
      'base-loader': BaseInfiniteLoader
    },
    data() {
      return {
        error: '',
        notifications: [],
        page: 1,
        pageSize: 10,
        textStyle: {
          fontWeight: 'bold',
          fontFamily: 'Helvetica Neue, sans-serif',
          color: '#ced4da'
        },
        text: {
          loading: '通知はありません。'
        },
      }
    },
    methods: {
      infiniteHandler($state) {
        setTimeout(() => {
          secureAxios.get(`/api/v1/notifications`, {
              params: {
                page: this.page,
                per_page: this.pageSize
              }
            })
            .then(res => {
              if (res.data.data.length) {
                this.page += 1
                this.notifications.push(res.data.data)
                $state.loaded()
              } else {
                $state.complete();
              }
            })
        }, 0);
      }
    }
  }
</script>