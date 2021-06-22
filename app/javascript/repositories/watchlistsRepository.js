import { secureAxios } from '../backend/axios';

const baseURL = `/api/v1/watchlists`;

export default {
  post(params){
    return secureAxios.post(`${baseURL}`, params);
  },
  update(spaceId, userId, params){
    return secureAxios.patch(`${baseURL}/${spaceId}/${userId}`, params);
  },
  delete(spaceId, userId){
    return secureAxios.delete(`${baseURL}/${spaceId}/${userId}`);
  }
}