<template>
  <v-container>
    <div infinite-wrapper :style="wrapper.style">
      <space-comments :comments="comments" />
      <base-loader :handler="infiniteHandler" :wrapper="true" />
    </div>
    <v-text-field clearable :style="textField.style" :class="textField.grid" :background-color="textField.color"
      v-model="content" @keypress="setMessage()" @keyup.enter="sendComment(content)" dense
      :placeholder="textField.placeholder" solo flat />
  </v-container>
</template>

<script>
  import { secureAxios } from '../../backend/axios';
  import SpaceComments from './SpaceComments';
  import BaseInfiniteLoader from '../Base/BaseInfiniteLoader';
  export default {
    name: 'SpaceChats',
    components: {
      'space-comments': SpaceComments,
      'base-loader': BaseInfiniteLoader,
    },
    props: {
      spaceId: {
        type: Number,
        required: true
      }
    },
    data: function () {
      return {
        comment_endpoint: `/api/v1/comments`,
        page: 1,
        pageSize: 10,
        comments: [],
        content: '',
        params: {
          id: this.spaceId,
          page: '',
          per_page: ''
        },
        canSubmit: false,
        wrapper: {
          style: {
            maxHeight: '450px',
            height: '450px',
            overflow: 'scroll'
          }
        },
        textField: {
          grid: 'mt-1 ml-6 mr-6 rounded-lg',
          color: '#e9ecef',
          placeholder: '#メッセージを送信',
          style: {
            position: 'static'
          }
        }
      }
    },
    created() {
      this.createCable()
    },
    channels: {
      SpaceChannel: {
        connected() {},
        rejected() {},
        received(data) {
          if (data) {
            if (data.attributes.space_id === this.spaceId) {
              this.comments.unshift(data)
            }
          }
        },
        disconnected() {}
      }
    },
    methods: {
      infiniteHandler($state){
        setTimeout(() => {
          this.params.page = this.page
          this.params.per_page = this.pageSize
          secureAxios.get(this.comment_endpoint, {
              params: this.params
            })
            .then(res => {
              if (res.data.data.length) {
                this.page += 1;
                this.comments.push(...res.data.data)
                $state.loaded();
              } else {
                $state.complete();
              }
            })
        }, 50);
      },
      createCable(){
        this.$cable.subscribe({
          channel: 'SpaceChannel',
          space: this.spaceId
        })
      },
      setMessage(){
        this.canSubmit = true
      },
      sendComment(content){
        if(!this.canSubmit){
          return
        }
        if(content){
          this.$cable.perform({
            channel: 'SpaceChannel',
            action: 'speak',
            data: {
              content: content,
              user_id: this.$store.state.currentUser.id,
              user_name: this.$store.state.currentUser.name,
              space_id: this.spaceId,
              avatar_url: ''
            }
          })
          this.content = ''
          this.canSubmit = false
        }
      }
    }
  }
</script>