module Api
  module V1
    class SubscriptionsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_subscription, only: [:create]
      before_action :get_subscription, only: [:destroy]

      def create
        if @subscription && @subscription.save!
          successed
        else
          failed_subscription
        end
      end

      def destroy
        if @subscription && @subscription.destroy!
          successed
        else
          failed_unsubscription
        end
      end

      private

        def set_subscription
          @subscription = Subscription.new(user_id: params[:user_id], space_id: params[:space_id])
        end

        def get_subscription
          @subscription = Subscription.find_by(user_id: params[:user_id], space_id: params[:space_id])
        end

        def successed
          render json: :ok
        end

        def failed_subscription
          render json: { error: "You has already subscribed this space." }, status: :not_found
        end

        def failed_unsubscription
          render json: { error: "error no subscription found" }, status: :not_found
        end
    end
  end
end