class MvSpaceSerializer
  include JSONAPI::Serializer

  set_type :mv_space
  attributes :id, :name, :media
end