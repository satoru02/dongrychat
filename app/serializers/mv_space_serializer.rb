class MvSpaceSerializer
  include JSONAPI::Serializer

  set_type :mv_space
  attributes :id, :name, :media
  has_many :comments, serializer: CommentsSerializer
end