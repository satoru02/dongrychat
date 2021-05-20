import { tmdbAxios } from '../backend/axios';

const baseURL = `https://api.themoviedb.org/3`;
const apiKey = `${process.env.TMDB_API_KEY}`;
const language = `ja`;

export default {
  getTvInfo(tmdbId, number){
    return tmdbAxios.get(`${baseURL}/tv/${tmdbId}/season/${number}?api_key=${apiKey}&language=${language}`);
  },
  getMvInfo(tmdbId){
    return tmdbAxios.get(`${baseURL}/movie/${tmdbId}?api_key=${apiKey}&language=${language}`);
  },
  getOverall(tmdbId){
    return tmdbAxios.get(`${baseURL}/tv/${tmdbId}?api_key=${apiKey}&language=${language}`);
  },
  getTrendTvs(){
    return tmdbAxios.get(`${baseURL}/trending/tv/week?api_key=${apiKey}&language=${language}`);
  },
  getTrendMvs(){
    return tmdbAxios.get(`${baseURL}/trending/movie/week?api_key=${apiKey}&language=${language}`);
  },
  getPopularTvs(){
    return tmdbAxios.get(`${baseURL}/tv/popular?api_key=${apiKey}&language=${language}&page=1`);
  },
  getPopularMvs(){
    return tmdbAxios.get(`${baseURL}/movie/popular?api_key=${apiKey}&language=${language}&page=1`);
  },
  getTopratedTvs(){
    return tmdbAxios.get(`${baseURL}/tv/top_rated?api_key=${apiKey}&language=${language}&page=1`);
  },
  getTopratedMvs(){
    return tmdbAxios.get(`${baseURL}/movie/top_rated?api_key=${apiKey}&language=${language}&page=1`);
  },
  getUpcomingMvs(){
    return tmdbAxios.get(`${baseURL}/movie/upcoming?api_key=${apiKey}&language=${language}&page=1`);
  }
};