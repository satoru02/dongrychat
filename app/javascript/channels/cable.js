import Vue from 'vue';
import VueAuthenticate from 'vue-authenticate';
import ActionCableVue from 'actioncable-vue';

const developmentOptions = {
  debug: true,
  debugLevel: 'error',
  connectionUrl: `ws://${process.env.LOCALHOST}/cable`,
  connectImmediately: true
};

const productionOptions = {
  debug: true,
  debugLevel: 'error',
  connectionUrl: `wss://dongrychat.com/cable`,
  connectImmediately: true
};

if (process.env.NODE_ENV === "development") {
  Vue.use(ActionCableVue, developmentOptions);
  Vue.use(VueAuthenticate, {
    baseUrl: `http://${process.env.LOCALHOST}`,
    providers: {
      google: {
        clientId: process.env.GOOGLE_CLIENT_ID,
        client_secret: process.env.GOOGLE_CLIENT_SECRET,
        redirectUri: `http://${process.env.LOCALHOST}/login`,
        grant_type: 'authorization_code',
      },
      facebook: {
        clientId: process.env.FACEBOOK_CLIENT_ID,
        client_secret: process.env.FACEBOOK_CLIENT_SECRET,
        redirectUri: `http://${process.env.LOCALHOST}/login`,
        grant_type: 'authorization_code',
      }
    }
  });
} else if (process.env.NODE_ENV === "production") {
  Vue.use(ActionCableVue, productionOptions);
  Vue.use(VueAuthenticate, {
    baseUrl: `https://${process.env.SERVICE_DOMAIN}`,
    providers: {
      google: {
        clientId: process.env.GOOGLE_CLIENT_ID,
        client_secret: process.env.GOOGLE_CLIENT_SECRET,
        redirectUri: `https://${process.env.SERVICE_DOMAIN}/login`,
        grant_type: 'authorization_code',
      },
      facebook: {
        clientId: process.env.FACEBOOK_CLIENT_ID,
        client_secret: process.env.FACEBOOK_CLIENT_SECRET,
        redirectUri: `https://${process.env.SERVICE_DOMAIN}/login`,
        grant_type: 'authorization_code',
      }
    }
  });
}