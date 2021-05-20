import spacesRepository from './spacesRepository';
import usersRepository from './usersRepository';
import relationshipsRepository from './relationshipsRepository';
import tagsRepository from './tagsRepository';
import subscriptionsRepository from './subscriptionsRepository';
import tmdbRepository from './tmdbRepository';
import authRepository from './authRepository';
import avatarRepository from './avatarRepository';

const repositories = {
  spaces: spacesRepository,
  users: usersRepository,
  relationships: relationshipsRepository,
  tags: tagsRepository,
  tmdb: tmdbRepository,
  subscriptions: subscriptionsRepository,
  auth: authRepository,
  avatar: avatarRepository
};

export const RepositoryFactory = {
  get: name => repositories[name]
};