import spacesRepository from './spacesRepository';
import usersRepository from './usersRepository';
import relationshipsRepository from './relationshipsRepository';
import tagsRepository from './tagsRepository';
import subscriptionsRepository from './subscriptionsRepository';
import tmdbRepository from './tmdbRepository';
import authRepository from './authRepository';

const repositories = {
  spaces: spacesRepository,
  users: usersRepository,
  relationships: relationshipsRepository,
  tags: tagsRepository,
  tmdb: tmdbRepository,
  subscriptions: subscriptionsRepository,
  auth: authRepository
};

export const RepositoryFactory = {
  get: name => repositories[name]
};