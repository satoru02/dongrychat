# == Schema Information
#
# Table name: confirmations
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  comment_id :integer
#  space_id   :integer          not null
#  user_id    :integer
#
# Indexes
#
#  index_confirmations_on_comment_id              (comment_id)
#  index_confirmations_on_user_id                 (user_id)
#  index_confirmations_on_user_id_and_comment_id  (user_id,comment_id) UNIQUE
#
class Confirmation < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :comment
  belongs_to :space
end
