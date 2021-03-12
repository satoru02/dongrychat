module Api
  module V1
    class AccountActivationsController < ApplicationController
      def create
        user = User.find_by(activation_token: params[:token])
        if user && !user.activated? && user.authenticated?(:activation, params[:id])
          user.activate
          payload = { user_id: user.id, aud: [user.role] }
          session = JWTSessions::Session.new(
            payload: payload,
            refresh_by_access_allowed: true,
            namespace: "user_#{user.id}"
          )
          tokens = session.login
          response.set_cookie(
            JWTSessions.access_cookie,
            value: tokens[:access],
            httponly: true,
            path: "/"
          )
          render json: { csrf: tokens[:csrf], access_token: tokens[:access] }
        end
      end
    end
  end
end