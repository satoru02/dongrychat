<template>
  <v-container>
    <v-row class="top-part" />
    <v-row>
      <v-col cols=1 />
      <v-col cols=10>
        <v-btn x-large depressed block class="rounded-xl" outlined>
          <v-row>
            <v-col cols=2 sm=3 md=3 lg=3 xl=3 />
            <v-col cols=1 sm=1 md=1 lg=1 xl=1>
              <v-icon class="ml-7 mt-3">mdi-mail</v-icon>
            </v-col>
            <v-col cols=3 sm=3 md=3 lg=3 xl=3>
              <p class="ml-7 mt-4" style="font-size:0.8rem; font-weight:bold;">メールでログイン</p>
            </v-col>
            <v-col cols=3 sm=3 md=3 lg=3 xl=3 />
          </v-row>
        </v-btn>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=1 />
      <v-col cols=10>
        <v-btn x-large depressed block class="rounded-xl" color="#00b900">
          <v-row>
            <v-col cols=2 sm=3 md=3 lg=3 xl=3 />
            <v-col cols=1 sm=1 md=1 lg=1 xl=1>
              <v-icon class="ml-7 mt-3">mdi-line</v-icon>
            </v-col>
            <v-col cols=3 sm=3 md=3 lg=3 xl=3>
              <p class="ml-7 mt-4" style="font-size:0.8rem; font-weight:bold; color: #ffffff">Lineでログイン</p>
            </v-col>
            <v-col cols=3 sm=3 md=3 lg=3 xl=3 />
          </v-row>
        </v-btn>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=1 />
      <v-col cols=10>
        <v-btn x-large depressed block class="rounded-xl" color="#1da1f2">
          <v-row>
            <v-col cols=2 sm=3 md=3 lg=3 xl=3 />
            <v-col cols=1 sm=1 md=1 lg=1 xl=1>
              <v-icon class="ml-7 mt-3" color="#ffffff">mdi-twitter</v-icon>
            </v-col>
            <v-col cols=3 sm=3 md=3 lg=3 xl=3>
              <p class="ml-7 mt-4" style="font-size:0.8rem; font-weight:bold; color: #ffffff">Twitterでログイン</p>
            </v-col>
            <v-col cols=3 sm=3 md=3 lg=3 xl=3 />
          </v-row>
        </v-btn>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=1 />
      <v-col cols=10>
        <v-btn x-large depressed block class="rounded-xl" outlined>
          <v-row>
            <v-col cols=2 sm=3 md=3 lg=3 xl=3 />
            <v-col cols=1 sm=1 md=1 lg=1 xl=1>
              <v-icon class="ml-7 mt-3">mdi-apple</v-icon>
            </v-col>
            <v-col cols=3 sm=3 md=3 lg=3 xl=3>
              <p class="ml-7 mt-4" style="font-size:0.8rem; font-weight:bold;">Appleでログイン</p>
            </v-col>
            <v-col cols=3 sm=3 md=3 lg=3 xl=3 />
          </v-row>
        </v-btn>
      </v-col>
    </v-row>
    <v-row class="mt-5">
      <v-col cols=4 />
      <v-col cols=4 class="ml-5">
        <div class="switch-text">
          アカウント登録はこちら
        </div>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
  export default {
    name: 'Login'
  }
</script>

<style scoped>
  .top-part {
    height: 380px;
  }

  .login-text {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 11px;
  }

  .switch-text {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 8px;
    color: #4361ee;
  }
</style>