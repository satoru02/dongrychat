# == Schema Information
#
# Table name: submissions
#
#  id         :bigint           not null, primary key
#  content    :string           not null
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  space_id   :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_submissions_on_space_id  (space_id)
#  index_submissions_on_user_id   (user_id)
#
class Submission < ApplicationRecord
  belongs_to :user
  belongs_to :space
  validates :content, presence: true
end
