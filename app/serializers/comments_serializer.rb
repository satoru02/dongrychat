class CommentsSerializer
  include JSONAPI::Serializer

  set_type :comment
  attributes :id, :content, :user_id, :space_id
end