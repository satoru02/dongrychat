module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authorize_access_request!

      def index
      end

      private
    end
  end
end