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
class Review < Submission
end
