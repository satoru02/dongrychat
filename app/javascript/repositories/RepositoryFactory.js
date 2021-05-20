import spacesRepository from './spacesRepository';
import usersRepository from './usersRepository';
import relationshipsRepository from './relationshipsRepository';
import tagsRepository from './tagsRepository';
import tmdbRepository from './tmdbRepository';

const repositories = {
  spaces: spacesRepository,
  users: usersRepository,
  relationships: relationshipsRepository,
  tags: tagsRepository,
  tmdb: tmdbRepository
};

export const RepositoryFactory = {
  get: name => repositories[name]
};