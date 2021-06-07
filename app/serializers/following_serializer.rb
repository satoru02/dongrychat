class FollowingSerializer
  include JSONAPI::Serializer
  set_type :following_users
  attributes :id, :email, :role, :activated, :activated_at, :name, :about, :location, :sns_links, :gender, :birthday

  attribute :avatar_url do |user|
    if user.avatar.attached?
      # user.avatar_url(user.avatar.blob)
      user.cdn_ready_blob_path(user.avatar)
    end
  end
end