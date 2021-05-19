module Api
  module V1
    class TagsController < ApplicationController

      def index
        @tags = ActsAsTaggableOn::Tag.most_used(10)
        serializer = TagSerializer.new(@tags)
        render_json(serializer)
      end

      def members
        @spaces = Space.includes(:users, :tags).tagged_with(params[:name])
        @paged_spaces = @spaces.paginate(:page => params[:page], :per_page => params[:per_page])
        serializer = TrendSpaceSerializer.new(@paged_spaces)
        render_json(serializer)
      end
    end
  end
end