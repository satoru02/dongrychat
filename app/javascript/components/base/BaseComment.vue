<template>
  <v-container class="ml-n7 mt-n14">
    <v-row>
      <v-col lg=12 class="mb-6">
        <v-list-item>
          <template v-slot:default="{}">
            <v-list-item-avatar size=40 height=40 tile class="rounded-lg">
              <v-img src="https://gravatar.com/avatar/fc04e69ffc05780882f85a264135142c?s=400&d=retro&r=x" />
            </v-list-item-avatar>
            <v-list-item-content>
              <v-list-item-title class="ml-1"
                style="color: #000000; font-weight:bold; font-family: Helvetica Neue, sans-serif; font-size: 12px">
                #ワンダヴィジョン
              </v-list-item-title>
            </v-list-item-content>
            <v-list-item-action class="mt-9 mr-n13">
              <!-- <div :style="listItemAction.style" v-text="'昨日 12:03'" /> -->
            </v-list-item-action>
          </template>
        </v-list-item>
        <v-divider class="mt-1 ml-4" />
      </v-col>
    </v-row>
    <!-- <div class="ml-10">
          <v-divider />

    </div> -->

    <v-list three-line expand disabled class="mt-n8">
      <v-list-item-group active-class="orange--text" multiple class="list-body">
        <template v-for="(n, index) in items">
          <v-list-item :key="index" class="mt-n4">
            <template v-slot:default="{}">
              <v-list-item-avatar size=50 height=50 tile class="rounded-lg">
                <v-img :src="n.av" />
              </v-list-item-avatar>
              <v-list-item-content class="mt-n3">
                <v-list-item-title
                  style="color: #495057; font-weight:bold; font-family: Helvetica Neue, sans-serif; font-size: 14px">
                  trismo
                </v-list-item-title>
                <v-list-item-subtitle class="mt-n8"
                  style="color: #000000; font-weight: 700; font-family: Hiragino Kaku Gothic ProN; font-size: 12px">
                  {{n.text}}
                </v-list-item-subtitle>
              </v-list-item-content>
              <v-list-item-action class="mt-9 mr-n13">
                <div :style="listItemAction.style" v-text="'昨日 12:03'" />
              </v-list-item-action>
            </template>
          </v-list-item>
        </template>
      </v-list-item-group>
    </v-list>
  </v-container>
</template>

<script>
  export default {
    name: 'BaseComment',
    data() {
      return {
        items: [{
            av: 'https://cdn.vuetifyjs.com/images/john.jpg',
            text: '岡本喜八監督の『激動の昭和史 沖縄決戦』は、全ての日本国民にとって必見の作。本土から見捨てられ県民の約3分の1が亡くなった沖縄戦の地獄絵図を夥しいシーン数で表現'
          },
          {
            av: 'https://gravatar.com/avatar/fc04e69ffc05780882f85a264135142c?s=400&d=monsterid&r=x',
            text: 'まさか故・石川賢監督の系譜を継いでいたのは庵野秀明監督だった…？'
          },
          {
            av: 'https://gravatar.com/avatar/fc04e69ffc05780882f85a264135142c?s=400&d=retro&r=x',
            text: 'めちゃおもろかった',
          },
          {
            av: 'https://gravatar.com/avatar/fc04e69ffc05780882f85a264135142c?s=400&d=wavatar&r=x',
            text: 'でも正直ワンダビジョンほど面白くない。',
          },
          {
            av: 'https://cdn.vuetifyjs.com/images/john.jpg',
            text: 'グローグーwwwwwwww'
          },
          {
            av: 'https://gravatar.com/avatar/fc04e69ffc05780882f85a264135142c?s=400&d=retro&r=x',
            text: 'グローグーwwwwwwww'
          },
          {
            av: 'https://gravatar.com/avatar/6016238793b16ba8384d98b5d18d09f9?s=400&d=retro&r=x',
            text: '明日から学校だべ'
          },
          {
            av: 'https://cdn.vuetifyjs.com/images/john.jpg',
            text: 'めちゃおもろかった',
          },
          {
            av: 'https://cdn.vuetifyjs.com/images/john.jpg',
            text: 'めちゃおもろかった',
          }
        ],
        listItemAction: {
          position: 'mt-1',
          style: {
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '7px',
            fontWeight: 'bold',
            color: '#adb5bd'
          }
        },
      }
    }
  }
</script>