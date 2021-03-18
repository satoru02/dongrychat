module Api
  module V1
    class SubscriptionsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_subscription, only: [:show, :destroy]

      def create
        @subscription = Subscription.new(user_id: params[:user_id], space_id: params[:space_id])
        if @subscription.save!
          successed_subscribe
        else
          failed_subscribe
        end
      end

      def destroy
        @subscription.destroy!
      end

      private

        def set_subscription
          @subscription = Subscription.find_by(id: params[:id])
        end

        def successed_subscribe
          render json: :ok
        end

        def failed_subscribe
          render json: { error: "You has already subscribed this space." }, status: :not_found
        end
    end
  end
end