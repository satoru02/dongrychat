<template>
  <v-container :class="$vuetify.breakpoint.width > 600 ? 'ml-5' : ''">
    <v-list two-line :style="vList.style">
      <v-hover v-slot="{hover}" v-for="(user, index) in users" :key="index">
        <v-list-item :class="'rounded-lg'" @click="goUserPage(user)" :style="hover ? vList.hoverStyle : vList.style"
          :elevation='hover ? 15 : 0'>
          <v-list-item-avatar :style="avatar.style">
            <img v-if="user.attributes.avatar_url" :src="user.attributes.avatar_url" />
            <span v-else>
              <icon-base :width="'20'" :height="'20'" icon-name="icon-user" :iconColor="'#ffffff'"
                :viewBox="'-42 0 512 512.002'">
                <icon-user />
              </icon-base>
            </span>
          </v-list-item-avatar>
          <v-list-item-content>
            <v-list-item-title :style="name.style" v-text="user.attributes.name" />
            <v-list-item-subtitle :style="about.style" v-text="user.attributes.about" />
          </v-list-item-content>
        </v-list-item>
      </v-hover>
    </v-list>
    <base-loader :handler="infiniteHandler" :wrapper="false" :text="loader.text" />
    <base-profile-dialog v-if="user" v-on:input="offDialog()" :passDialog="dialog" :user="user"
      :followed="this.spaceFollowed" />
  </v-container>
</template>

<script>
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const relationshipsRepository = RepositoryFactory.get('relationships')
  const spacesRepository = RepositoryFactory.get('spaces')

  export default {
    name: 'SpaceUsers',
    components: {
      'base-profile-dialog': () => import( /* webpackPrefetch: true */ '../Base/BaseProfileDialog'),
      'base-loader': () => import( /* webpackPrefetch: true */ '../Base/BaseInfiniteLoader'),
      'icon-base': () => import( /* webpackPrefetch */ '../Icon/IconBase'),
      'icon-user': () => import( /* webpackPrefetch */ '../Icon/IconUser'),
    },
    props: {
      spaceId: {
        type: Number,
        required: true,
      }
    },
    data() {
      return {
        dialog: false,
        spaceFollowed: Boolean,
        btnFollowed: false,
        page: 1,
        pageSize: 10,
        users: [],
        user: '',
        params: {
          page: '',
          per_page: ''
        },
        loader: {
          text: 'この作品のチャットをフォローしているユーザーはいません。',
        },
        vList: {
          style: {
            cursor: 'pointer',
            backgroundColor: '#ffffff'
          },
          hoverStyle: {
            cursor: 'pointer',
            backgroundColor: '#f6f6f9'
          }
        },
        name: {
          style: {
            fontWeight: 'bold',
            fontSize: '14px',
            color: '#111111'
          }
        },
        about: {
          style: {
            fontWeight: 'bold',
            fontSize: '11px',
            color: '#6c757d',
            lineHeight: '16px',
            maxWidth: "450px",
          }
        },
        avatar: {
          style: {
            size: '49',
            height: '40'
          }
        }
      }
    },
    methods: {
      infiniteHandler($state) {
        setTimeout(() => {
          this.params.page = this.page
          this.params.per_page = this.pageSize
          spacesRepository.getUsers(this.spaceId, this.params)
            .then(res => {
              if (res.data.data.length) {
                this.page += 1;
                this.users.push(...res.data.data);
                $state.loaded();
              } else {
                $state.complete();
              }
            })
        }, 0);
      },
      // showDialog(user) {
      //   if (this.$store.state.user.currentUser.following.includes(user.id)) {
      //     this.spaceFollowed = true
      //   } else {
      //     this.spaceFollowed = false
      //   }
      //   this.user = user
      //   this.dialog = true
      // },
      // offDialog(value) {
      //   this.dialog = value
      // },
      // checkRelationship(user) {
      //   if (this.$store.state.user.currentUser.following.includes(user.attributes.id)) {
      //     return true
      //   } else {
      //     return false
      //   }
      // },
      // follow(user_id) {
      //   relationshipsRepository.follow({
      //       followed_id: user_id
      //     })
      //     .then(res => {
      //       this.$store.commit('user/follow', user_id)
      //       this.btnFollowed = true
      //     })
      // },
      // unfollow(user_id) {
      //   relationshipsRepository.unfollow(this.$store.state.user.currentUser.id, {
      //       id: this.$store.state.user.currentUser.id,
      //       followed_id: user_id
      //     })
      //     .then(res => {
      //       this.$store.commit('user/unfollow', user_id)
      //       this.btnFollowed = false
      //     })
      // },
      goUserPage(user) {
        this.$router.replace(`/users/${user.attributes.id}/watchlists`)
      }
    }
  }
</script>