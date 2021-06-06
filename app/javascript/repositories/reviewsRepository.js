import { secureAxios } from '../backend/axios';

const baseURL = '/api/v1/reviews';

export default {
  post(reviewParams){
    return secureAxios.post(`${baseURL}`, reviewParams);
  }
}