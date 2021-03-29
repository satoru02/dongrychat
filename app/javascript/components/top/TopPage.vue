<template>
  <v-container>
    <h1 class="ml-3 mb-1 head-title">ホーム</h1>
    <v-list two-line>
      <v-list-item-group active-class="orange--text" multiple class="list-body">
        <template v-for="(item, index) in items">
          <v-list-item :key="index" @click="enterSpace(item)">
            <template v-slot:default="{}">
              <v-badge v-if="item.attributes.unread_comments > 0" color="red"
                :content='item.attributes.unread_comments' style="font-weight:bold;" right offset-x="31" offset-y="29"
                overlap>
                <v-list-item-avatar size=66 height=66 tile class="rounded-lg">
                  <v-img :src="base_tmdb_img_url + item.attributes.image_path" />
                </v-list-item-avatar>
              </v-badge>
              <v-list-item-avatar v-else size=66 height=66 tile class="rounded-lg">
                <v-img :src="base_tmdb_img_url + item.attributes.image_path" />
              </v-list-item-avatar>
              <v-list-item-content class=ml-1>
                <!-- <v-list-item-title class="card-title" v-html="item.attributes.name" /> -->
                <v-list-item-title class="card-title">
                  {{item.attributes.name}} （338）
                </v-list-item-title>
                <v-list-item-subtitle class="subtitle mt-1">
                  Season{{item.attributes.season}}-{{item.attributes.episode}}
                   {{item.attributes.episode_title}}
                </v-list-item-subtitle>
              </v-list-item-content>
              <v-list-item-action class="ml-n16">
                <div class="comment">受信したメッセージ・・・</div>
                 <!-- <v-avatar class="ml-n16" color="green" :size="24" v-if="item.attributes.unread_comments > 0">
                   <span class="white--text font-weight-bold subtitle">{{item.attributes.unread_comments}}</span></v-avatar> -->
              </v-list-item-action>
            </template>
          </v-list-item>
        </template>
      </v-list-item-group>
    </v-list>
  </v-container>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios';
  const SPACES_ENDPOINT = `/api/v1/spaces`;

  export default {
    name: 'TopPage',
    data() {
      return {
        items: [],
        base_tmdb_img_url: `https://image.tmdb.org/t/p/w500`,
        error: null,
      }
    },
    channels: {
      TopsubChannel: {
        connected() {},
        rejected() {},
        received(data) {
          this.items.filter((item) => {
            if ((item.attributes.id === data["space_id"]) && (this.$store.state.currentUser.id != data[
              "user_id"])) {
              item.attributes.unread_comments += 1
            }
          });
        },
        disconnected() {}
      }
    },
    created() {
      this.getSubscription()
    },
    methods: {
      getSubscription() {
        secureAxios.get(SPACES_ENDPOINT, {
            params: {
              user_id: this.$store.state.currentUser.id
            }
          })
          .then(res => this.createCable(res.data.data))
          .catch(err => this.getFailed(err))
      },
      createCable(spaces) {
        this.items = spaces
        this.$cable.subscribe({
          channel: 'TopsubChannel',
        })
      },
      getFailed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ''
      },
      enterSpace(item) {
        if (item.attributes.media === 'tv') {
          this.$router.push({
            name: 'subscribedTvSpace',
            params: {
              space_id: item.attributes.id,
            }
          })
        } else if (item.attributes.media === 'mv') {
          this.$router.push({
            name: 'subscribedMvSpace',
            params: {
              space_id: item.attributes.id,
            }
          })
        }
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
    font-size: 17px;
    color: #000000;
  }

  .head-title {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 22px;
    color: #000000;
  }

  .subtitle {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 13px;
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