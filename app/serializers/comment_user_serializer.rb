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

  attribute :avatar_url do |object|
    if object.avatar.attached?
      object.avatar_url(object.avatar.blob)
    end
  end
end
