# == Schema Information
#
# Table name: users
#
#  id                              :bigint           not null, primary key
#  about                           :text
#  activated                       :boolean          default(FALSE)
#  activated_at                    :datetime
#  activation_token                :string
#  birthday                        :string
#  email                           :string
#  gender                          :integer
#  location                        :string
#  name                            :string           not null
#  password_digest                 :string
#  reset_password_token            :string
#  reset_password_token_expires_at :datetime
#  role                            :integer          default("user")
#  slug                            :string
#  sns_links                       :text             default([]), is an Array
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

  attribute :appearance do |user|
    user.is_online?
  end

  attribute :subscriptions do |user|
    user.subscriptions.length
  end

  attribute :avatar_url do |object|
    if object.avatar.attached?
      object.avatar_url(object.avatar.blob)
    end
  end
end
