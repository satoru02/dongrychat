class TagSerializer
  include JSONAPI::Serializer
  set_type :tag
  attributes :id, :name
end