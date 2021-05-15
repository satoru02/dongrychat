<template>
<v-container class="ml-n5">
  <v-card outlined class="rounded-lg mt-2 ml-n16" style="max-height: 257px">
    <v-img elevation="0" height="133" width="685" src="https://source.unsplash.com/random"></v-img>
    <v-card-title :style="nameStyle">
      <v-avatar size="60">
        <v-img src="https://cdn.vuetifyjs.com/images/john.jpg" />
      </v-avatar>
      <span class="ml-3 mt-n8">石野ぺえ</span><span class="ml-1 mt-n8" :style="subnameStyle">@apusdf12s</span>
      <v-spacer />
      <v-btn class="mt-n8" small elevation=0 outlined :style="btnText">フォロー</v-btn>
    </v-card-title>

    <v-row class="mt-n16 ml-n1">
      <v-col lg=1>
      </v-col>
      <v-col lg=2 class="mt-n13 ml-n7">
        <!-- <span :style="countStyle">123</span><span :style="textStyle"> フォロワー</span> -->
      </v-col>
      <v-col lg=1 class="mt-n11 ml-n9">
        <v-icon size=18 color="#6b7280">
          mdi-github
        </v-icon>
      </v-col>
      <v-col lg=1 class="mt-n11 ml-n5">
        <v-icon size=18 color="#6b7280">
          mdi-twitter
        </v-icon>
      </v-col>
      <v-col lg=1 class="mt-n11 ml-n5">
        <v-icon size=18 color="#6b7280">
          mdi-facebook
        </v-icon>
      </v-col>
      <v-col lg=1 class="mt-n11 ml-n5">
        <v-icon size=18 color="#6b7280">
          mdi-instagram
        </v-icon>
      </v-col>
    </v-row>

    <v-row class="mt-5">
      <v-col lg=1>
      </v-col>
      <v-col lg=3 class="mt-n11 ml-n7">
        <span :style="countStyle">123</span><span :style="textStyle"> スペース</span>
      </v-col>
      <!-- <v-col lg=3 class="mt-n11 ml-n11">
        <span :style="countStyle">13</span><span :style="textStyle"> レビュー</span>
      </v-col> -->
      <v-col lg=2 class="mt-n11 ml-n13">
        <span :style="countStyle">3</span><span :style="textStyle"> フォロー</span>
      </v-col>
      <v-col lg=2 class="mt-n11 ml-n5">
        <span :style="countStyle">3</span><span :style="textStyle"> フォロワー</span>
      </v-col>
      <!-- <v-col lg=2>
      </v-col> -->
      <v-col lg=2 class="mt-n11 ml-n1">
      <v-icon size=18 color="#6b7280">
          mdi-map-marker-outline
        </v-icon>
        <span :style="textStyle">京都</span>
      </v-col>
    </v-row>
  </v-card>
    <v-tabs class="ml-n16 mt-4"
      background-color='#ffffff' :height="'35'" :color="'#016aff'">
      <v-tab :style="tabStyle" :active-class="'blue--text'"
        v-for="(n,index) in items" :key="index">
        {{n}}
      </v-tab>
    </v-tabs>
    <v-divider class="ml-n16" />
  </v-container>
</template>

<script>
  export default {
    name: "UserTop",
    data() {
      return {
        items: [
          'プロフィール',
          '投稿',
          // 'レビュー',
          // 'お気に入り',
          // 'リンク',
          // 'コミュニティ'
        ],
        nameStyle: {
          fontWeight: 'bold',
          color: '#011627',
          fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
          fontSize: '18px',
          lineHeight: '28px'

        },
        subnameStyle: {
          fontWeight: 'bold',
          color: '#4b5563',
          fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
          fontSize: '13px',
          lineHeight: '28px'

        },
        countStyle: {
          fontWeight: 'bold',
          color: '#111111',
          fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
          fontSize: '14px',
          lineHeight: '28px'
        },
        textStyle: {
          // fontWeight: 'bold',
          color: '#4b5563',
          fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
          fontSize: '12px',
          lineHeight: '28px'
        },
        btnText: {
          fontWeight: 'bold',
          color: '#000000',
          fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
          fontSize: '12px',
          lineHeight: '28px'
        },
        aboutStyle: {
          // fontWeight: 'bold',
          color: '#4b5563',
          fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
          fontSize: '13px',
          lineHeight: '28px'
        },
        tabStyle: {
          fontWeight: 'bold',
          color: '#4b5563',
          fontFamily: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif',
          fontSize: '12px',
          lineHeight: '28px'
        }
      }
    }
  }
</script>

<style scoped>
  .v-tabs-slider-wrapper {
    height: 0.6px;
    left: 0px;
    width: 307px;
}
  .v-card__subtitle,
  .v-card__text,
  .v-card__title {
    padding-bottom: 75px;
  }

  .v-divider {
    border-color: rgba(102, 102, 102, 0.06);
  }

  .v-input__slot::before {
    border-style: none !important;
    color: #fafafa;
    /* color: #98989b */
  }

  .theme--light.v-sheet--outlined {
    /* border: thin solid rgba(164, 164, 165, 0.12); */
    border: thin solid rgba(121, 121, 121, 0.12);
    /* border: thin solid rgba(182, 182, 182, 0.788); */
  }

  .v-divider--vertical.v-divider--inset {
    margin-top: 2px;
    min-height: 0;
    max-height: calc(45% - 16px);
    margin-top: 43px;
  }
</style>