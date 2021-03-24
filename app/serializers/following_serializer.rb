class FollowingSerializer
  include JSONAPI::Serializer

  set_type :following_users
  attributes :id, :email, :role, :activated, :activated_at, :name, :about, :location, :sns_links, :gender, :birthday
end