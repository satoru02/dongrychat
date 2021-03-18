#episode_title
#image_path
#tmdb_tv_id
#tmdb_mv_id

class Space < ApplicationRecord
  has_many :comments
  has_many :subscriptions
  has_many :users, through: :subscriptions
  enum media: %i[mv tv].freeze
  before_validation :create_resource_digest
  validates :name, presence: true
  validates :resource_token, presence: true
  validates :resource_digest, presence: true
  with_options if: :tv? do |tv|
    tv.validates :season, presence: true, numericality: { only_integer: true }
    tv.validates :episode, presence: true, numericality: { only_integer: true }
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

      if @space = self.find_by(name: space_params[:name])
        logger.debug {"The space already exists."}
        @space
      else
        logger.debug {"New space is created by #{user.id}:#{user.email}."}
        self.create(name: space_params[:name])
      end
    end

    def create_or_search_tv(space_params, user)

      set_log_level_for_production

      if @space = self.find_by(name: space_params[:name], season: space_params[:season], episode: space_params[:episode])
        logger.debug {"The space already exists."}
        @space
      else
        logger.debug {"New space is created by #{user.id}:#{user.email}."}
        self.create!(name: space_params[:name], season: space_params[:season], episode: space_params[:episode], media: space_params[:media])
      end
    end

    private
      # for production
      def set_log_level_for_production
        Rails.logger.level = 0
      end
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