import spacesRepository from './spacesRepository';
import usersRepository from './usersRepository';
import relationshipsRepository from './relationshipsRepository';
import tagsRepository from './tagsRepository';

const repositories = {
  spaces: spacesRepository,
  users: usersRepository,
  relationships: relationshipsRepository,
  tags: tagsRepository
};

export const RepositoryFactory = {
  get: name => repositories[name]
};