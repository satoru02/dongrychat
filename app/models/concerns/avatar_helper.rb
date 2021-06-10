module AvatarHelper
  extend ActiveSupport::Concern

  class_methods do
    def avatar_url(user)
      user.cdn_ready_blob_path(user.avatar)
    end
  end
end