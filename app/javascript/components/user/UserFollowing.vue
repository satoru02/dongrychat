<template>
  <div>
    <user-relationships :relationships="followings" />
    <base-loader :infiniteId="componentKey" :handler="infiniteHandler" :wrapper="true" :text="loaderText" />
  </div>
</template>

<script>
  import { RepositoryFactory } from '../../repositories/RepositoryFactory';
  const usersRepository = RepositoryFactory.get('users');

  export default {
    name: "UserFollowing",
    components: {
      'user-relationships': () => import(/* webpackPrefetch: true */ './UserRelationships'),
      'base-loader': () => import( /* webpackPrefetch: true */ '../Base/BaseInfiniteLoader'),
    },
    data() {
      return {
        loaderText: '現在フォローしているユーザーはいません。',
        followings: [],
        error: '',
        page: 1,
        pageSize: 8,
        componentKey: 0,
        isLoading: false,
      }
    },
    methods: {
      infiniteHandler($state) {
        setTimeout(() => {
          usersRepository.getFollowings(this.$route.params.user_id, {
              page: this.page,
              per_page: this.pageSize
            })
            .then(res => {
              if (res.data.data.length) {
                this.page += 1
                this.followings.push(...res.data.data)
                // this.isLoading = true
                $state.loaded()
              } else {
                $state.complete()
              }
            })
        }, 0)
      }
    }
  }
</script>