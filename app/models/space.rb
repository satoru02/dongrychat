class Space < ApplicationRecord
  enum media: %i[mv tv].freeze
  validates :name, presence: true
  with_options if: :tv? do |tv|
    tv.validates :season, presence: true, numericality: { only_integer: true }
    tv.validates :episode, presence: true, numericality: { only_integer: true }
  end

  class << self
    def create_or_search_mv(space_params)
      if @space = self.find_by(name: space_params[:name])
        @space
      else
        self.create(name: space_params[:name])
      end
    end

    def create_or_search_tv(space_params)
      if @space = self.find_by(name: space_params[:name], season: space_params[:season], episode: space_params[:episode])
        @space
      else
        self.create(name: space_params[:name], season: space_params[:season], episode: space_params[:episode], media: space_params[:media])
      end
    end
  end
end
