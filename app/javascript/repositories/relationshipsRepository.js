import { secureAxios } from '../backend/axios';

const baseURL = `/api/v1/relationships`;

export default {
  follow(userParams){
    return secureAxios.post(`${baseURL}`, userParams);
  },
  unfollow(userId, userParams){
    return secureAxios.delete(`${baseURL}/${userId}`, { params: userParams });
  }
};