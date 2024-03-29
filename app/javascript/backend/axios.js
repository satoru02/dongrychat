import Vue from 'vue';
import axios from 'axios';
import VueAxios from 'vue-axios';
import { store } from '../stores/index';

Vue.use(VueAxios, axios);

const simpleAxios = axios.create({
  withCredentials: true,
  headers: {
    'Content-Type': 'application/json'
  }
});

const tmdbAxios = axios.create({
  withCredentials: false,
  headers: {
    'Content-Type': 'application/json'
  }
});

const secureAxios = axios.create({
  withCredentials: true,
  headers: {
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': `http://${process.env.COMMON_DOMAIN}`,
  }
});

secureAxios.interceptors.request.use(config => {
  const method = config.method.toUpperCase();
  if (method !== 'OPTIONS' && method !== 'GET') {
    config.headers = {
      ...config.headers,
      'X-CSRF-TOKEN': store.state.user.csrf,
      'Authorization': "Bearer " + `${store.state.user.token}`
    };
  } else if (method === 'GET') {
    config.headers = {
      ...config.headers,
      'Authorization': "Bearer " + `${store.state.user.token}`
    };
  }
  return config;
});

secureAxios.interceptors.response.use(null, error => {
  if (error.response && error.response.config && error.response.status === 403) {
    return simpleAxios.post('/api/v1/refresh', {}, {
        headers: {
          'X-CSRF-TOKEN': store.state.user.csrf,
          'Authorization': "Bearer " + `${store.state.user.token}`
        }
      })
      .then(response => {
        simpleAxios.get('/api/v1/users/me', {
            params: {
              position: 'login'
            }
          }, {
            headers: {
              'Authorization': "Bearer " + `${response.data.access_token}`
            }
          })
          .then(meResponse => store.commit('user/setCurrentUser', {
            currentUser: meResponse.data.data.attributes,
            csrf: response.data.csrf,
            token: response.data.access_token
          }));
        let retryConfig = error.response.config;
        retryConfig.headers = {
          'X-CSRF-TOKEN': response.data.csrf,
          'Authorization': "Bearer " + `${response.data.access_token}`
        };
        return simpleAxios.request(retryConfig);
      }).catch(error => {
        return Promise.reject(error);
      });
  } else {
    return Promise.reject(error);
  }
});

export {
  simpleAxios,
  secureAxios,
  tmdbAxios
};