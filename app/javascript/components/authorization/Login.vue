<template>
  <v-container>
    <v-row class="top-part" />
    <v-row>
      <v-col cols=1 />
      <v-col cols=10>
        <v-text-field background-color="#ffffff" class="rounded-xl inp-text" label="Eメール" outlined />
      </v-col>
    </v-row>
    <v-row class="mt-n10">
      <v-col cols=1 />
      <v-col cols=10>
        <v-text-field background-color="#ffffff" class="rounded-xl inp-text" label="パスワード" outlined />
      </v-col>
    </v-row>
    <v-row class="mt-n9">
      <v-col cols=6 />
      <v-col cols=5 class="ml-7">
        <div class="setting-text">パスワードを忘れた場合はこちら</div>
      </v-col>
    </v-row>
    <v-row class="mt-n2">
      <v-col cols=1 />
      <v-col cols=10>
        <v-btn x-large class="rounded-xl" color="#000000" dark block>
          <div class="login-text">ログイン</div>
        </v-btn>
      </v-col>
    </v-row>
    <v-row class="mt-5">
      <v-col cols=1 />
      <v-col cols=4>
        <v-divider />
      </v-col>
      <v-col cols=3>
        <div class="setting-text mt-n2">snsでログイン</div>
      </v-col>
      <v-col cols=4 class="ml-n10">
        <v-divider />
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=2 class="ml-2" />
      <v-col cols=3>
        <v-btn class="sns-btn rounded-s" dark icon x-large>
          <v-icon>mdi-google</v-icon>
        </v-btn>
      </v-col>
      <v-col cols=3>
        <v-btn class="sns-btn rounded-s" dark icon x-large>
          <v-icon>mdi-apple</v-icon>
        </v-btn>
      </v-col>
      <v-col cols=2>
        <v-btn class="sns-btn rounded-s" dark icon x-large>
          <v-icon>mdi-facebook</v-icon>
        </v-btn>
      </v-col>
    </v-row>
    <v-row class="bottom-part">
    </v-row>
    <v-row>
      <v-col cols=8 />
      <v-col cols=3 class="ml-7">
        <div class="switch-text">アカウント登録</div>
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
    height: 320px;
  }

  .theme--light.v-text-field>.v-input__control>.v-input__slot:before {
    border-color: orange;
  }

  .v-text-field--outlined>>>fieldset {
    border-color: #e9ecef;
  }

  .login-text {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 11px;
  }

  .setting-text {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 3px;
    color: #adb5bd;
  }

  .switch-text {
    font-weight: bold;
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 8px;
    color: #4361ee;
  }

  .inp-text {
    font-family: 'Helvetica Neue', sans-serif;
    font-size: 17px;
    color: #dee2e6;
  }

  .bottom-part {
    height: 70px;
  }

  .sns-btn {
    background-color: #000000;
    font-weight: bold;
    /* height: 34px; */
  }
</style>