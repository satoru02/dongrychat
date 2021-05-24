<template>
  <v-container>
    <v-row>
      <v-col lg=12>
        <sub-header class="mb-n2 ml-1 mt-1">
          <template v-slot:notify_header="subHeaderProps">
            <h3 :style="style.headerPart">{{subHeaderProps.sub_header}}</h3>
          </template>
        </sub-header>
        <v-list two-line style="background-color: #ffffff;">
          <v-sheet style="background-color: #ffffff;" class="rounded-lg">
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
    </v-row>
    <base-loader :handler="infiniteHandler" :text="text.loading" />
  </v-container>
</template>

<script>
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const notificationsRepository = RepositoryFactory.get('notifications');

  export default {
    name: "NotificationTop",
    components: {
      'base-loader': () => import(/* webpackPrefetch: true */ '../Base/BaseInfiniteLoader'),
      'sub-header': () => import(/* webpackPrefetch: true */ '../Layout/TheSubHeader')
    },
    data() {
      return {
        error: '',
        notifications: [],
        page: 1,
        pageSize: 10,
        textStyle: {
          fontWeight: 'bold',
          color: '#111111'
        },
        text: {
          loading: '通知はありません。'
        },
        style: {
          headerPart: {
            fontWeight: 'bold',
            fontSize: '17px',
            color: '#111111'
          },
        }
      }
    },
    methods: {
      infiniteHandler($state) {
        setTimeout(() => {
          notificationsRepository.get({
              page: this.page,
              per_page: this.pageSize
            })
            .then(res => {
              console.log(res)
              if (res.data.data.length) {
                this.page += 1
                this.notifications.push(res.data.data)
                $state.loaded()
              } else {
                $state.complete();
              }
            })
        }, 50);
      }
    }
  }
</script>