import { secureAxios } from '../backend/axios';

const baseURL = `/api/v1/spaces`;
const trend_resource = `trend`;
const comments_resource = `comments`;
const reviews_resource = `reviews`;
const popular_resource = `popular`;

export default {
  getTrend(spaceParams){
    return secureAxios.get(`${baseURL}/${trend_resource}`, { params: spaceParams });
  },
  getPopular(spaceParams){
    return secureAxios.get(`${baseURL}/${popular_resource}`, { params: spaceParams });
  },
  getComments(spaceId, spaceParams){
    return secureAxios.get(`${baseURL}/${spaceId}/${comments_resource}`, { params: spaceParams });
  },
  getReviews(spaceId, spaceParams){
    return secureAxios.get(`${baseURL}/${spaceId}/${reviews_resource}`, { params: spaceParams });
  },
  enterSpace(spaceResource, spaceParams){
    return secureAxios.get(`${baseURL}/${spaceResource}`, { params: spaceParams });
  },
};