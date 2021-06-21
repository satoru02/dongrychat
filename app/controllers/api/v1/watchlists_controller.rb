module Api
  module V1
    class WatchlistsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_watchlist, only: [:update, :destroy]

      def create
        @watchlist = Watchlist.new(watchlist_params)
        if @watchlist && @watchlist.save!
          response_success('Watchlist', 'created')
        else
          response_bad_request
        end
      end

      def update
        if @reservedList && @reservedList.update!(watchlist_params)
          response_success('Watchlist', 'updated')
        else
          response_bad_request
        end
      end

      def destroy
        if @reservedList && @reservedList.destroy!
          response_success('Watchlist', 'destroyed')
        else
          response_bad_request
        end
      end

      private

        def set_watchlist
          @reservedList = Watchlist.reserved(current_user, params[:space_id])
        end

        def watchlist_params
          params.require(:watchlist).permit(
            :status, :user_id, :space_id, :time, :comment
          )
        end
    end
  end
end