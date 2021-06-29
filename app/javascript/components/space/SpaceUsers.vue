<template>
  <div class="ml-16">
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
    <base-profile-dialog v-if="user" v-on:input="offDialog()" :passDialog="dialog" :user="user"
      :followed="this.spaceFollowed" />
  </div>
</template>

<script>
  import {
    RepositoryFactory
  } from '../../repositories/RepositoryFactory';
  const relationshipsRepository = RepositoryFactory.get('relationships')

  export default {
    name: 'SpaceUsers',
    props: ['users'],
    components: {
      'base-profile-dialog': () => import( /* webpackPrefetch: true */ '../Base/BaseProfileDialog'),
      'icon-base': () => import( /* webpackPrefetch */ '../Icon/IconBase'),
      'icon-user': () => import( /* webpackPrefetch */ '../Icon/IconUser'),
    },
    data() {
      return {
        dialog: false,
        spaceFollowed: Boolean,
        btnFollowed: false,
        user: '',
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
      showDialog(user) {
        if (this.$store.state.user.currentUser.following.includes(user.id)) {
          this.spaceFollowed = true
        } else {
          this.spaceFollowed = false
        }
        this.user = user
        this.dialog = true
      },
      offDialog(value) {
        this.dialog = value
      },
      checkRelationship(user) {
        if (this.$store.state.user.currentUser.following.includes(user.attributes.id)) {
          return true
        } else {
          return false
        }
      },
      follow(user_id) {
        relationshipsRepository.follow({
            followed_id: user_id
          })
          .then(res => {
            this.$store.commit('user/follow', user_id)
            this.btnFollowed = true
          })
      },
      unfollow(user_id) {
        relationshipsRepository.unfollow(this.$store.state.user.currentUser.id, {
            id: this.$store.state.user.currentUser.id,
            followed_id: user_id
          })
          .then(res => {
            this.$store.commit('user/unfollow', user_id)
            this.btnFollowed = false
          })
      },
      goUserPage(user) {
        this.$router.replace(`/users/${user.attributes.id}/watchlists`)
      }
    }
  }
</script>