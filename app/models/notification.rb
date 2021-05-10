# == Schema Information
#
# Table name: notifications
#
#  id         :bigint           not null, primary key
#  action     :integer
#  checked    :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_notifications_on_user_id  (user_id)
#
class Notification < ApplicationRecord
  belongs_to :user
  enum role: %i[follow].freeze
end
