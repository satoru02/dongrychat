class FollowerSerializer
  include JSONAPI::Serializer
  set_type :follower_users
  attributes :id, :email, :role, :activated, :activated_at, :name, :about, :location, :sns_links, :gender, :birthday

  attribute :avatar_url do |object|
    if object.avatar.attached?
      object.avatar_url(object.avatar.blob)
    end
  end
end