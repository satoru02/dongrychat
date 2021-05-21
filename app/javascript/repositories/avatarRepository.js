import { secureAxios } from '../backend/axios';

const baseURL = `/api/v1/avatar`;
const resource = `presigned_url`;

export default {
  get(fileParams){
    return secureAxios.get(`${baseURL}/${resource}`, { params: fileParams });
  },
};