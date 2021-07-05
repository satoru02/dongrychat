module Api
  module V1
    class TagsController < ApplicationController

      def index
        @tags = ActsAsTaggableOn::Tag.most_used(5)
        serializer = TagSerializer.new(@tags)
        render_json(serializer)
      end

      def spaces
        @spaces = Space.includes(:users, :comments).has_comments.ascending_by_comments.tagged_with(params[:name]).filter_by(params)
        @paged_spaces = @spaces.paginate(:page => params[:page], :per_page => params[:per_page])
        serializer = TrendSpaceSerializer.new(@paged_spaces)
        render_json(serializer)
      end
    end
  end
end