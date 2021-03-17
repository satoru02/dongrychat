class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :space
  validates :content, presence: true
end
