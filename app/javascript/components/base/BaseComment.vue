<template>
  <v-container :class="space_top.position">
    <v-row :class="space_top.row">
      <v-col md=12 lg=12 xl=12 :class="space_top.col">
        <v-list-item>
          <template v-slot:default="{}">
            <v-list-item-avatar :size="space_top.avatar.size" :height='space_top.avatar.height' tile :class="space_top.avatar.round">
              <v-img src="https://gravatar.com/avatar/fc04e69ffc05780882f85a264135142c?s=400&d=retro&r=x" />
            </v-list-item-avatar>
            <v-list-item-content>
              <v-list-item-title :class="space_top.title.position"
                :style="space_top.title.style" v-text="'ワンダヴィジョン-season1/episode1'" />
              <v-list-item-subtitle :class="space_top.subtitle.position"
                :style="space_top.subtitle.style" v-text="'167人のメンバー'" />
            </v-list-item-content>
          </template></v-list-item>
        <v-divider :class="divider.position" />
      </v-col>
    </v-row>

    <v-row :class="comment.row" v-for="(n,index) in items" :key="index">
      <v-col md=1 lg=1 xl=1 :class="comment.col">
        <v-avatar :class="comment.avatar.class" tile :size='comment.avatar.size' :height='comment.avatar.height'>
          <img src="https://gravatar.com/avatar/fc04e69ffc05780882f85a264135142c?s=400&d=retro&r=x">
        </v-avatar>
      </v-col>
      <v-col md=10 lg=10 xl=10 :class="comment.inner_col">
        <v-row>
          <v-col md=3 lg=3 xl=3>
            <div :style="comment.style.username" v-text="'username'" />
          </v-col>
          <v-col md=8 lg=8 xl=8 />
          <v-col md=1 lg=1 xl=1 :class="comment.countClass">
            <div :style="comment.style.count" v-text="'46分前'" />
          </v-col>
        </v-row>
        <v-row :class="comment.text_row">
          <v-col md=12 lg=12 xl=12>
            <div :style="comemnt.style.content" v-text="''" />
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
  export default {
    name: 'BaseComment',
    data() {
      return {
        items: [],
        space_top: {
          position: 'ml-n5 mt-n14',
          row: 'ml-n1',
          col: 'mb-6',
          avatar: {
            size: '40',
            height: '40',
            round: 'rounded-lg'
          },
          title: {
            position: 'ml-1 mt-n3',
            style: {
              color: '#000000',
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '13px'
            }
          },
          subtitle: {
            position: 'ml-1 mb-n2 mt-1',
            style: {
              color: '#000000',
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '6px'
            }
          }
        },
        comment: {
          row: 'mt-3',
          col: 'ml-5 mt-n3',
          inner_col: 'ml-n3',
          countClass: 'mt-1',
          text_row: 'mt-n6',
          avatar: {
            class: 'rounded-lg mt-3',
            size: '40',
            height: '40'
          },
          style: {
            username: {
              color: '#495057',
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '13px'
            },
            count: {
              color: '#495057',
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '9px'
            },
            content: {
              color: '#000000',
              fontWeight: 'bold',
              fontFamily: 'Helvetica Neue, sans-serif',
              fontSize: '13px'
            }
          }
        },
        listItemAction: {
          position: 'mt-1',
          style: {
            fontFamily: 'Helvetica Neue, sans-serif',
            fontSize: '7px',
            fontWeight: 'bold',
            color: '#adb5bd'
          }
        },
        divider: {
          position: 'mt-3 ml-4 mb-n5'
        }
      }
    }
  }
</script>