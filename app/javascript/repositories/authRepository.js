import { simpleAxios, secureAxios } from '../backend/axios';

const baseURL = `/api/v1`;
const actvResource = `account_activations`;
const resetResource = `password_resets`;
const loginResource = `login`;
const signupResource = `signup`;

export default {
  signup(userParams){
    return simpleAxios.post(`${baseURL}/${signupResource}`, userParams);
  },
  activate(tokenParams){
    return simpleAxios.post(`${baseURL}/${actvResource}`, tokenParams);
  },
  forgot(emailParams){
    return simpleAxios.post(`${baseURL}/${resetResource}`, emailParams);
  },
  login(loginParams){
    return simpleAxios.post(`${baseURL}/${loginResource}`, loginParams);
  },
  logout(userId){
    return secureAxios.delete(`${baseURL}/${loginResource}/${userId}`);
  },
  reset(token, resetParams){
    return simpleAxios.patch(`${baseURL}/${resetResource}/${token}`, resetParams);
  },
  check(tokenParams){
    return simpleAxios.get(`${baseURL}/${resetResource}`, tokenParams);
  }
};