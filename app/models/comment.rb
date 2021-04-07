# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  space_id   :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_comments_on_space_id  (space_id)
#  index_comments_on_user_id   (user_id)
#
class Comment < ApplicationRecord
  has_many :confirmations
  belongs_to :user
  belongs_to :space
  validates :content, presence: true

  after_save :confirmed_by_maker

  # class << self
  #   def confirmed_by user, comments, space
  #     bulk_comments = comments.map { |comment_id| { user_id: user.id, comment_id: comment_id, space_id: space.id } }
  #     Confirmation.insert_all(bulk_comments)
  #   end

  #   def unreads
  #     self.includes(:confirmations)
  #   end
  # end

  # def check_unconfirm user,comment
  #   unless self.confirmations.where(user_id: user.id, comment_id: comment.id)
  #     self
  #   end
  # end

  def confirmed_by_maker
    Confirmation.create!(user_id: self.user_id, comment_id: self.id, space_id: self.space_id)
  end
end
