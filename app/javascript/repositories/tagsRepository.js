import { secureAxios } from '../backend/axios';

const baseURL = `/api/v1/tags`;
const spaceResource = `spaces`;

export default {
  get(){
    return secureAxios.get(`${baseURL}`);
  },
  getSpaces(tagName, tagParams){
    return secureAxios.get(`${baseURL}/${tagName}/${spaceResource}`, { params: tagParams });
  },
};