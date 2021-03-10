module Api
  module V1
    class SignupController < ApplicationController
      KEYS = [:email, :password, :password_confirmation].freeze

      def create
        user = User.new(user_params)
        if user.save!
          user.generate_activation_token!
          user.send_activation_email
        else
          render json: { error: user.errors.full_messages.join(' ')}, status: :unprocessable_entity
        end
      end

      private

        def user_params
          params.tap { |p| p.require(KEYS)}.permit(*KEYS)
        end
    end
  end
end