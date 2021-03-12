module Api
  module V1
    class LoginController < ApplicationController
      before_action :authorize_access_request!, only: [:destroy]

      def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
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
        else
          not_found
        end
      end

      def destroy
        session = JWTSessions::Session.new(payload: payload, namespace: "user_#{payload['user_id']}")
        session.flush_by_access_payload
        render json: :ok
      end

      private

        def not_found
          render json: { error: "Cannot find such email/password combination" }, status: :not_found
        end
    end
  end
end