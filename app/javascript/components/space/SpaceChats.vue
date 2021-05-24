<template>
  <div class="mt-4">
    <div infinite-wrapper :style="wrapper.style">
      <space-comments :comments="comments" />
      <base-loader :handler="infiniteHandler" :wrapper="true" :text="loader.text" />
    </div>
    <v-text-field
      v-if="$vuetify.breakpoint.width > 600"
      :class="textFieldGrid"
      clearable :style="textField.style" :background-color="textField.color"
      v-model="content" @keypress="setMessage()" @keyup.enter="sendComment(content)" dense
      :placeholder="textField.placeholder" solo flat />
    <v-text-field
      v-else
      :append-outer-icon="'mdi-send'"
      :class="textFieldGrid"
      clearable :style="textField.style" :background-color="textField.color"
      @click:append-outer="{setMessage(), sendComment(content)}"
      v-model="content" dense
      :placeholder="textField.placeholder" solo flat />
  </div>
</template>

<script>
  import SpaceComments from './SpaceComments';
  import BaseInfiniteLoader from '../Base/BaseInfiniteLoader';
  import { RepositoryFactory } from '../../repositories/RepositoryFactory';
  const spacesRepository = RepositoryFactory.get('spaces');

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
      },
    },
    data: function () {
      return {
        page: 1,
        pageSize: 10,
        comments: [],
        content: '',
        canSubmit: false,
        loader: {
          text: 'このスペースにはまだコメントがありません。',
        },
        params: {
          id: this.spaceId,
          page: '',
          per_page: ''
        },
        wrapper: {
          style: {
            maxHeight: '395px',
            height: '395px',
            overflow: 'scroll',
          }
        },
        textField: {
          color: '#f6f6f9',
          placeholder: '#メッセージを送信',
          style: {
            position: 'static',
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
          try {
            if (data) {
              if (data.attributes.space_id === this.spaceId) {
                this.comments.unshift(data)
              }
            }
          } catch (e) {
            if (e instanceof TypeError) {}
          }
        },
        disconnected() {}
      }
    },
    methods: {
      infiniteHandler($state) {
        setTimeout(() => {
          this.params.page = this.page
          this.params.per_page = this.pageSize
          spacesRepository.getComments(this.spaceId, this.params)
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
      createCable() {
        this.$cable.subscribe({
          channel: 'SpaceChannel',
          space: this.spaceId
        })
      },
      setMessage() {
        this.canSubmit = true
      },
      sendComment(content) {
        if (!this.canSubmit) {
          return
        }
        if (content) {
          this.$cable.perform({
            channel: 'SpaceChannel',
            action: 'speak',
            data: {
              content: content,
              user_id: this.$store.state.user.currentUser.id,
              user_name: this.$store.state.user.currentUser.name,
              space_id: this.spaceId,
              avatar_url: ''
            }
          })
          this.content = ''
          this.canSubmit = false
        }
      }
    },
    computed: {
      textFieldGrid(){
        switch(this.$vuetify.breakpoint.name) {
          case 'xs' : return 'mt-n2 rounded-s'
          case 'sm' : return 'mt-7'
          case 'md' : return 'mt-7'
          case 'lg' : return 'mt-n4 rounded-s'
          case 'xl' : return 'mt-2 ml-6 mr-6 rounded-s'
        }
      }
    }
  }
</script>