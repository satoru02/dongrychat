<template>
  <v-dialog v-model="change" width="400" transition="dialog-top-transition">
    <v-card color="#ffffff" height="250" class="rounded-lg">
      <v-row>
        <v-col cols=3 sm=3 md=3 lg=3 xl=3 />
        <v-col cols=7 sm=7 md=7 lg=7 xl=7>
          <div class="mt-9 ml-6" :style="dialog.headerStyle" v-text="'Devioを使ってみる'" />
        </v-col>
      </v-row>
      <v-row>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
        <v-col cols=10 sm=10 md=10 lg=10 xl=10>
          <v-btn @click="goLogin()" block　:style="dialog.btnStyle" color="black" outlined elevation=0 v-text="'ログイン'" />
        </v-col>
      </v-row>
      <v-row>
        <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
        <v-col cols=10 sm=10 md=10 lg=10 xl=10>
          <v-btn block @click="goSignup()" :style="dialog.btnStyle" color="#016aff" elevation=0 v-text="'アカウント作成'" />
        </v-col>
      </v-row>
      <v-row>
        <v-col cols=3 sm=3 md=3 lg=3 xl=3 />
        <v-col cols=9 sm=9 md=9 lg=9 xl=9>
          <div class="ml-1" :style="dialog.policyStyle" v-text="'利用規約とプライバシーポリシーはこちら'" />
        </v-col>
      </v-row>
    </v-card>
  </v-dialog>
</template>

<script>
  export default {
    name: 'BaseLoginDialog',
    props: {
      passDialog: {
        type: Boolean,
        default: false,
        required: true,
      }
    },
    computed: {
      change: {
        get: function(){
          return this.dialog = this.passDialog
        },
        set: function(){
          this.$emit('input', false)
        }
      }

    },
    data() {
      return {
        dialog: false,
        dialog: {
          headerStyle: {
            color: '#111111',
            fontWeight: 'bold',
            fontSize: '17px',
          },
          btnStyle: {
            color: '#ffffff',
            fontWeight: 'bold',
            fontSize: '12px',
          },
          policyStyle: {
            color: '#6c757d',
            fontSize: '4px',
          }
        },
      }
    },
    methods: {
      goLogin() {
        this.$router.replace('/login');
      },
      goSignup() {
        this.$router.replace('/signup');
      }
    }
  }
</script>

<style scoped>
</style>