class CommentUserSerializer
  include JSONAPI::Serializer

  set_type :user
  attributes :id, :name, :about

  attribute :following do |object|
    object.following.map(&:id)
  end

  attribute :follower do |object|
    object.followers.map(&:id)
  end

  attribute :avatar_url do |user|
    if user.avatar.attached?
      # user.avatar_url(user.avatar.blob)
      user.cdn_ready_blob_path(user.avatar)
    end
  end
end
