import { secureAxios } from '../backend/axios';

const baseURL = `/api/v1/notifications`;

export default {
  get(userParams){
    return secureAxios.get(`${baseURL}`, { params: userParams });
  },
};