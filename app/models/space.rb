# == Schema Information
#
# Table name: spaces
#
#  id              :bigint           not null, primary key
#  episode         :integer
#  episode_title   :string
#  image_path      :string
#  media           :integer          default("mv"), not null
#  name            :string           not null
#  resource_digest :string           not null
#  resource_token  :string           not null
#  season          :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  tmdb_mv_id      :integer
#  tmdb_tv_id      :integer
#

class Space < ApplicationRecord
  has_many :comments
  has_many :subscriptions
  has_many :users, through: :subscriptions
  enum media: %i[mv tv].freeze
  before_validation :create_resource_digest
  validates :name, presence: true
  validates :resource_token, presence: true
  validates :resource_digest, presence: true
  validates :media, presence: true
  with_options if: :mv? do |mv|
    mv.validates :tmdb_mv_id, presence: true, numericality: { only_integer: true }
  end
  with_options if: :tv? do |tv|
    tv.validates :season, presence: true, numericality: { only_integer: true }
    tv.validates :episode, presence: true, numericality: { only_integer: true }
    tv.validates :tmdb_tv_id, presence: true, numericality: { only_integer: true }
    tv.validates :episode_title, presence: true
  end

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def create_or_search_mv(space_params, user)
      set_log_level_for_production
      # fix => same name movie case.
      if @space = self.find_by(name: space_params[:name])
        @space.comments.update_all(confirmation: true)
        return @space
        logger.debug {"The space already exists."}
      else
        @space = self.create(
          name: space_params[:name], tmdb_mv_id: space_params[:tmdb_mv_id],
          image_path: space_params[:image_path]
        )
        return @space
        logger.debug {"New space is created by #{user.id}:#{user.email}."}
      end
    end

    def create_or_search_tv(space_params, user)
      set_log_level_for_production
      # fix => same name tv case.
      if @space = self.find_by(name: space_params[:name], season: space_params[:season], episode: space_params[:episode])
        @space.comments.update_all(confirmation: true)
        return @space
        logger.debug {"The space already exists."}
      else
        @space = self.create!(
          name: space_params[:name], season: space_params[:season], episode: space_params[:episode], media: space_params[:media],
          tmdb_tv_id: space_params[:tmdb_tv_id], episode_title: space_params[:episode_title], image_path: space_params[:image_path]
        )
        return @space
        logger.debug {"New space is created by #{user.id}:#{user.email}."}
      end
    end

    # Fix
    # params[:time] => realtime, hour, day, week, month
    # params[:record_count] => 0..**
    def getTrend(time)
      d = Date.yesterday - 1
      self.includes(:comments).where(comments: { created_at: d.all_day}).sort_by{|a| -a.comments.length }
    end

    private
      # for production
      def set_log_level_for_production
        Rails.logger.level = 0
      end
  end

  def unread_comments(user)
    self.comments.select{|comment| (comment.confirmation === false) && (comment.user_id != user.id )}
  end

  def authenticated? token
    BCrypt::Password.new(resource_digest).is_password?(token)
  end

  private
    def create_resource_digest
      self.resource_token = Space.new_token
      self.resource_digest = Space.digest resource_token
    end
end
