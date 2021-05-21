import { secureAxios } from '../backend/axios';

const baseURL = `/api/v1/subscriptions`;

export default {
  subscribe(sbscParams){
    return secureAxios.post(`${baseURL}`, sbscParams);
  },
  unsubscribe(spaceId, userId){
    return secureAxios.delete(`${baseURL}/${spaceId}/${userId}`);
  },
};