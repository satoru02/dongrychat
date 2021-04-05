class CommentUserSerializer
  include JSONAPI::Serializer

  set_type :user
  attributes :id, :name

  attribute :avatar_url do |object|
    if object.avatar.attached?
      object.avatar_url(object.avatar.blob)
    end
  end
end
