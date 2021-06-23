import { secureAxios } from '../backend/axios';

const baseURL = `/api/v1/users`;
const subscriptionResource = `subscriptions`;
const commentsResource = `new_comments`;
const reviewsResource = `reviews`;
const followersResource = `followers`;
const followingResource = `following`;

export default {
  getSubscriptions(userId, userParams){
    return secureAxios.get(`${baseURL}/${userId}/${subscriptionResource}`, { params: userParams });
  },
  getUserInfo(userName){
    return secureAxios.get(`${baseURL}/${userName}`);
  },
  getNewComments(userId){
    return secureAxios.get(`${baseURL}/${userId}/${commentsResource}`);
  },
  getReviews(userId ,userParams){
    return secureAxios.get(`${baseURL}/${userId}/${reviewsResource}`, { params: userParams });
  },
  getFollowers(userId){
    return secureAxios.get(`${baseURL}/${userId}/${followersResource}`);
  },
  getFollowings(userId){
    return secureAxios.get(`${baseURL}/${userId}/${followingResource}`);
  },
  getWatchlists(userId, resource, params){
    return secureAxios.get(`${baseURL}/${userId}/${resource}`, { params: params });
  },
  update(userId, userParams){
    return secureAxios.patch(`${baseURL}/${userId}`, userParams);
  }
};