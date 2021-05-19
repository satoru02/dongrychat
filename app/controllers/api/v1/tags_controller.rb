module Api
  module V1
    class TagsController < ApplicationController
      before_action :set_tag, only: [:show]

      def index
        @tags = ActsAsTaggableOn::Tag.most_used(10)
        serializer = TagSerializer.new(@tags)
        render_json(serializer)
      end

      def show
        @spaces = Space.includes(:users, :tags).tagged_with(@tag.name)
        @paged_spaces = @spaces.paginate(:page => params[:page], :per_page => params[:per_page])
        serializer = TrendSpaceSerializer.new(@paged_spaces)
        render_json(serializer)
      end

      private
        def set_tag
          @tag = ActsAsTaggableOn::Tag.find_by(id: params[:id])
        end
    end
  end
end