# == Schema Information
#
# Table name: users
#
#  id                              :bigint           not null, primary key
#  about                           :text
#  activated                       :boolean          default(FALSE)
#  activated_at                    :datetime
#  activation_token                :string
#  active_relationships_count      :integer
#  birthday                        :string
#  confirmations_count             :integer
#  email                           :string
#  gender                          :integer
#  location                        :string
#  name                            :string           not null
#  passive_relationships_count     :integer
#  password_digest                 :string
#  reset_password_token            :string
#  reset_password_token_expires_at :datetime
#  reviews_count                   :integer
#  role                            :integer          default("user")
#  slug                            :string
#  sns_links                       :text             default([]), is an Array
#  watchlists_count                :integer
#  watchlog_count                  :integer
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#
# Indexes
#
#  index_users_on_activation_token      (activation_token)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token)
#  index_users_on_slug                  (slug) UNIQUE
#
class UserSerializer
  include JSONAPI::Serializer

  set_type :user
  attributes :id, :email, :role, :activated, :activated_at, :name, :about, :location, :sns_links, :gender, :birthday
  attribute :following do |user|
    user.following.map(&:id)
  end

  attribute :follower do |user|
    user.followers.map(&:id)
  end

  attribute :watchlists_count do |user|
    user.watchlists.size
  end

  attribute :watchlog_count do |user|
    user.watchlog.size
  end

  attribute :reviews_count do |user|
    user.reviews.size
  end

  attribute :followers_count do |user|
    user.passive_relationships.size
  end

  attribute :followed_count do |user|
    user.active_relationships.size
  end

  attribute :avatar_url do |user|
    if user.avatar.attached?
      user.cdn_ready_blob_path(user.avatar)
    end
  end
end
