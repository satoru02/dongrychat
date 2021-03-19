# == Schema Information
#
# Table name: subscriptions
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  space_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_subscriptions_on_space_id              (space_id)
#  index_subscriptions_on_user_id               (user_id)
#  index_subscriptions_on_user_id_and_space_id  (user_id,space_id) UNIQUE
#
class SubscriptionSerializer
  include JSONAPI::Serializer

  set_type :subscription
  attributes :id, :user_id, :space_id
end
