# frozen_string_literal: true

module Api
  # Api Password Controller
  class PasswordController < ApplicationController
    protect_from_forgery with: :null_session
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    # Generate ResetToken to user by email POST /api/password_reset
    def create
      user = User.find_by!(email_params)
      return unless user
      token = user.reset_tokens.create
      PasswordMailer.reset(token).deliver_later
      render json: { ok: true }, status: :created
    end

    private

    def email_params
      params.require(:password_reset).permit(:email)
    end

    def record_not_found
      head 404
    end
  end
end
