# == Schema Information
#
# Table name: users
#
#  id                              :bigint           not null, primary key
#  activated                       :boolean          default(FALSE)
#  activated_at                    :datetime
#  activation_token                :string
#  email                           :string
#  password_digest                 :string
#  reset_password_token            :string
#  reset_password_token_expires_at :datetime
#  role                            :integer          default("user")
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#
# Indexes
#
#  index_users_on_activation_token      (activation_token)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token)
#
class UserSerializer
  include JSONAPI::Serializer

  set_type :user
  attributes :id, :email, :role, :activated, :activated_at
end
