# == Schema Information
#
# Table name: spaces
#
#  id               :bigint           not null, primary key
#  air_date         :string
#  comments_count   :integer
#  creators         :text             default([]), is an Array
#  episode          :integer
#  episode_title    :string
#  homepage         :string
#  image_path       :string
#  media            :integer          default("mv"), not null
#  name             :string           not null
#  overview         :text
#  resource_digest  :string           not null
#  resource_token   :string           not null
#  season           :integer
#  users_count      :integer
#  watchlists_count :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  tmdb_comp_id     :integer
#  tmdb_mv_id       :integer
#  tmdb_tv_id       :integer
#

class Space < ApplicationRecord
  has_many :comments, ->{ includes(:user) }, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :confirmations, dependent: :destroy
  has_many :users, through: :subscriptions
  has_many :reviews, dependent: :destroy
  has_many :watchlists, dependent: :destroy

  acts_as_taggable_on :tags

  scope :get_trend, -> (query){
    where(media: query[:media])
    # .where(comments: {:created_at => (Date.yesterday - 31).at_beginning_of_month..Date.today})
    # .sort_by{|space| -space.comments.size}
  }

  scope :get_popular, ->(query){
    where(media: query[:media])
    # .sort{|space| -space.users.length}
  }

  scope :order_by_comments, -> (user){
    sort_by{|space| -space.comments_unconfirmed_by(user)}
  }

  before_validation :create_resource_digest
  validates :name, presence: true
  validates :resource_token, presence: true
  validates :resource_digest, presence: true
  validates :media, presence: true
  enum media: %i[mv tv].freeze
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

    # fix => same name movie case.
    def create_or_search_mv(space_params, user)
      if @space = self.find_by(name: space_params[:name])
        return @space
      else
        @space = self.create(
          name: space_params[:name],
          tmdb_mv_id: space_params[:tmdb_mv_id],
          image_path: space_params[:image_path],
          overview: space_params[:overview],
          tag_list: space_params[:tag_list],
          air_date: space_params[:air_date],
          homepage: space_params[:homepage],
        )
        return @space
      end
    end

    # fix => same name tv case.
    def create_or_search_tv(space_params, user)
      #index
      if @space = self.find_by(name: space_params[:name], season: space_params[:season], episode: space_params[:episode])
        return @space
      else
        @space = self.create!(
          name: space_params[:name],
          season: space_params[:season],
          episode: space_params[:episode],
          media: space_params[:media],
          tmdb_comp_id: space_params[:tmdb_comp_id],
          tmdb_tv_id: space_params[:tmdb_tv_id],
          episode_title: space_params[:episode_title],
          image_path: space_params[:image_path],
          overview: space_params[:overview],
          tag_list: space_params[:tag_list],
          air_date: space_params[:air_date],
          homepage: space_params[:homepage],
          creators: space_params[:creators]
        )
        return @space
      end
    end
  end

  def comments_unconfirmed_by(user)
    # comments.size - confirmations.select{|conf| conf.user_id === user.id}.length
    comments.length - confirmations.select{|conf| conf.user_id === user.id}.length
  end

  def comments_confirmed_by(user)
    exme_comments = self.comments.select {|comment| comment.user_id != user.id }.pluck(:id)
    bulk_comments = exme_comments.map { |comment| { user_id: user.id, comment_id: comment, space_id: self.id } }
    Confirmation.insert_all(bulk_comments)
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
