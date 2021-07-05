<template>
  <v-container>
    <v-row>
      <v-col cols=12 sm=12 md=12 lg=12 xl=12 :class="$vuetify.breakpoint.width > 600 ? 'ml-5' : '' ">
        <v-text-field :class="textFieldGrid" clearable background-color="#ffffff"
          v-model="content" @keypress="setMessage()" @keyup.enter="sendComment(content)" solo flat outlined dense
          :placeholder="textField.placeholder" />
      </v-col>
    </v-row>
    <space-comments :comments="comments" />
    <base-loader :handler="infiniteHandler" :wrapper="false" :text="loader.text" />
  </v-container>
</template>

<script>
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const spacesRepository = RepositoryFactory.get('spaces');

  export default {
    name: 'SpaceChats',
    components: {
      'space-comments': () => import( /* webpackPrefetch: true */ './SpaceComments'),
      'base-loader': () => import( /* webpackPrefetch: true */ '../Base/BaseInfiniteLoader'),
      'icon-base': () => import( /* webpackPrefetch: true */ '../Icon/IconBase'),
      'icon-comment': () => import( /* webpackPrefetch: true */ '../Icon/IconComment'),
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
          text: 'この作品にはまだコメントがありません。',
        },
        params: {
          id: this.spaceId,
          page: '',
          per_page: ''
        },
        wrapper: {
          style: {
            // maxHeight: '1095px',
            // height: '1095px',
            // overflow: 'scroll',
          }
        },
        textField: {
          // color: '#000000',
          placeholder: '#コメントを入力...',
          style: {
            position: 'static',
          color: '#000000',

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
                this.comments.push(...res.data.data);
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
      textFieldGrid() {
        switch (this.$vuetify.breakpoint.name) {
          case 'xs':
            return 'mt-2 rounded-s'
          case 'sm':
            return 'mt-2'
          case 'md':
            return 'mt-2'
          case 'lg':
            return 'mt-3 rounded'
          case 'xl':
            return 'mt-2 ml-6 mr-6 rounded-lg'
        }
      }
    }
  }
</script>