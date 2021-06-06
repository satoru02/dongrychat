module Api
  module V1
    class ReviewsController < ApplicationController
      before_action :authorize_access_request!
      before_action :new_reviews, only: [:create]
      before_action :set_review, only: [:edit, :update]

      def edit
        serializer = ReviewSerializer.new(@review)
        render_json(serializer)
      end

      def create
        if @review && @review.save!
          response_success('Reviews', 'created')
        else
          response_bad_request
        end
      end

      def destroy
        if @review && @review.destory!
          response_sucess('Reviews', 'destoryed')
        else
          reponse_bad_request
        end
      end

      private
        def new_reviews
          @review = Review.new(content: params[:content], user_id: params[:user_id], space_id: params[:space_id])
        end

        def set_review
          @review = Review.find_by(content: params[:content], user_id: params[:user_id], space_id: params[:space_id])
        end
    end
  end
end