<template>
  <v-container class="tag-container">
    <sub-header class="mb-n9 mt-1" :tag='this.$route.params.name'>
      <template v-slot:tag_header="subHeaderProps">
        <h3 class="sub-header">{{subHeaderProps.sub_header}}</h3>
      </template>
    </sub-header>
    <v-divider class="mt-5 mb-10" />
    <base-card :items='spaces' />
    <base-loader :handler="infiniteHandler" :text="text.loading" />
  </v-container>
</template>

<script>
  import {
    secureAxios
  } from '../../backend/axios';
  import BaseInfiniteLoader from '../Base/BaseInfiniteLoader';
  import BaseCard from '../Base/BaseCard';
  import TheSubHeader from '../Layout/TheSubHeader';

  const api_tag_url = `/api/v1/tags`
  export default {
    name: "TagTop",
    components: {
      'sub-header': TheSubHeader,
      'base-loader': BaseInfiniteLoader,
      'base-card': BaseCard
    },
    data() {
      return {
        spaces: [],
        page: 1,
        pageSize: 10,
        error: '',
        text: {
          loading: 'このタグに登録されたスペースはまだありません。'
        }
      }
    },
    methods: {
      infiniteHandler($state) {
        setTimeout(() => {
          secureAxios.get(api_tag_url + `/` + this.$route.params.id, {
              params: {
                page: this.page,
                per_page: this.pageSize
              }
            })
            .then(res => {
              if (res.data.data.length) {
                this.page += 1
                this.spaces.push(...res.data.data)
                $state.loaded()
              } else {
                $state.complete();
              }
            })
        }, 0)
      },
      fetchFailed(err) {
        this.error = (err.response && err.response.data && err.response.data.error) || ""
        this.$router.replace('/')
      }
    }
  }
</script>

<style scoped>
  .tag-container {
    font-family: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif';
  }

  .theme--light.v-divider {
    border-color: rgba(0,0,0,.04);
  }

  .sub-header {
    font-weight: bold;
    font-size: 19px;
    color: #111111;
  }
</style>