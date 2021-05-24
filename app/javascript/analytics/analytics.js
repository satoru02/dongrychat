import Vue from 'vue';
import VueGtag from "vue-gtag";

Vue.use(VueGtag, {
  config: {id: process.env.GA_ID},
  app_name: process.env.GA_APP_NAME,
  pageTrackerScreenviewEnabled: true,
});