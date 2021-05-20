import spacesRepository from './spacesRepository';

const repositories = {
  spaces: spacesRepository,
};

export const RepositoryFactory = {
  get: name => repositories[name]
};