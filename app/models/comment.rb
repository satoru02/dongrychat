# == Schema Information
#
# Table name: comments
#
#  id           :bigint           not null, primary key
#  confirmation :boolean          default(FALSE)
#  content      :text             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  space_id     :bigint
#  user_id      :bigint
#
# Indexes
#
#  index_comments_on_space_id  (space_id)
#  index_comments_on_user_id   (user_id)
#
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :space
  validates :content, presence: true
  include Pager


  # def readen
  #   self.update!(confirmation: true)
  # end
end
