class TvSpaceSerializer
  include JSONAPI::Serializer

  set_type :tv_space
  attributes :id, :name, :media, :season, :episode
end