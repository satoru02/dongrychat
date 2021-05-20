module Api
  module V1
    class PasswordResetsController < ApplicationController
      before_action :set_user, only: [:edit, :update]
      KEYS = [:password, :password_confirmation].freeze

      def create
        @user = User.find_by(email: params[:email])
        if @user
          @user.generate_password_token!
          UserMailer.reset_password(@user).deliver_now
          response_success('ResetPassword', 'created')
        else
          response_not_found('User')
        end
      end

      def edit
        response_success('ResetPassword', 'edited')
      end

      def update
        @user.update!(password_params)
        @user.clear_password_token!
        JWTSessions::Session.new(namespace: "user_#{@user.id}").flush_namespaced
        response_success('ResetPassword', 'updated')
      end

      private

        def password_params
          params.tap { |p| p.require(KEYS) }.permit(*KEYS)
        end

        def set_user
          @user = User.find_by(reset_password_token: params[:token])
          raise ResetPasswordError unless @user&.reset_password_token_expires_at && @user.reset_password_token_expires_at > Time.now
        end
    end
  end
end