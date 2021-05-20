import { secureAxios } from '../backend/axios';

const baseURL = `/api/v1/spaces`;
const trend_resource = `trend`;
const comments_resource = `comments`;

export default {
  getTrend(spaceParams){
    return secureAxios.get(`${baseURL}/${trend_resource}`, { params: spaceParams });
  },
  getComments(spaceId, spaceParams){
    return secureAxios.get(`${baseURL}/${spaceId}/${comments_resource}`, { params: spaceParams });
  },
  enterSpace(spaceResource, spaceParams){
    return secureAxios.get(`${baseURL}/${spaceResource}`, { params: spaceParams });
  }
};