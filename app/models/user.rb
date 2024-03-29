# == Schema Information
#
# Table name: users
#
#  id                              :bigint           not null, primary key
#  about                           :text
#  activated                       :boolean          default(FALSE)
#  activated_at                    :datetime
#  activation_token                :string
#  active_relationships_count      :integer
#  birthday                        :string
#  confirmations_count             :integer
#  email                           :string
#  gender                          :integer
#  location                        :string
#  name                            :string           not null
#  passive_relationships_count     :integer
#  password_digest                 :string
#  reset_password_token            :string
#  reset_password_token_expires_at :datetime
#  reviews_count                   :integer
#  role                            :integer          default("user")
#  slug                            :string
#  sns_links                       :text             default([]), is an Array
#  watchlists_count                :integer
#  watchlog_count                  :integer
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#
# Indexes
#
#  index_users_on_activation_token      (activation_token)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token)
#  index_users_on_slug                  (slug) UNIQUE
#
class User < ApplicationRecord
  has_many :active_relationships, class_name: "Relationship",
           foreign_key: "follower_id",
           dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
           foreign_key: "followed_id",
           dependent: :destroy
  has_many :active_notifications, class_name: 'Notification',
           foreign_key: 'sender_id',
           dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification',
           foreign_key: 'receiver_id',
           dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :confirmations, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reviews, class_name: 'Submission', dependent: :destroy
  has_many :subscriptions, dependent: :destroy, counter_cache: true
  has_many :spaces, -> {includes :comments, :users, :confirmations}, through: :subscriptions, counter_cache: true
  has_many :watchlists, dependent: :destroy
  has_many :watchlog, class_name: 'Watchlist', dependent: :destroy
  has_many :completed_watchlists, -> { where(status: true) }, class_name: "Watchlist", foreign_key: 'user_id', dependent: :destroy
  has_many :uncompleted_watchlists, -> { where(status: false) }, class_name: "Watchlist", foreign_key: 'user_id', dependent: :destroy
  has_many :watched_spaces, through: :completed_watchlists, dependent: :destroy, source: :space
  has_many :unwatched_spaces, through: :uncompleted_watchlists, dependent: :destroy, source: :space

  has_one_attached :avatar, dependent: :destroy
  has_secure_password

  enum role: %i[user manager admin].freeze

  before_save :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil:true
  validates :sns_links, url: true
  validates :email, presence: true, length: { maximum: 235 },
             format: { with: VALID_EMAIL_REGEX },
             uniqueness: { case_sensitive: false }
  extend FriendlyId
  friendly_id :name, use: :slugged

  class << self
    def authName(length = rand(10))
      source = ("a".."z").to_a + ("A".."Z").to_a + (0..9).to_a + ["_","-","."]
      key = "user_"
      length.times{ key += source[rand(source.size)].to_s }
      return key
    end
  end

  def authenticated?(attribute, token)
    token = send("#{attribute}_token")
    return false if token.nil?
    self.activation_token == token
  end

  def generate_activation_token!
    begin
      self.activation_token = SecureRandom.urlsafe_base64
    end
    save!
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def activate
    update_columns(activated: true, activated_at: Time.zone.now )
  end

  def generate_password_token!
    begin
      self.reset_password_token = SecureRandom.urlsafe_base64
    end while User.exists?(reset_password_token: self.reset_password_token)
    self.reset_password_token_expires_at = 1.day.from_now
    save!
  end

  def clear_password_token!
    self.reset_password_token = nil
    self.reset_password_token_expires_at = nil
  end

  # fix -> abstraction
  def create_active_notification(following)
    if Notification.exist(following.id, self.id).blank?
      active_notification = active_notifications.build(receiver_id: following.id)
      active_notification.save if active_notification.valid?
    end
  end

  def unconfirmed_comments
    sum = 0
    all_comments = spaces.map{ |space| sum += space.comments_unconfirmed_by(self) }
    all_comments.last
  end

  def follow other_user
    following << other_user
  end

  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following? other_user
    following.include? other_user
  end

  def subscribed? space_id
    subscriptions.exists? space_id: space_id
  end

  def watched? space_id
    watchlists.where(space_id: space_id)
  end

  def cdn_ready_blob_path(attachment)
    key = attachment&.blob&.key
    "#{ENV['AWS_CLOUDFRONT']}/#{key}"
  end

  def attach_avatar(file)
    s3 = Aws::S3::Resource.new(region: ENV["AWS_REGION"])
    obj = s3.bucket(ENV["AWS_BUCKET"]).object("avatar/#{file}")
    params = { filename: obj.key, content_type: obj.content_type, byte_size: obj.size, checksum: obj.etag.gsub('"',"") }
    blob = ActiveStorage::Blob.create_before_direct_upload!(params)
    blob.update_attributes(key: "avatar/#{file}")
    self.avatar.attach(blob)
  end

  # def is_online?
  #   redis = set_redis
  #   if redis.get("user_#{self.id}_online")
  #     true
  #   else
  #     false
  #   end
  # end

  # def online_followings
  #   redis = set_redis
  #   online_users = []
  #   following.each { |following_user| online_users << following_user if redis.get("user_#{following_user.id}_online") }
  #   online_users[0..5]
  # end

  private

    def downcase_email
      self.email = email.downcase
    end

    # def set_redis
    #   redis = Redis.new
    # end
end
