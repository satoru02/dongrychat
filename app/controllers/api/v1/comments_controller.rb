module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_space, only: [:index]

      def index
        @condition = current_user.subscribed?(@space.id)

        if (@condition === true) && (@space.comments_unconfirmed_by(current_user) > 0)
          @space.comments_confirmed_by(current_user)
        end

        @comments = @space.comments.order_by_latest.paginate(:page => params[:page], :per_page => params[:per_page])
        serializer = set_comment_serializer(@comments, @condition, params[:media])
        render_json(serializer)
      end

      private
        def set_space
          @space = Space.find_by(id: params[:id])
        end

        def set_comment_serializer(obj, condition, media)
          CommentSerializer.new(obj, enter_params(condition, media))
        end

        def enter_params(condition, media)
          { params: { condition: condition, media: media } }
        end
    end
  end
end