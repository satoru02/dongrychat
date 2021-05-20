import { secureAxios } from '../backend/axios';

const baseURL = `/api/v1/users`;
const subscriptionResource = `subscriptions`;
const followersResource = `followers`;
const followingResource = `following`;

export default {
  getSubscriptions(userId, userParams){
    return secureAxios.get(`${baseURL}/${userId}/${subscriptionResource}`, { params: userParams });
  },
  getUserInfo(userName){
    return secureAxios.get(`${baseURL}/${userName}`);
  },
  getFollowers(userId){
    return secureAxios.get(`${baseURL}/${userId}/${followersResource}`);
  },
  getFollowings(userId){
    return secureAxios.get(`${baseURL}/${userId}/${followingResource}`);
  },
  update(userId, userParams){
    return secureAxios.patch(`${baseURL}/${userId}`, userParams);
  }
};