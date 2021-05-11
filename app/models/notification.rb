# == Schema Information
#
# Table name: notifications
#
#  id          :bigint           not null, primary key
#  checked     :boolean          default(FALSE), not null
#  genre       :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  receiver_id :integer          not null
#  sender_id   :integer          not null
#
# Indexes
#
#  index_notifications_on_receiver_id  (receiver_id)
#  index_notifications_on_sender_id    (sender_id)
#
class Notification < ApplicationRecord
  enum genre: %i[relationship].freeze
  belongs_to :sender, class_name: 'User',
             foreign_key: 'sender_id'
  belongs_to :receiver, class_name: 'User',
              foreign_key: 'receiver_id'
  scope :unchecked, -> { where(checked: false) }

  class << self
    def exist(receiver, sender)
      where(["receiver_id = ? and sender_id = ?", receiver, sender])
    end
  end
end
