class CommentUserSerializer
  include JSONAPI::Serializer

  set_type :user
  attributes :id, :name

  attribute :avatar_url do |user|
    if user.avatar.attached?
      user.cdn_ready_blob_path(user.avatar)
    end
  end
end
