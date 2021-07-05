class SpaceUserSerializer
  include JSONAPI::Serializer

  set_type :user
  attributes :id, :name, :about, :location, :sns_links

  attribute :avatar_url do |user|
    if user.avatar.attached?
      user.cdn_ready_blob_path(user.avatar)
    end
  end
end
