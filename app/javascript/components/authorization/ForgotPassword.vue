<template>
  <v-container>
    <v-row class="top-part" />
    <v-row>
      <v-col cols=1 />
      <v-col cols=10>
        <v-text-field background-color="#ffffff" class="rounded-xl inp-text" label="Eメール" outlined />
      </v-col>
    </v-row>
    <v-row class="mt-n8">
      <v-col cols=1 />
      <v-col cols=10>
        <v-btn x-large class="rounded-xl" color="#000000" dark block>
          <div class="login-text">Eメールを送信する</div>
        </v-btn>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=8 />
      <v-col cols=3 class="ml-7">
        <div class="switch-text">アカウント登録</div>
      </v-col>
    </v-row>
    <v-row class="mt-n2">
      <v-col cols=8 />
      <v-col cols=3 class="ml-7">
        <div class="switch-text">ログイン</div>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  name: 'ForgotPassword'
}
</script>

<style scoped>
  .top-part {
    height: 320px;
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