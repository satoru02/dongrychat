module Api
  module V1
    class SubscriptionsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_subscription, only: [:create]
      before_action :get_subscription, only: [:destroy]

      def create
        if @subscription && @subscription.save!
          response_success('Subscription', 'created')
        else
          response_bad_request
        end
      end

      def destroy
        if @subscription && @subscription.destroy!
          response_success('Subscription', 'destroyed')
        else
          response_bad_request
        end
      end

      private

        def set_subscription
          @subscription = Subscription.new(user_id: params[:user_id], space_id: params[:space_id])
        end

        def get_subscription
          @subscription = Subscription.find_by(user_id: params[:user_id], space_id: params[:space_id])
        end
    end
  end
end